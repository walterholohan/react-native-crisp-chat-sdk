import { defaultBuildGradle } from './fixtures/buildGradle';
import { defaultAppDelegate } from './fixtures/appDelegate';
import {
  setAppDelegateCall,
  setAppDelegateImport,
  setGradleCrispDependency,
  setMainConfiguration,
} from '../withCrispChat';
import { defaultMainApplication } from './fixtures/mainApplication';

describe(setGradleCrispDependency, () => {
  it('add crisp dependency in build.gradle', () => {
    expect(
      setGradleCrispDependency(defaultBuildGradle, false)
    ).toMatchSnapshot();
  });
  it('add twice leads to same result', (): void => {
    expect(setGradleCrispDependency(defaultBuildGradle, false)).toMatch(
      setGradleCrispDependency(
        setGradleCrispDependency(defaultBuildGradle, false),
        false
      )
    );
  });
});

describe(setAppDelegateImport, () => {
  it('add crisp import', () => {
    expect(setAppDelegateImport(defaultAppDelegate)).toMatchSnapshot();
  });
});

describe(setAppDelegateCall, () => {
  it('add crisp call', () => {
    expect(
      setAppDelegateCall(defaultAppDelegate, 'TEST_WEBSITE_ID')
    ).toMatchSnapshot();
  });
});

describe(setMainConfiguration, (): void => {
  it('update MainApplication', (): void => {
    expect(
      setMainConfiguration(defaultMainApplication, 'TEST_WEBSITE_ID')
    ).toMatchSnapshot();
  });

  it('update twice leads to same result', (): void => {
    expect(
      setMainConfiguration(defaultMainApplication, 'TEST_WEBSITE_ID')
    ).toMatch(
      setGradleCrispDependency(
        setMainConfiguration(defaultMainApplication, 'TEST_WEBSITE_ID'),
        false
      )
    );
  });
});
