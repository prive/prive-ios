//
//  CTChatController.m
//  Karizma
//
//  Created by Alexander Burkhai on 10/16/13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import "CTChatController.h"
#import "CTXMPPChat.h"
#import "CTBOChatTextMessage.h"

#define kCTTestUser1JID @"test1@priveim.com"
#define kCTTestUser1Password @"123"

#define kCTTestUser2JID @"test2@priveim.com"
#define kCTTestUser2Password @"123"

@interface CTChatController () <CTXMPPChatDelegate>
{
    NSString* myJID;
    NSString *myPassword;
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

- (void)dealloc
{
    [xmppChat removeDelegate:self delegateQueue:dispatch_get_main_queue()];
}

#pragma  mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    testUserSegmentedControl.enabled = !onlineButton.selected;
    [self segmentedControlValueChanged:testUserSegmentedControl];
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
    if (onlineButton.selected)
        [xmppChat connectWithJIDString:myJID password:myPassword];
    else
        [xmppChat disconnect];
}

- (IBAction)segmentedControlValueChanged:(id)sender
{
    if (sender == testUserSegmentedControl)
    {
        if (testUserSegmentedControl.selectedSegmentIndex == 0)
        {
            myJID = kCTTestUser1JID;
            myPassword = kCTTestUser1Password;
            recepientJID = kCTTestUser2JID;
        }
        else
        {
            myJID = kCTTestUser2JID;
            myPassword = kCTTestUser2Password;
            recepientJID = kCTTestUser1JID;
        }
    }
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
            CTBOChatTextMessage* message = [CTBOChatTextMessage new];
            message.from = xmppChat.xmppStream.myJID.bare;
            message.to = [CTXMPPChat xmppJIDFromString:recepientJID].bare;
            message.messageText = messageText;
            
            [xmppChat sendMessage:message];
        }
    }
}

#pragma mark - CTXMPPChatDelegate

- (void)xmppChat:(CTXMPPChat *)aXmppChat didReceiveMessage:(CTBOChatTextMessage *)aMessage
{
    lastMessagesTextView.text = [NSString stringWithFormat:@"%@\n%@", aMessage.messageText, lastMessagesTextView.text];
    [lastMessagesTextView scrollRectToVisible:CGRectMake(0, 0, lastMessagesTextView.frame.size.width, 20) animated:YES];
}

@end
