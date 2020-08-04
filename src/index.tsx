import { NativeModules, requireNativeComponent, ViewStyle } from 'react-native';

export enum CrispSessionEventColors {
  RED = 0,
  ORANGE = 1,
  YELLOW = 2,
  GREEN = 3,
  BLUE = 4,
  PURPLE = 5,
  PINK = 6,
  BROWN = 7,
  GREY = 8,
  BLACK = 9,
}

type CrispChatSdkType = {
  setTokenId(id: string): () => void;
  setUserEmail(email: string): () => void;
  setUserNickname(name: string): () => void;
  setUserPhone(phone: string): () => void;
  setUserAvatar(url: string): () => void;
  setSessionSegment(segment: string): () => void;
  pushSessionEvent(name: string, color: CrispSessionEventColors): () => void;
  resetSession(): () => void;
  show(): () => void;
};

const { CrispChatSdk } = NativeModules;
export const CrispChatUI = requireNativeComponent(
  'CrispView'
) as React.ComponentClass<{ style: ViewStyle }, {}>;

export const CrispChatSDK = CrispChatSdk as CrispChatSdkType;
