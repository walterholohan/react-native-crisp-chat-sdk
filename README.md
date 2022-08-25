# react-native-crisp-chat-sdk

React-Native bridge for Crisp chat iOS and Android SDK&#39;s

![crisp screenshot](./screenshot.png)

## Features

- iOS & Android Support (In beta)
- Typescript Support
- [Expo](/plugin/install.md) support with custom dev client

## Installation

Install the library using either yarn or npm like so:

```sh
yarn add react-native-crisp-chat-sdk
```

```sh
npm install --save react-native-crisp-chat-sdk
```

## Expo support

This package is not available in the [Expo Go](https://expo.io/client) app. Learn how you can use it with [custom dev clients](/plugin/install.md).

### iOS Installation

If you're using React Native versions > 60.0, it's relatively straightforward.

```sh
cd ios && pod install
```

For versions below 0.60.0, use rnpm links

- Run `react-native link react-native-crisp-chat-sdk`
- If linking fails, follow the
  [manual linking steps](https://facebook.github.io/react-native/docs/linking-libraries-ios.html#manual-linking)

### iOS

## RN <= 0.67

Start using Crisp by adding the following code on your `AppDelegate.m` :

```objective-c
#import <Crisp/Crisp.h>

[CrispSDK configureWithWebsiteID:@"YOUR_WEBSITE_ID"];
```

## RN >= 0.68

Start using Crisp by adding the following code on your `AppDelegate.mm` :

```objective-c
#import <Crisp/Crisp-Swift.h>

[CrispSDK configureWithWebsiteID:@"YOUR_WEBSITE_ID"];
```

#### Update your Info.plist

To enable your users to take and upload photos to the chat as well as download photos to their photo library, add the
`Privacy - Camera Usage Description` ([NSCameraUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nscamerausagedescription)) and `Privacy - Photo Library Additions Usage Description` ([NSPhotoLibraryAddUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nsphotolibraryaddusagedescription)) to your app's Info.plist.

#### Additional Steps

This library was written in Swift, so in-order for you app to compile, you need to have at least one .swift file in your source code a bridging header to avoid a runtime error like so:

![swift error](./swift-error.png)

All you have to do is:

- File > New > File
- Swift File
- Name the file whatever you wish
- When prompted to create a bridging header, do so

### Android

Add our bintray in your repositories.

RN 0.65.0 has removed jscenter() but its important that we add it back in for now. Once the offical Crisp Android SDK removes this dependency we can revert back.

````groovy
repositories {
    // Keep your previous repositories
    mavenCentral()
}
```

Add the Crisp SDK in your dependencies in `app/build.gradle`:

```groovy
implementation 'im.crisp:crisp-sdk:1.0.13'
````

Configure your app for multidex:

```groovy
android {
    defaultConfig {
        multiDexEnabled true
    }
}
dependencies {
    // If you're using AndroidX
    implementation 'androidx.multidex:multidex:2.0.1'
    // If you're not using AndroidX
    implementation 'com.android.support:multidex:1.0.3'
}
```

Initialize the library in your [Application subclass](https://github.com/facebook/react-native/blob/master/template/android/app/src/main/java/com/helloworld/MainApplication.java)

```java
import im.crisp.client.Crisp;

// Fixes multiDex error
import androidx.multidex.MultiDexApplication;

public class MainApplication extends MultiDexApplication implements ReactApplication {

    @Override
    public void onCreate() {
        super.onCreate();

        // Replace it with your WEBSITE_ID
        // Retrieve it using https://app.crisp.chat/website/[YOUR_WEBSITE_ID]/
        Crisp.configure(getApplicationContext(),"YOUR_WEBSITE_ID");
    }
}
```

## Requirements

⚠️ Adding Camera and Photo permissions is mandatory, `NSCameraUsageDescription` and `NSPhotoLibraryUsageDescription` in `Info.plist`, to inform your users that you need to access to the Camera and Photo Library. You also have to enable **"iCloud Documents"** capability

## Get your website ID

Your website ID can be found in the Crisp App URL:

- https://app.crisp.chat/website/[WEBISTE_ID]/inbox/

Crisp Website ID is an UUID like e30a04ee-f81c-4935-b8d8-5fa55831b1c0

## Usage

You can view the [example project](./example/src/App.tsx) for more usage.

```js
import CrispChat, {
  setUserEmail,
  setUserNickname,
  setUserPhone,
  resetSession,
} from 'react-native-crisp-chat-sdk';

// ...
export default function App() {
  // this should be user ID that way app will load previous user chats
  setUserTokenId('abcd12345');

  // Set user's info
  setUserEmail('test@test.com');
  setUserNickname('John Smith');
  setUserPhone('+614430231224');

  // Call session reset when user loggs out
  resetSession();

  return <CrispChat />;
}
```

## Language management

Explicitly setting alternative languages from React is not currently supported. Nevertheless, the underlying SDK is able
to select automatically the locale matching the one of device. The locale detection works out-of-the-box on Android.
However, for the locale of the device to be detected on iOS apps, it has to be declared and setup in xcode as a
supported language.

Here is a suggested method for adding languages support to your app in Xcode 13:

Start by adding support for your particular language in your project info (`<yourProject>` > `Info` > `Localizations` >
`+`). To make it active, you also need to create at least one dummy StringFile (`File` > `New` > `File...`) with a
localized version matching the language you wish to add support to. After this step, if the locale of the device matches
the language you set up, it will be exposed by the app and chosen by the Crisp SDK. Note that alternative methods may
exist, but have not been tested regarding the locale detection of the Crisp SDK.

For iOS apps, debugging the preferred language exposed by your app can be achieved by adding the following line in your
AppDelegate.m file : `NSLog(@"localeIdentifier: %@", [[NSLocale currentLocale] localeIdentifier]);`

If for example, `localeIdentifier: en_FR` or `localeIdentifier: en_US` appears in your Xcode logs, then Crisp will be
displayed in english. If `localeIdentifier: fr_FR` appears in your Xcode logs, it will be displayed in french.

## Availables APIs:

- `CrispChatSDK.show()`
- `CrispChatSDK.setTokenId('userID/GUID')`
- `CrispChatSDK.pushSessionEvent(name: "Signup", color: CrispSessionEventColors.blue)`
- `CrispChatSDK.setUserEmail('test@test.com')`
- `CrispChatSDK.setUserNickname('John Doe')`
- `CrispChatSDK.setUserPhone('003370123456789')`
- `CrispChatSDK.setUserAvatar('https://pbs.twimg.com/profile_images/782474226020200448/zDo-gAo0_400x400.jpg')`
- `CrispChatSDK.setSessionSegment('segment')`
- `CrispChatSDK.setSessionString('key', 'value')`
- `CrispChatSDK.setSessionBool('key', 'value')`
- `CrispChatSDK.setSessionInt('key', 'value')`
- `CrispChatSDK.resetSession()`

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
