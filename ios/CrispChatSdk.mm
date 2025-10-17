#import "CrispChatSdk.h"
#import <React/RCTBridgeModule.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import <NativeCrispModuleSpec/NativeCrispModuleSpec.h>
#import "react-native-crisp-chat-sdk-Swift.h"
#endif

@implementation NativeCrispModule

RCT_EXPORT_MODULE(NativeCrispModule)

#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeCrispModuleSpecJSI>(params);
}
#endif

@end