//
//  FirebaseApp.h
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 13/05/23.
//

#ifndef FirebaseApp_h
#define FirebaseApp_h

#import <SwiftUI/SwiftUI.h>
@import FirebaseDatabase;

@interface PostData : NSObject

- (void) sendPost: (NSString *) string;

@end

#endif /* FirebaseApp_h */
