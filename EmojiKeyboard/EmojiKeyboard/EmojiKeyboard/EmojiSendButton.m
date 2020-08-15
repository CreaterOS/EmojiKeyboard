//
//  EmojiSendButton.m
//  EmojiKeyboard
//
//  Created by Bryant Reyn on 2020/8/12.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import "EmojiSendButton.h"
#import "EmojiImageInfoManager.h"
#import "EmojiHeight.h"
#import <AudioToolbox/AudioToolbox.h>

@interface EmojiSendButton()
@property (nonatomic,strong)UILabel *orderView; //目标视图
@end

@implementation EmojiSendButton

- (instancetype)initWithOrderView:(UILabel *)orderView
{
    self = [super init];
    if (self) {
        CGFloat sendButton_x = SCREENW-70;
        CGFloat sendButton_y = KEYBOARDHEIGHT-SELECTBARHEIGHT;
        self.frame = CGRectMake(sendButton_x, sendButton_y, 70, SELECTBARHEIGHT);
        [self setTitle:@"Send" forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        self.orderView = orderView;
        
        [self addTarget:self action:@selector(sendText) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

#pragma mark - 发送文本
- (void)sendText{
    /* 播放声音 */
    AudioServicesPlaySystemSound(1100);
    
    /* 获得文本框内容 */
    id firstResponder = [[[UIApplication sharedApplication] keyWindow] performSelector:@selector(firstResponder)];
    if ([firstResponder isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)firstResponder;
        NSString *str = textField.text;
        if (str.length != 0) {
            NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:str];
            attrStr = [[EmojiImageInfoManager shareEmojiManager] replaceAttributedStringByEmojiCharacterStr:[[NSMutableAttributedString alloc] initWithAttributedString:attrStr]];
            if ([self.orderView isKindOfClass:[UILabel class]]) {
                self.orderView.attributedText = attrStr;
            }
            
            textField.text = @"";
        }
    }
    
    if ([firstResponder isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)firstResponder;
        NSString *str = textView.text;
        if (str.length != 0) {
            NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:str];
            attrStr = [[EmojiImageInfoManager shareEmojiManager] replaceAttributedStringByEmojiCharacterStr:[[NSMutableAttributedString alloc] initWithAttributedString:attrStr]];
            if ([self.orderView isKindOfClass:[UILabel class]]) {
                self.orderView.attributedText = attrStr;
            }
            textView.text = @"";
        }
    }
}

@end
