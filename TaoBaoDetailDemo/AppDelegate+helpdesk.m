//
//  AppDelegate+helpdesk.m
//  IMHelpDeskDemo
//
//  Created by afanda on 6/2/17.
//  Copyright © 2017 easemob. All rights reserved.
//

#import "AppDelegate+helpdesk.h"

@implementation AppDelegate (helpdesk)
- (void)helpdeskApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    HOptions *option = [[HOptions alloc] init];
    option.appkey = kDefaultAppKey;
    option.tenantId = kDefaultTenantId;
//    option.kefuRestServer = @"https://sandbox.kefu.easemob.com";
    option.apnsCertName = @"";
    option.enableConsoleLog = YES;
    HError *error = [[HChatClient sharedClient] initializeSDKWithOptions:option];
    if (error == nil) {
        NSLog(@"初始化成功");
    } else {
        NSLog(@"初始化失败");
    }
}
@end
