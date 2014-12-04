//
//  ViewController.m
//  WatchDataMovement
//
//  Created by New on 12/2/14.
//  Copyright (c) 2014 Braen. All rights reserved.
//
// click on top-most left-most tab in the navigator to toggle App Groups on and off
// need App Groups to communicate between iphone and watch

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
//
// for some reason we need this to be a delegate look into
// i think it has to do with using method 2 to transfer data, aka every time you input something without
// specifc transmissiom, altho this seems sloppy and data intensive, promoting slowness

// connection to iphone text, where the string originates to be transferred
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.textField.delegate = self;
    // must load on start-up so if we check to word on the watch without changing anything
    // the word will still show up
    [self loadMessage:self];
}

// METHOD 1 for data transmission
- (IBAction)loadMessage:(id)sender
{
    [self setNewMessage];
    
    // seems to be duplicate code, only needs to be in the setNewMessage method
    // or we could do away with that method althogether...
    //
    // NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.add.something.whatever"];
    // NSString *msg = [sharedDefaults objectForKey:@"message"];
    // self.textField.text = msg;
    // NSLog(@"%@", msg);
}

- (void)setNewMessage
{
    NSLog(@"Setting message to %@", self.textField.text);
    
    // the magic behind it all, NSUserDefault handled within an App Group withSuiteName:@"..."
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.add.something.whatever"];
    [sharedDefaults setObject:self.textField.text forKey:@"message"];
    
    // dont forget to synchronize the the NSUserDefault!
    [sharedDefaults synchronize];
}


/*
// METHOD 2 for data transmission
// This seems to duplicate what is already being done
// only difference is whenever the tex field is modified it will send the changes to the NSUserDefault
// no need for a load button
// need for a delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self setNewMessage:self];
    return YES;
}
 
- (IBAction)setNewMessage:(id)sender {
    NSLog(@"Setting message to %@", self.textField.text);
    
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.add.something.whatever"];
    
    [sharedDefaults setObject:self.textField.text forKey:@"message"];
    [sharedDefaults synchronize];
}
*/

@end

