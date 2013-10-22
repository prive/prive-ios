//
//  CTBOChatMessage.h
//  Karizma
//
//  Created by Alexander Burkhai on 10/22/13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPMessage.h"

@interface CTBOChatMessage : NSObject

@property (nonatomic, strong) NSString* identifier;
@property (nonatomic, strong) NSString* from;
@property (nonatomic, strong) NSString* to;
@property (nonatomic, strong) NSDate* date;

#pragma mark - XMPP

- (id)initFromXMPPMessage:(XMPPMessage*)aXmppMessage;
- (XMPPMessage*)toXMPPMessage;

@end
