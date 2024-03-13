import {
  withAppBuildGradle,
  withMainApplication,
  withAppDelegate,
  createRunOncePlugin,
  ConfigPlugin,
} from '@expo/config-plugins';

import { mergeContents } from '@expo/config-plugins/build/utils/generateCode';

const withReactNativeCrisp: ConfigPlugin<{ websiteId?: string }> = (
  expoConfig,
  { websiteId = 'YOUR_WEBSITE_ID' } = {}
) => {
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
      modConfig.modResults.contents
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

  const cripsImport = /import im.crisp.client.Crisp;/g;
  if (!main.match(cripsImport)) {
    result = result.replace(
      /public class MainApplication extends MultiDexApplication implements ReactApplication {/,
      `import im.crisp.client.Crisp;
      
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

export function setGradleCrispDependency(buildGradle: string) {
  const crispDependency = /implementation 'im.crisp:crisp-sdk:2.0.0beta1'/g;
  let result = buildGradle;
  if (!result.match(crispDependency)) {
    result = result.replace(
      /dependencies\s?{/,
      `dependencies {
    implementation 'im.crisp:crisp-sdk:2.0.0beta1'`
    );
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

export default createRunOncePlugin(
  withReactNativeCrisp,
  'react-native-crisp-chat-sdk'
);
