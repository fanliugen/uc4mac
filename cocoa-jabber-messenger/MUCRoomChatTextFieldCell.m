//
//  MUCRoomChatTextFieldCell.m
//  cocoa-jabber-messenger
//
//  Created by 硕实 陈 on 12-2-4.
//  Copyright (c) 2012年 NHN Corporation. All rights reserved.
//

#import "MUCRoomChatTextFieldCell.h"

@implementation MUCRoomChatTextFieldCell 
@synthesize sender;

- (NSAttributedString*) attributedNameString:(NSString*)name
{    
    NSMutableParagraphStyle* paragraphStyle = [[[NSParagraphStyle defaultParagraphStyle] mutableCopy]autorelease];
    [paragraphStyle setAlignment:NSLeftTextAlignment];
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:[NSColor darkGrayColor], 
                           NSForegroundColorAttributeName, 
                           [NSFont userFontOfSize:15], 
                           NSFontAttributeName, 
                           paragraphStyle, NSParagraphStyleAttributeName, nil];
    
    return [[[NSAttributedString alloc] initWithString:name attributes:attrs] autorelease];
}

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    
    BOOL isFocused = NO;
    
    if (([[controlView window] firstResponder] == controlView) && 
        [[controlView window] isMainWindow] &&
        [[controlView window] isKeyWindow]) {
        isFocused = YES;
    } else {
        isFocused = NO;
    }
    
    NSAttributedString* name = [self attributedNameString:sender];
    NSAttributedString* timeStamp = [self attributedTimeStampStringFromDate:messageTime];
        NSRect textRect = [self textRectFromCellFrame:cellFrame withMinimumWidth:MAX(name.length*15, 100)];
    
    NSRect bpRect = textRect;
    bpRect.origin.y += 10;
    bpRect.size.width += 10;
    bpRect.size.height -= 10;

    if (leftArrow) {
        bpRect.origin.x -= 10;
    }
    [self drawRect:bpRect withIsKeyWindow:isFocused];
    
    NSRect timeStampRect = textRect;
    timeStampRect.origin.y += (timeStampRect.size.height-15);
    timeStampRect.size.width -= 10;
    [timeStamp drawInRect:timeStampRect];
    
    NSRect nameRect = textRect;
    nameRect.origin.y += 10;
    [name drawInRect:nameRect];
    
    [super drawInteriorWithFrame:textRect inView:controlView];
}

@end
