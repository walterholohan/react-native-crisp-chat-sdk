#import "NativeCrispModule.h"
#import "react_native_crisp_chat_sdk-Swift.h"
#import <React/RCTBridgeModule.h>
#import <React/RCTUtils.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import <NativeCrispModuleSpec/NativeCrispModuleSpec.h>
  @interface NativeCrispModule () <NativeCrispModuleSpec>
  @end
#else
  @interface NativeCrispModule () <RCTBridgeModule>
  @end
#endif
@implementation NativeCrispModule

#ifndef RCT_NEW_ARCH_ENABLED
RCT_EXPORT_MODULE(NativeCrispModule)
#endif


- (void)configure:(NSString *)websiteId {
    [[NativeCrispModuleSwift shared] configure:websiteId];
}

- (void)setTokenId:(nullable NSString *)tokenId {
    [[NativeCrispModuleSwift shared] setTokenId:tokenId];
}

- (void)setUserEmail:(NSString *)email signature:(nullable NSString *)signature {
    [[NativeCrispModuleSwift shared] setUserEmail:email signature:signature];
}

- (void)setUserNickname:(NSString *)name {
    [[NativeCrispModuleSwift shared] setUserNickname:name];
}

- (void)setUserPhone:(NSString *)phone {
    [[NativeCrispModuleSwift shared] setUserPhone:phone];
}

#ifdef RCT_NEW_ARCH_ENABLED
- (void)setUserCompany:(JS::NativeCrispModule::Company &)company {

    NSMutableDictionary *companyDict = [NSMutableDictionary dictionary];

    companyDict[@"name"] = company.name();

    if (company.url()) {
        companyDict[@"url"] = company.url();
    }
    if (company.companyDescription()) {
        companyDict[@"companyDescription"] = company.companyDescription();
    }

    if (company.employment().has_value()) {
        auto emp = company.employment().value();
        NSMutableDictionary *empDict = [NSMutableDictionary dictionary];
        if (emp.title()) empDict[@"title"] = emp.title();
        if (emp.role()) empDict[@"role"] = emp.role();
        if (empDict.count > 0) {
            companyDict[@"employment"] = empDict;
        }
    }

    if (company.geolocation().has_value()) {
        auto geo = company.geolocation().value();
        NSMutableDictionary *geoDict = [NSMutableDictionary dictionary];
        if (geo.country()) geoDict[@"country"] = geo.country();
        if (geo.city()) geoDict[@"city"] = geo.city();
        if (geoDict.count > 0) {
            companyDict[@"geolocation"] = geoDict;
        }
    }

    [[NativeCrispModuleSwift shared] setUserCompany:companyDict];
}
#else
- (void)setUserCompany:(NSDictionary *)company {
    [[NativeCrispModuleSwift shared] setUserCompany:company];
}
#endif

- (void)setUserAvatar:(NSString *)url {
    [[NativeCrispModuleSwift shared] setUserAvatar:url];
}

- (void)setSessionSegment:(NSString *)segment {
    [[NativeCrispModuleSwift shared] setSessionSegment:segment];
}

- (void)setSessionSegments:(NSArray *)segments overwrite:(BOOL)overwrite {
    [[NativeCrispModuleSwift shared] setSessionSegments:segments overwrite:overwrite];
}

- (void)setSessionString:(NSString *)key value:(NSString *)value {
    [[NativeCrispModuleSwift shared] setSessionString:key value:value];
}

- (void)setSessionBool:(NSString *)key value:(BOOL)value {
    [[NativeCrispModuleSwift shared] setSessionBool:key value:value];
}

- (void)setSessionInt:(NSString *)key value:(double)value {
    [[NativeCrispModuleSwift shared] setSessionInt:key value:value];
}

- (void)getSessionIdentifier:(RCTPromiseResolveBlock)resolve
                     rejecter:(RCTPromiseRejectBlock)reject {
    [[NativeCrispModuleSwift shared] getSessionIdentifier:resolve rejecter:reject];
}

- (void)pushSessionEvent:(NSString *)name color:(double)color {
    [[NativeCrispModuleSwift shared] pushSessionEvent:name colorValue:color];
}

- (void)pushSessionEvents:(NSArray *)events {
    [[NativeCrispModuleSwift shared] pushSessionEvents:events];
}

- (void)resetSession {
    [[NativeCrispModuleSwift shared] resetSession];
}

- (void)show {
    [[NativeCrispModuleSwift shared] show];
}

- (void)searchHelpdesk {
    [[NativeCrispModuleSwift shared] searchHelpdesk];
}

- (void)openHelpdeskArticle:(NSString *)id
                     locale:(NSString *)locale
                      title:(nullable NSString *)title
                   category:(nullable NSString *)category {
    [[NativeCrispModuleSwift shared] openHelpdeskArticle:id locale:locale title:title category:category];
}

- (void)runBotScenario:(NSString *)scenarioId {
    [[NativeCrispModuleSwift shared] runBotScenario:scenarioId];
}

+ (NSString *)moduleName {
    return @"NativeCrispModule";
}

#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeCrispModuleSpecJSI>(params);
}
#endif

@end