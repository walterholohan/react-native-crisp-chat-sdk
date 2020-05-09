import { NativeModules } from 'react-native';

type CrispChatSdkType = {
  multiply(a: number, b: number): Promise<number>;
};

const { CrispChatSdk } = NativeModules;

export default CrispChatSdk as CrispChatSdkType;
