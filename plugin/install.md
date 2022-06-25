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
          "websiteId": "YOUR_WEBSITE_ID"
        }
      ]
    ]
  }
}
```

Next, rebuild your app as described in the ["Adding custom native code"](https://docs.expo.io/workflow/customizing/) guide.
