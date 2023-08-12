//
//  FirebaseApp.m
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 13/05/23.
//

#import <Foundation/Foundation.h>
#import "FirebaseApp.h"
@import FirebaseDatabase;

@implementation PostData

- (void)sendPost:(NSString *)string {
    // Get a reference to the Firebase Realtime Database
    FIRDatabaseReference *databaseRef = [[FIRDatabase database] reference];

    // Create a new child node at the "messages" location with a unique key
    FIRDatabaseReference *messagesRef = [databaseRef child:@"messages"];
    FIRDatabaseReference *newMessageRef = [messagesRef childByAutoId];
    NSString *refc= newMessageRef.key;
    // Set the data to be saved
    NSDictionary *message = @{
        @"id": refc,
        @"text": @"Hello, Firebase!",
        @"author": @"John Doe",
        @"timestamp": [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]]
    };

    // Save the data to the new child node
    [newMessageRef setValue:message];
    
}

@end




