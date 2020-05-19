import { NativeModules, requireNativeComponent, ViewStyle } from 'react-native';

type CrispChatSdkType = {
  setTokenId(id: string): () => void;
  setLocale(locale: string): () => void;
  setUserEmail(email: string): () => void;
  setUserNickname(name: string): () => void;
  setUserPhone(phone: string): () => void;
  setUserAvatar(url: string): () => void;
  setSessionSegment(segment: string): () => void;
  resetSession(): () => void;
};

const { CrispChatSdk } = NativeModules;
export const CrispChatUI = requireNativeComponent(
  'CrispView'
) as React.ComponentClass<{ style: ViewStyle }, {}>;

export const CrispChatSDK = CrispChatSdk as CrispChatSdkType;
