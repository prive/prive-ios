//
//  CTChatController.m
//  Karizma
//
//  Created by Alexander Burkhai on 10/16/13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import "CTChatController.h"
#import "CTXMPPChat.h"

#define kCTTestUser1JID @"test1@priveim.com"
#define kCTTestUser1Password @"123"

#define kCTTestUser2JID @"test2@priveim.com"
#define kCTTestUser2Password @"123"

@interface CTChatController ()
{
    NSString* myJID;
    NSString* recepientJID;
    
    CTXMPPChat *xmppChat;
}

@end

@implementation CTChatController

- (id)init
{
    self = [super initWithNibName:@"CTChatController" bundle:nil];
    if (self)
    {
        xmppChat = [CTXMPPChat new];
        [xmppChat addDelegate:self delegateQueue:dispatch_get_main_queue()];
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
    onlineButton = nil;
    [super viewDidUnload];
}

#pragma mark - Actions

- (IBAction)onlineButtonPressed:(id)sender
{
    onlineButton.selected = !onlineButton.selected;
    testUserSegmentedControl.enabled = !onlineButton.selected;
    
}

- (IBAction)segmentedControlValueChanged:(id)sender
{
    
}

- (IBAction)sendButtonPressed:(id)sender
{
    if (onlineButton.selected)
    {
        NSString *messageText = inputTextField.text;
        messageText = [messageText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        inputTextField.text = @"";
        
        [inputTextField resignFirstResponder];
        
        if(messageText.length)
        {
        }
    }
}

@end
