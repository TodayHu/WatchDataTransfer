//
//  ViewController.m
//  WatchDataMovement
//
//  Created by New on 12/2/14.
//  Copyright (c) 2014 Braen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

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
    [self loadMessage:self];
}

- (IBAction)loadMessage:(id)sender {
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.add.something.whatever"];
    NSString *msg = [sharedDefaults objectForKey:@"message"];
    self.textField.text = msg;
    NSLog(@"%@", msg);
}

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

@end

