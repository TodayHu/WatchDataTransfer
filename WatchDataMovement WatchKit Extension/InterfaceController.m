//
//  InterfaceController.m
//  WatchDataMovement WatchKit Extension
//
//  Created by New on 12/2/14.
//  Copyright (c) 2014 Braen. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *label;

@property (nonatomic) NSUserDefaults *sharedDefaults;
@property (nonatomic) NSString *message;

@end

@implementation InterfaceController

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        NSLog(@"%@ initWithContext", self);
        
    }
    return self;
}

// These methods are all we really need for getting the message on the watch
// update to write the msg to the label
- (IBAction)update {
    // Read NSUserDefaults to get the message
    NSString *msg = self.sharedMessage;
    NSLog(@"Message is %@", msg);
    self.label.text = msg;
}
// getting the NSUserDefault from the App Group with the name message
- (NSString *)sharedMessage {
    NSString *message = [self.sharedDefaults objectForKey:@"message"];
    
    return message;
}

// These methods are only needed when change the message
// aka, doing something on the watch to modify the text
// this seems contrary to what the apple watch is meant to do
// if it ever needs to be done though, here is the code
- (IBAction)changeMessage {
    NSString *msg = self.sharedMessage;
    NSString *newMsg = [msg stringByAppendingString:@"+"];
    self.message = newMsg;
    [self update];
}
- (void)setMessage:(NSString *)newMessage {
    [self.sharedDefaults setObject:newMessage forKey:@"message"];
}
- (void)defaultsChanged:(NSNotification *)info {
    NSLog(@"Defaults changed");
    [self update];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
    
    self.sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.add.something.whatever"];
    
    // Register for notification of changes in defaults
    // This doesn't seem to work yet -- if you change
    // the defaults from the host app the notification
    // does not happen.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(defaultsChanged:)
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:self.sharedDefaults];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
    self.sharedDefaults = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
