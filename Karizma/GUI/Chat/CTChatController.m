//
//  CTChatController.m
//  Karizma
//
//  Created by Alexander Burkhai on 10/16/13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import "CTChatController.h"

#define kCTTestUser1JID @"test1@priveim.com"
#define kCTTestUser1Password @"123"

#define kCTTestUser2JID @"test2@priveim.com"
#define kCTTestUser2Password @"123"

@interface CTChatController ()
{
    
}

@end

@implementation CTChatController

- (id)init
{
    self = [super initWithNibName:@"CTChatController" bundle:nil];
    if (self)
    {
        
    }
    return self;
}

#pragma  mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    testUserSegmentedControl = nil;
    inputTextField = nil;
    lastMessagesTextView = nil;
    [super viewDidUnload];
}

#pragma mark - Actions

- (IBAction)segmentedControlValueChanged:(id)sender
{
    
}

- (IBAction)sendButtonPressed:(id)sender
{
}

@end
