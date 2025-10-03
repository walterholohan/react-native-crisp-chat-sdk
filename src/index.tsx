import * as React from 'react';
import { View } from 'react-native';
import NativeCrispModule, {
  Company,
  CrispSessionEventColors,
  Employment,
  Geolocation,
} from './NativeCrispModule';

const CrispChat = () => {
  React.useEffect(() => {
    NativeCrispModule.show();
  }, []);

  return <View />;
};

export default CrispChat;

export const configure = (websiteId: string) => {
  NativeCrispModule?.configure(websiteId);
};

export const setTokenId = (tokenId: string | null) => {
  NativeCrispModule?.setTokenId(tokenId);
};

export const setUserEmail = (email: string, signature: string | null) => {
  NativeCrispModule?.setUserEmail(email, signature);
};

export const setUserNickname = (name: string) => {
  NativeCrispModule?.setUserNickname(name);
};

export const setUserPhone = (phone: string) => {
  NativeCrispModule?.setUserPhone(phone);
};

export const setUserCompany = (company: Company) => {
  NativeCrispModule?.setUserCompany(company);
};

export const setUserAvatar = (url: string) => {
  NativeCrispModule?.setUserAvatar(url);
};

export const setSessionSegment = (segment: string) => {
  NativeCrispModule?.setSessionSegment(segment);
};

export const setSessionSegments = (segments: string[], overwrite?: boolean) => {
  NativeCrispModule?.setSessionSegments(segments, overwrite ?? false);
};

export const setSessionString = (key: string, value: string) => {
  NativeCrispModule?.setSessionString(key, value);
};

export const setSessionBool = (key: string, value: boolean) => {
  NativeCrispModule?.setSessionBool(key, value);
};

export const setSessionInt = (key: string, value: number) => {
  NativeCrispModule?.setSessionInt(key, value);
};

export async function getSessionIdentifier() {
  try {
    const sessionIdentifier = await NativeCrispModule?.getSessionIdentifier();
    return sessionIdentifier;
  } catch (e) {
    throw e;
  }
}

export const pushSessionEvent = (
  name: string,
  color: CrispSessionEventColors
) => {
  NativeCrispModule?.pushSessionEvent(name, color);
};

export const pushSessionEvents = (
  events: { name: string; color: CrispSessionEventColors }[]
) => {
  NativeCrispModule?.pushSessionEvents(events);
};

export const resetSession = () => {
  NativeCrispModule?.resetSession();
};

export const show = () => {
  NativeCrispModule?.show();
};

export const searchHelpdesk = () => {
  NativeCrispModule?.searchHelpdesk();
  NativeCrispModule?.show();
};

export const openHelpdeskArticle = (
  id: string,
  locale: string,
  title: string | null,
  category: string | null
) => {
  NativeCrispModule?.openHelpdeskArticle(id, locale, title, category);
  NativeCrispModule?.show();
};

export const runBotScenario = (scenarioId: string) => {
  NativeCrispModule?.runBotScenario(scenarioId);
};

export type { Company, Geolocation, Employment };
export { CrispSessionEventColors };
