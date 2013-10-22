//
//  CTXMPPChat.m
//  Karizma
//
//  Created by Alexander Burkhai on 10/21/13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import "CTXMPPChat.h"
#import "CTBOChatTextMessage.h"
#import "DDLog.h"

@implementation CTXMPPChat

@synthesize xmppStream;

#pragma mark - Init/Dealloc

- (id)init
{
    self = [super init];
    if(self)
    {
        [self configureXMPPStream];
        multicastDelegate = (GCDMulticastDelegate<CTXMPPChatDelegate>*)[GCDMulticastDelegate new];
    }
    return self;
}

- (void)dealloc
{
    [self closeXMPPStream];
}

#pragma mark - delegate

- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue
{
    [multicastDelegate addDelegate:delegate delegateQueue:delegateQueue];
}

- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue
{
    [multicastDelegate removeDelegate:delegate delegateQueue:delegateQueue];
}

#pragma mark - xmppStream

- (void)configureXMPPStream
{
    NSAssert(!xmppStream, @"xmppStream must be nil");
    
    xmppStream = [[XMPPStream alloc] init];
    xmppReconnect = [[XMPPReconnect alloc] init];
    
    [xmppReconnect activate:xmppStream];
    [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

- (void)closeXMPPStream
{
    [xmppStream removeDelegate:self];
    [xmppReconnect deactivate];
    [xmppStream disconnect];
    
    xmppStream = nil;
    xmppReconnect = nil;
}

#pragma mark - Connection

- (BOOL)connectWithJIDString:(NSString*)aJID password:(NSString*)aPassword
{
    if(![xmppStream isDisconnected])
        return YES;
    


    return YES;
}

- (void)disconnect
{
    [self goOffline];
    [xmppStream disconnect];
}

#pragma mark - Presence

- (void)goOnline
{
    XMPPPresence* presence = [XMPPPresence presence];
    [xmppStream sendElement:presence];
}

- (void)goOffline
{
    XMPPPresence* presence = [XMPPPresence presenceWithType:@"unavailable"];
    [xmppStream sendElement:presence];
}

@end
