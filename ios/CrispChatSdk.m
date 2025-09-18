#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(CrispChatSdk, NSObject)

RCT_EXTERN_METHOD(configure:(NSString *)websiteId)
RCT_EXTERN_METHOD(setTokenId:(NSString * _Nullable)tokenID) 
RCT_EXTERN_METHOD(setUserEmail:(NSString *)email signature:(NSString * _Nullable)signature)
RCT_EXTERN_METHOD(setUserNickname:(NSString *)nickname)
RCT_EXTERN_METHOD(setUserPhone:(NSString *)phone)
RCT_EXTERN_METHOD(setUserCompany:(NSDictionary *)companyData)
RCT_EXTERN_METHOD(setUserAvatar:(NSString *)url)
RCT_EXTERN_METHOD(setSessionSegment:(NSString *)segment)
RCT_EXTERN_METHOD(setSessionSegments:(NSArray *)segments overwrite:(BOOL)overwrite)
RCT_EXTERN_METHOD(setSessionString:(NSString *)key value:(NSString *)value)
RCT_EXTERN_METHOD(setSessionBool:(NSString *)key value:(BOOL)value)
RCT_EXTERN_METHOD(setSessionInt:(NSString *)key value:(int)value)
RCT_EXTERN_METHOD(getSessionIdentifier:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(pushSessionEvent:(NSString *)eventName color:(NSInteger *)color)
RCT_EXTERN_METHOD(resetSession)
RCT_EXTERN_METHOD(show)
RCT_EXTERN_METHOD(searchHelpdesk)
RCT_EXTERN_METHOD(openHelpdeskArticle:(NSString *)id locale:(NSString *)locale title:(NSString *)title category:(NSString *)category)

@end