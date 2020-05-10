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
RCT_EXTERN_METHOD(setEmail:(NSString *)email)
@end
