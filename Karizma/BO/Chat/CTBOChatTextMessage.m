//
//  CTBOChatTextMessage.m
//  Karizma
//
//  Created by Alexander Burkhai on 10/22/13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import "CTBOChatTextMessage.h"
#import "NSXMLElement+XMPP.h"

@implementation CTBOChatTextMessage

#pragma mark - XMPP

- (id)initFromXMPPMessage:(XMPPMessage *)aXmppMessage
{
    self = [super initFromXMPPMessage:aXmppMessage];
    if(self)
    {
        self.messageText = [[aXmppMessage elementForName:@"body"] stringValue];
    }
    return self;
}

- (XMPPMessage*)toXMPPMessage
{
    XMPPMessage* message = [super toXMPPMessage];
    NSXMLElement* body = [NSXMLElement elementWithName:@"body"];
    [body setStringValue:self.messageText];
    [message addChild:body];
    return message;
}

@end
