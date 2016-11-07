//
//  MPKitAppsFlyerTest.m
//
//  Copyright 2016 mParticle, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "MPKitAppsFlyerTest.h"
#import "mParticle.h"

NSString *const afAppleAppId = @"appleAppId";
NSString *const afDevKey = @"devKey";

@implementation MPKitAppsFlyerTest

+ (NSNumber *)kitCode {
    return @92;
}

- (instancetype)initWithConfiguration:(NSDictionary *)configuration startImmediately:(BOOL)startImmediately {
    self = [super init];
    NSString *appleAppId = configuration[afAppleAppId];
    NSString *devKey = configuration[afDevKey];
    if (!self || !appleAppId || !devKey) {
        return nil;
    }
    
    _configuration = configuration;
    _started = startImmediately;
    
    BOOL alreadyActive = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (alreadyActive) {
            [self didBecomeActive];
        }
        NSDictionary *userInfo = @{mParticleKitInstanceKey:[[self class] kitCode]};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:mParticleKitDidBecomeActiveNotification
                                                            object:nil
                                                          userInfo:userInfo];
    });
    
    return self;
}

- (nonnull MPKitExecStatus *)didBecomeActive {
    MPKitExecStatus *execStatus = [[MPKitExecStatus alloc] initWithSDKCode:@(MPKitInstanceAppsFlyer) returnCode:MPKitReturnCodeSuccess];
    return execStatus;
}

- (nonnull MPKitExecStatus *)openURL:(nonnull NSURL *)url options:(nullable NSDictionary<NSString *, id> *)options {
    MPKitExecStatus *execStatus = [[MPKitExecStatus alloc] initWithSDKCode:@(MPKitInstanceAppsFlyer) returnCode:MPKitReturnCodeSuccess];
    return execStatus;
}

- (nonnull MPKitExecStatus *)openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nullable id)annotation {
    MPKitExecStatus *execStatus = [[MPKitExecStatus alloc] initWithSDKCode:@(MPKitInstanceAppsFlyer) returnCode:MPKitReturnCodeSuccess];
    return execStatus;
}

- (nonnull MPKitExecStatus *)continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(void(^ _Nonnull)(NSArray * _Nullable restorableObjects))restorationHandler {
    MPKitExecStatus *execStatus = [[MPKitExecStatus alloc] initWithSDKCode:@(MPKitInstanceAppsFlyer) returnCode:MPKitReturnCodeSuccess];
    return execStatus;
}
- (nonnull MPKitExecStatus *)didUpdateUserActivity:(nonnull NSUserActivity *)userActivity {
    MPKitExecStatus *execStatus = [[MPKitExecStatus alloc] initWithSDKCode:@(MPKitInstanceAppsFlyer) returnCode:MPKitReturnCodeSuccess];
    return execStatus;
}

- (nonnull MPKitExecStatus *)receivedUserNotification:(nonnull NSDictionary *)userInfo {
    MPKitExecStatus *execStatus = [[MPKitExecStatus alloc] initWithSDKCode:@(MPKitInstanceAppsFlyer) returnCode:MPKitReturnCodeSuccess];
    return execStatus;
}

- (nonnull MPKitExecStatus *)setUserIdentity:(nullable NSString *)identityString identityType:(MPUserIdentity)identityType {
    MPKitExecStatus *execStatus;
    if (identityType == MPUserIdentityCustomerId) {
        execStatus = [[MPKitExecStatus alloc] initWithSDKCode:@(MPKitInstanceAppsFlyer) returnCode:MPKitReturnCodeSuccess];
    } else if (identityType == MPUserIdentityEmail) {
        execStatus = [[MPKitExecStatus alloc] initWithSDKCode:@(MPKitInstanceAppsFlyer) returnCode:MPKitReturnCodeSuccess];
    } else {
        execStatus = [[MPKitExecStatus alloc] initWithSDKCode:@(MPKitInstanceAppsFlyer) returnCode:MPKitReturnCodeFail];
    }
    return execStatus;
}

- (nonnull MPKitExecStatus *)logCommerceEvent:(nonnull MPCommerceEvent *)commerceEvent {
    MPKitExecStatus *execStatus;
    MPCommerceEventAction action = commerceEvent.action;
    if (action == MPCommerceEventActionAddToCart ||
        action == MPCommerceEventActionAddToWishList ||
        action == MPCommerceEventActionCheckout ||
        action == MPCommerceEventActionPurchase)
    {
        if (action == MPCommerceEventActionAddToCart || action == MPCommerceEventActionAddToWishList) {
            NSArray<MPProduct *> *products = commerceEvent.products;
            if (products && [products count] != 0) {
                execStatus = [[MPKitExecStatus alloc] initWithSDKCode:@(MPKitInstanceAppsFlyer) returnCode:MPKitReturnCodeSuccess forwardCount:0];
                for (NSUInteger i = 0; i < products.count; ++i) {
                    [execStatus incrementForwardCount];
                }
            } else {
                execStatus = [[MPKitExecStatus alloc] initWithSDKCode:@(MPKitInstanceAppsFlyer) returnCode:MPKitReturnCodeRequirementsNotMet];
            }
        } else {
            execStatus = [[MPKitExecStatus alloc] initWithSDKCode:@(MPKitInstanceAppsFlyer) returnCode:MPKitReturnCodeSuccess];
        }
    } else {
        execStatus = [[MPKitExecStatus alloc] initWithSDKCode:@(MPKitInstanceAppsFlyer) returnCode:MPKitReturnCodeSuccess forwardCount:0];
        NSArray *expandedInstructions = [commerceEvent expandedInstructions];
        for (MPCommerceEventInstruction *commerceEventInstruction in expandedInstructions) {
            [self logEvent:commerceEventInstruction.event];
            [execStatus incrementForwardCount];
        }
    }
    
    return execStatus;
}

- (nonnull MPKitExecStatus *)logEvent:(nonnull MPEvent *)event {
    MPKitExecStatus *execStatus = [[MPKitExecStatus alloc] initWithSDKCode:@(MPKitInstanceAppsFlyer) returnCode:MPKitReturnCodeSuccess];
    return execStatus;
}

- (nonnull MPKitExecStatus *)setOptOut:(BOOL)optOut {
    MPKitExecStatus *execStatus = [[MPKitExecStatus alloc] initWithSDKCode:@(MPKitInstanceAppsFlyer) returnCode:MPKitReturnCodeSuccess];
    return execStatus;
}

@end
