//
//  CTChatController.h
//  Karizma
//
//  Created by Alexander Burkhai on 10/16/13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import "CTBaseController.h"

@interface CTChatController : CTBaseController
{
    __weak IBOutlet UISegmentedControl *testUserSegmentedControl;
    __weak IBOutlet UITextField *inputTextField;
    __weak IBOutlet UITextView *lastMessagesTextView;
    
    __weak IBOutlet UIButton *onlineButton;
}

@end
