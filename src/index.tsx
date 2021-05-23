import * as React from 'react';
import { NativeModules, View } from 'react-native';

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
  setSessionString(key: string, value: string): () => void;
  setSessionBool(key: string, value: boolean): () => void;
  setSessionInt(key: string, value: number): () => void;
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

export const setTokenId = (id: string) => {
  CrispChatSdk.setTokenId(id);
};

export const setUserEmail = (email: string) => {
  CrispChatSdk.setUserEmail(email);
};

export const setUserNickname = (name: string) => {
  CrispChatSdk.setUserNickname(name);
};

export const setUserPhone = (phone: string) => {
  CrispChatSdk.setUserPhone(phone);
};

export const setUserAvatar = (url: string) => {
  CrispChatSdk.setUserAvatar(url);
};

export const setSessionSegment = (segment: string) => {
  CrispChatSdk.setSessionSegment(segment);
};

export const setSessionString = (key: string, value: string) => {
  CrispChatSdk.setSessionString(key, value);
};

export const setSessionBool = (key: string, value: boolean) => {
  CrispChatSdk.setSessionBool(key, value);
};

export const setSessionInt = (key: string, value: number) => {
  CrispChatSdk.setSessionInt(key, value);
};

export const pushSessionEvent = (
  name: string,
  color: CrispSessionEventColors
) => {
  CrispChatSdk.pushSessionEvent(name, color);
};

export const resetSession = () => {
  CrispChatSdk.resetSession();
};

export const show = () => {
  CrispChatSdk.show();
};
