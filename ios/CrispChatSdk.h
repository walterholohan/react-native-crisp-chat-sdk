#import <Foundation/Foundation.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import <NativeCrispModuleSpec/NativeCrispModuleSpec.h>

@interface NativeCrispModule : NSObject <NativeCrispModuleSpec>
#else
#import <React/RCTBridgeModule.h>

@interface NativeCrispModule : NSObject <RCTBridgeModule>
#endif

@end
