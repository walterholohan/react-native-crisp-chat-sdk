import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

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

export interface Employment {
  title?: string;
  role?: string;
}

export interface Geolocation {
  country?: string;
  city?: string;
}

export interface Company {
  name: string;
  url?: string;
  companyDescription?: string;
  employment?: Employment;
  geolocation?: Geolocation;
}

export interface Spec extends TurboModule {
  setTokenId(tokenId: string | null): void;
  setUserEmail(email: string, signature: string | null): void;
  setUserNickname(name: string): void;
  setUserPhone(phone: string): void;
  setUserCompany(company: Company): void;
  setUserAvatar(url: string): void;
  setSessionSegment(segment: string): void;
  setSessionSegments(segments: string[], overwrite: boolean): void;
  setSessionString(key: string, value: string): void;
  setSessionBool(key: string, value: boolean): void;
  setSessionInt(key: string, value: number): void;
  getSessionIdentifier(): Promise<string | null>;
  pushSessionEvent(name: string, color: CrispSessionEventColors): void;
  pushSessionEvents(
    events: { name: string; color: CrispSessionEventColors }[]
  ): void;
  resetSession(): void;
  show(): void;
  configure(websiteId: string): void;
  searchHelpdesk(): void;
  openHelpdeskArticle(
    id: string,
    locale: string,
    title: string | null,
    category: string | null
  ): void;
  runBotScenario(scenarioId: string): void;
}

export default TurboModuleRegistry.getEnforcing<Spec>('NativeCrispModule');
