//
//  CTXMPPChat.h
//  Karizma
//
//  Created by Alexander Burkhai on 10/21/13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"
#import "XMPPReconnect.h"

#import "CTBOChatMessage.h"

@protocol CTXMPPChatDelegate;

@interface CTXMPPChat : NSObject <XMPPStreamDelegate>
{
    XMPPStream* xmppStream;
	XMPPReconnect* xmppReconnect;
    
    XMPPJID *userJID;
    NSString* userPassword;
    GCDMulticastDelegate<CTXMPPChatDelegate>* multicastDelegate;
}

@property (nonatomic, readonly) XMPPStream* xmppStream;

+ (XMPPJID*)xmppJIDFromString:(NSString*)aJIDString;

#pragma mark - delegate
- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;

#pragma mark - xmppStream
- (void)configureXMPPStream;
- (void)closeXMPPStream;

#pragma mark - Connection
- (BOOL)connectWithJIDString:(NSString*)aJID password:(NSString*)aPassword;
- (void)disconnect;

#pragma mark - Presence
- (void)goOnline;
- (void)goOffline;

#pragma mark - Messages
- (void)sendMessage:(CTBOChatMessage*)aChatMessage;

@end

#pragma mark - CTXMPPChatDelegate
@protocol CTXMPPChatDelegate <NSObject>
@optional
- (void)xmppChat:(CTXMPPChat*)aXmppChat didSendMessage:(CTBOChatMessage*)aMessage;
- (void)xmppChat:(CTXMPPChat*)aXmppChat didReceiveMessage:(CTBOChatMessage*)aMessage;

@end
