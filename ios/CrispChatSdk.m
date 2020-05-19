//
//  CrispViewManager.m
//  CrispChatSdk
//
//  Created by Walter Holohan on 09/05/2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "React/RCTViewManager.h"
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(CrispViewManager, RCTViewManager)
@end

@interface RCT_EXTERN_MODULE(CrispChatSdk, NSObject)
RCT_EXTERN_METHOD(setTokenId:(NSString *)id)
RCT_EXTERN_METHOD(setLocale:(NSString *)locale)
RCT_EXTERN_METHOD(setUserEmail:(NSString *)email)
RCT_EXTERN_METHOD(setUserNickname:(NSString *)name)
RCT_EXTERN_METHOD(setUserPhone:(NSString *)phone)
RCT_EXTERN_METHOD(setUserAvatar:(NSString *)url)
RCT_EXTERN_METHOD(setSessionSegment:(NSString *)segment)
RCT_EXTERN_METHOD(resetSession)
@end
