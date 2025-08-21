# react-native-crisp-chat-sdk

React-Native bridge for Crisp chat iOS and Android SDK&#39;s

<img src="./assets/crisp_chat.png" width="375" alt="Crisp screenshot">

## Features

- iOS & Android Support
- Push Notifications support
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

This package supports Expo, however, since it's a wrapper on Crisp iOS and Android packages which are native libraries, it is not available in the [Expo Go](https://expo.io/client) app. Using Crisp with Expo is [explained here](/plugin/install.md).

### iOS Installation

Installing Crisp Native SDK is mandatory:

```sh
cd ios && pod install
```

### iOS

#### Update your Info.plist

To enable your users to take and upload photos to the chat as well as download photos to their photo library, add the
`Privacy - Camera Usage Description` ([NSCameraUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nscamerausagedescription)) and `Privacy - Photo Library Additions Usage Description` ([NSPhotoLibraryAddUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nsphotolibraryaddusagedescription)) to your app's Info.plist.

## Requirements

⚠️ Adding Camera and Photo permissions is mandatory, `NSCameraUsageDescription` and `NSPhotoLibraryUsageDescription` in `Info.plist`, to inform your users that you need to access to the Camera and Photo Library. You also have to enable **"iCloud Documents"** capability

## Get your website ID

Your website ID can be found in the Crisp App URL:

- https://app.crisp.chat/website/[WEBISTE_ID]/inbox/

Crisp Website ID is an UUID like e30a04ee-f81c-4935-b8d8-5fa55831b1c0

## Push Notifications Support

### Expo

When using Expo, push notifications are easy to set up and are covered in detail in the [Expo installation guide](/plugin/install.md#push-notifications-optional).

### React Native CLI

When using React Native CLI, you will need to manually add custom handlers in the Android and iOS packages. The procedures are detailed in the Crisp Developer Hub for both [iOS](https://docs.crisp.chat/guides/chatbox-sdks/ios-sdk/#5-implement-push-notifications-optional) and [Android](https://docs.crisp.chat/guides/chatbox-sdks/android-sdk/#2-enable-push-notifications-in-crisp-dashboard).

## Usage

You can view the [example project](./example/src/App.tsx) for more usage.

```js
import CrispChat, {
  configure,
  setUserEmail,
  setUserNickname,
  setUserPhone,
  resetSession,
} from 'react-native-crisp-chat-sdk';

// ...
export default function App() {
  // You must set your website ID before calling <CrispChat />
  configure('YOUR_WEBSITE_ID');

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

### Helpdesk

Use the Helpdesk APIs to open Crisp Helpdesk directly from your app.

```js
import {
  searchHelpdesk,
  openHelpdeskArticle,
} from 'react-native-crisp-chat-sdk';

// Open Helpdesk search UI
searchHelpdesk();

// Open a specific Helpdesk article by slug and locale
openHelpdeskArticle('my-article-slug', 'en');

// Optionally override title/category displayed by Crisp
openHelpdeskArticle('my-article-slug', 'fr', 'title', 'category');
```

#### Finding Article Parameters

To get the required parameters for `openHelpdeskArticle()`, follow these steps in your Crisp workspace:

1. Go to your Crisp web app (SaaS platform)
2. Navigate to your workspace
3. Select "Helpdesk" from the sidebar
4. Choose an article and click the eye icon to view it :

<img src="./assets/openHelpdeskArticle.png" alt="Crisp screenshot">

5. From the article URL, extract the parameters:

For example, with URL: `https://staging.crisp.help/fr/article/test-internal-link-2-6hkgyg/?bust=1755758362140`

- `id`: `6hkgyg` (the article slug at the end)
- `locale`: `fr` (the language code in the URL path)
- `title`: Optional - custom title to display (defaults to article's actual title)
- `category`: Optional - custom category to display (defaults to article's actual category)

#### Notes

- Both functions will automatically open the chat UI if it is not already open.
- `openHelpdeskArticle(id, locale, title?, category?)` expects the article slug as `id` and an IETF language tag for `locale` (e.g. `en`, `fr`).

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
- `CrispChatSDK.configure('YOUR_WEBSITE_ID')`
- `CrispChatSDK.searchHelpdesk()`
- `CrispChatSDK.openHelpdeskArticle(id: string, locale: string, title?: string, category?: string)`

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
