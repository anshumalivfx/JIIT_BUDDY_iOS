//
//  NSObject+AppDelegate.m
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 13/05/23.
//

#import "AppDelegate.h"
@import FirebaseCore;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [FIRApp configure];
    NSLog(@"hello");
  return YES;
}

@end
