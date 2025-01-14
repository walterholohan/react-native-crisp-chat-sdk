import {
  withAppBuildGradle,
  withMainApplication,
  withAppDelegate,
  withAndroidManifest,
  createRunOncePlugin,
  ConfigPlugin,
} from '@expo/config-plugins';

import { mergeContents } from '@expo/config-plugins/build/utils/generateCode';

const withReactNativeCrisp: ConfigPlugin<{
  websiteId?: string;
  notifications?: {
    enabled: boolean;
  };
}> = (
  expoConfig,
  { websiteId = 'YOUR_WEBSITE_ID', notifications = { enabled: false } } = {}
) => {
  if (notifications.enabled) {
    expoConfig = withAndroidManifest(expoConfig, (config) => {
      config.modResults = setAndroidManifestService(config.modResults);
      return config;
    });
  }

  withAppDelegate(expoConfig, (modConfig) => {
    if (['objc', 'objcpp'].includes(modConfig.modResults.language)) {
      modConfig.modResults.contents = setAppDelegateImport(
        modConfig.modResults.contents
      ).contents;

      modConfig.modResults.contents = setAppDelegateCall(
        modConfig.modResults.contents,
        websiteId
      ).contents;
    }

    return modConfig;
  });

  withAppBuildGradle(expoConfig, (modConfig) => {
    modConfig.modResults.contents = setGradleCrispDependency(
      modConfig.modResults.contents,
      notifications.enabled
    );

    return modConfig;
  });

  return withMainApplication(expoConfig, (modConfig) => {
    modConfig.modResults.contents = setMainConfiguration(
      modConfig.modResults.contents,
      websiteId
    );

    return modConfig;
  });
};

export function setAppDelegateImport(src: string) {
  return mergeContents({
    tag: 'react-native-crisp-chat-sdk',
    src,
    newSrc: '#import <Crisp/Crisp-Swift.h>',
    anchor: /#import "AppDelegate\.h"/,
    offset: 1,
    comment: '//',
  });
}

export function setAppDelegateCall(src: string, websiteId: string) {
  return mergeContents({
    tag: 'react-native-crisp-chat-sdk-call',
    src,
    newSrc: `[CrispSDK configureWithWebsiteID:@"${websiteId}"];`,
    anchor:
      /- \(BOOL\)application:\(UIApplication \*\)application didFinishLaunchingWithOptions:\(NSDictionary \*\)launchOptions/,
    offset: 2,
    comment: '//',
  });
}

export function setMainConfiguration(main: string, websiteId: string) {
  const multiDexApp =
    /public class MainApplication extends MultiDexApplication implements ReactApplication {/g;
  let result = main;
  if (!main.match(multiDexApp)) {
    result = result.replace(
      /public class MainApplication extends Application implements ReactApplication {/,
      `import androidx.multidex.MultiDexApplication;

public class MainApplication extends MultiDexApplication implements ReactApplication {
      `
    );
  }

  const cripsImport = /import im.crisp.client.external.Crisp;/g;
  if (!main.match(cripsImport)) {
    result = result.replace(
      /public class MainApplication extends MultiDexApplication implements ReactApplication {/,
      `import im.crisp.client.external.Crisp;
      
public class MainApplication extends MultiDexApplication implements ReactApplication {`
    );
  }

  const cripWebsiteConfig =
    /Crisp\.configure\(getApplicationContext\(\),"(\w|\d|-)+"\);/g;
  if (!main.match(cripWebsiteConfig)) {
    result = result.replace(
      /super\.onCreate\(\);/,
      `super.onCreate();
    Crisp.configure(getApplicationContext(),"${websiteId}");
`
    );
  }

  return result;
}

export function setGradleCrispDependency(
  buildGradle: string,
  notificationsEnabled: boolean
) {
  let result = buildGradle;

  const crispDependency = /implementation 'im.crisp:crisp-sdk:2.0.9'/g;

  if (!result.match(crispDependency)) {
    result = result.replace(
      /dependencies\s?{/,
      `dependencies {
    implementation 'im.crisp:crisp-sdk:2.0.9'`
    );
  }

  if (notificationsEnabled) {
    const firebaseMessaging =
      /implementation 'com.google.firebase:firebase-messaging'/g;
    if (!result.match(firebaseMessaging)) {
      result = result.replace(
        /dependencies\s?{/,
        `dependencies {
    implementation 'com.google.firebase:firebase-messaging'`
      );
    }
  }

  const multiDex = /implementation 'androidx.multidex:multidex:2.0.1'/g;
  if (!result.match(multiDex)) {
    result = result.replace(
      /dependencies\s?{/,
      `dependencies {
    implementation 'androidx.multidex:multidex:2.0.1'`
    );
  }

  const multiDexConfig = /multiDexEnabled true/g;
  if (!result.match(multiDexConfig)) {
    result = result.replace(
      /defaultConfig\s?{/,
      `defaultConfig {
        multiDexEnabled true`
    );
  }

  return result;
}

export function setAndroidManifestService(androidManifest: any) {
  const mainApplication = androidManifest.manifest.application[0];

  if (!mainApplication.service) {
    mainApplication.service = [];
  }

  const crispService = mainApplication.service.find(
    (service: any) =>
      service.$?.['android:name'] ===
      'im.crisp.client.external.notification.CrispNotificationService'
  );

  if (!crispService) {
    mainApplication.service.push({
      '$': {
        'android:name':
          'im.crisp.client.external.notification.CrispNotificationService',
        'android:exported': 'false',
      },
      'intent-filter': [
        {
          action: [
            {
              $: {
                'android:name': 'com.google.firebase.MESSAGING_EVENT',
              },
            },
          ],
        },
      ],
    });
  }

  return androidManifest;
}

export default createRunOncePlugin(
  withReactNativeCrisp,
  'react-native-crisp-chat-sdk'
);
