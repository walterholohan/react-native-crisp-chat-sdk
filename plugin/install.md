# Expo installation

> This package cannot be used in the "Expo Go" app because [it requires custom native code](https://docs.expo.io/workflow/customizing/).

First install the package with yarn, npm, or with [`expo-cli`](https://docs.expo.io/workflow/expo-cli/#expo-install).

```sh
expo install react-native-crisp-chat-sdk expo-build-properties
```

`expo-build-properties` is needed to set ios `deploymentTarget` to `13.0` which is the minimum version required by crisp sdk

After installing this npm package, add the two [config plugins](https://docs.expo.io/guides/config-plugins/) to the [`plugins`](https://docs.expo.io/versions/latest/config/app/#plugins) array of your `app.json` or `app.config.js`:

```json
{
  "expo": {
    "plugins": [
      [
        "expo-build-properties",
        {
          "ios": {
            "deploymentTarget": "13.0"
          }
        }
      ],
      [
        "react-native-crisp-chat-sdk",
        {
          "websiteId": "YOUR_WEBSITE_ID",
          "notifications": {
            "enabled": false
          }
        }
      ]
    ]
  }
}
```

Next, rebuild your app as described in the ["Adding custom native code"](https://docs.expo.io/workflow/customizing/) guide.

## Push Notifications (Optional)

Push notifications can be easily supported. For this update your app `app.json` by enabling `notifications.enabled`.

### Android

Enabling push notifications for Android requires:

1. Placing the `google-services.json` at the root of your Expo project
2. Configuring server-side settings in the Crisp Dashboard:
   - Go to Settings > Chatbox Settings > Push Notifications
   - Enable Android push notifications
   - Upload your Firebase Server key (found in Firebase Console > Project Settings > Cloud Messaging)
   - Upload your Firebase Sender ID (found in Firebase Console > Project Settings > Cloud Messaging)

The full procedure is detailed on the [Crisp Developer Hub](https://docs.crisp.chat/guides/chatbox-sdks/android-sdk/#2-enable-push-notifications-in-crisp-dashboard)

Note: Firebase as well as any native code to handle push notifications will be automatically installed by the Crisp React Native Expo Package.


### iOS
Enabling push notifications for iOS requires:

Configuring your Apple Push Notification service (APNs) certificate:
   - Generate an APNs certificate in your Apple Developer account
   - Go to Settings > Chatbox Settings > Push Notifications in Crisp Dashboard
   - Enable iOS push notifications
   - Upload your APNs certificate (.p8 file)

The full procedure is detailed on the [Crisp Developer Hub](https://docs.crisp.chat/guides/chatbox-sdks/ios-sdk/#5-implement-push-notifications-optional)

Note: Firebase as well as any native code to handle push notifications will be automatically installed by the Crisp React Native Expo Package.
