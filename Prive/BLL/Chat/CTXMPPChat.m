//
//  CTXMPPChat.m
//  Prive
//
//  Created by Alexander Burkhai on 10/21/13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import "CTXMPPChat.h"
#import "CTBOChatTextMessage.h"

#import "DDLog.h"
#import "DDTTYLogger.h"

#if DEBUG
    static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
    static const int ddLogLevel = LOG_LEVEL_INFO;
#endif

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

+ (XMPPJID *)xmppJIDFromString:(NSString *)aJIDString
{
    return [XMPPJID jidWithString:aJIDString];
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
    
    NSParameterAssert(aJID);
    NSParameterAssert(aPassword);
        
    userJID = [self.class xmppJIDFromString:aJID];
    
	[xmppStream setMyJID:userJID];
	userPassword = [aPassword copy];
    
    NSError* error = nil;
	if (![xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error])
    {
        DDLogError(@"Error connecting: %@", error);
        return NO;
    }

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

#pragma mark - Messages

- (void)sendMessage:(CTBOChatMessage *)aChatMessage
{
    XMPPMessage* xmppMessage = [aChatMessage toXMPPMessage];
    [xmppStream sendElement:xmppMessage];
}

#pragma mark - XMPPStreamDelegate

- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    NSError* error = nil;
    if(![xmppStream authenticateWithPassword:userPassword error:&error])
    {
		DDLogError(@"Error authenticating: %@", error);
    }
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    [self goOnline];
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

- (void)xmppStream:(XMPPStream *)sender didReceiveError:(id)error
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    if(![presence.from.user isEqualToString:sender.myJID.user])
    {
        DDLogInfo(@"Presence from current user: %@", presence.from.user);
    }
}

- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)aMessage
{
    DDLogInfo(@"Received message: %@", aMessage);
    
    CTBOChatMessage* message = nil;
    
    if([aMessage isChatMessageWithBody])
        message = [[CTBOChatTextMessage alloc] initFromXMPPMessage:aMessage];
    else
        message = [[CTBOChatMessage alloc] initFromXMPPMessage:aMessage];
    
    if (message)
    {
        [multicastDelegate xmppChat:self didReceiveMessage:message];
    }
}

- (void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)aMessage
{
    CTBOChatMessage* message = nil;
    if([aMessage isChatMessageWithBody])
        message = [[CTBOChatTextMessage alloc] initFromXMPPMessage:aMessage];
    else
        message = [[CTBOChatMessage alloc] initFromXMPPMessage:aMessage];

    [multicastDelegate xmppChat:self didSendMessage:message];
}

@end
