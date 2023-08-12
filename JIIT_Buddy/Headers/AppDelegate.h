//
//  NSObject+AppDelegate.h
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 13/05/23.
//

#import <SwiftUI/SwiftUI.h>
#include <UserNotifications/UserNotifications.h>
#import <FIRMessaging.h>


NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate: UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate, FIRMessagingDelegate>

@end

NS_ASSUME_NONNULL_END
