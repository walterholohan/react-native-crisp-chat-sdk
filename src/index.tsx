import * as React from 'react';
import { NativeModules, Platform, View } from 'react-native';

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

const CrispChatSdk = NativeModules.CrispChatSdk as CrispChatSdkType;

const CrispChat: React.FC = () => {
  React.useEffect(() => {
    CrispChatSdk.show();
  }, []);

  return <View />;
};

export default CrispChat;

export const CrispChatSDK = CrispChatSdk as CrispChatSdkType;

export const setTokenId = (id: string) => {
  if (Platform.OS === 'ios') {
    CrispChatSdk.setTokenId(id);
  }
};

export const setUserEmail = (email: string) => {
  if (Platform.OS === 'ios') {
    CrispChatSdk.setUserEmail(email);
  }
};

export const setUserNickname = (name: string) => {
  if (Platform.OS === 'ios') {
    CrispChatSdk.setUserNickname(name);
  }
};

export const setUserPhone = (phone: string) => {
  if (Platform.OS === 'ios') {
    CrispChatSdk.setUserPhone(phone);
  }
};

export const setUserAvatar = (url: string) => {
  if (Platform.OS === 'ios') {
    CrispChatSdk.setUserAvatar(url);
  }
};

export const setSessionSegment = (segment: string) => {
  if (Platform.OS === 'ios') {
    CrispChatSdk.setSessionSegment(segment);
  }
};

export const pushSessionEvent = (
  name: string,
  color: CrispSessionEventColors
) => {
  if (Platform.OS === 'ios') {
    CrispChatSdk.pushSessionEvent(name, color);
  }
};

export const resetSession = () => {
  if (Platform.OS === 'ios') {
    CrispChatSdk.resetSession();
  }
};

export const show = () => {
  CrispChatSdk.show();
};
