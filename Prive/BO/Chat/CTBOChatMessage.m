//
//  CTBOChatMessage.m
//  Prive
//
//  Created by Alexander Burkhai on 10/22/13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import "CTBOChatMessage.h"
#import "NSXMLElement+XEP_0203.h"
#import "NSXMLElement+XMPP.h"

@implementation CTBOChatMessage

#pragma mark - XMPP

- (id)initFromXMPPMessage:(XMPPMessage*)aXmppMessage
{
    self = [self init];
    if(self)
    {
        self.from = [[aXmppMessage attributeForName:@"from"] stringValue];
        self.to = [[aXmppMessage attributeForName:@"to"] stringValue];
        
        if([aXmppMessage wasDelayed])
            self.date = [aXmppMessage delayedDeliveryDate];
    }
    return self;
}

- (XMPPMessage*)toXMPPMessage
{
    NSXMLElement* message = [NSXMLElement elementWithName:@"message"];
    [message addAttributeWithName:@"type" stringValue:@"chat"];
    [message addAttributeWithName:@"to" stringValue:self.to];
    [message addAttributeWithName:@"from" stringValue:self.from];
    return [XMPPMessage messageFromElement:message];
}

@end
