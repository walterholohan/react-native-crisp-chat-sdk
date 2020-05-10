import { NativeModules, requireNativeComponent, ViewStyle } from 'react-native';

type CrispChatSdkType = {
  setEmail(email: string): () => void;
};

const { CrispChatSdk } = NativeModules;
export const CrispChatUI = requireNativeComponent(
  'CrispView'
) as React.ComponentClass<{ style: ViewStyle }, {}>;

export const CrispChatSDK = CrispChatSdk as CrispChatSdkType;
