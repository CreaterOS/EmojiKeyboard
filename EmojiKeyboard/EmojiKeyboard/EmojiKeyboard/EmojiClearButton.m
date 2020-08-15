//
//  EmojiClearButton.m
//  EmojiKeyboard
//
//  Created by Bryant Reyn on 2020/8/13.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import "EmojiClearButton.h"
#import "EmojiImageInfoManager.h"
#import "EmojiMatchingResult.h"
#import "EmojiHeight.h"

@implementation EmojiClearButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGFloat clearButton_x = SCREENW-101;
        CGFloat clearButton_y = KEYBOARDHEIGHT-SELECTBARHEIGHT+4;
        self.frame = CGRectMake(clearButton_x, clearButton_y, 32, 32);
        [self setBackgroundImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor whiteColor];
        [self addTarget:self action:@selector(removeCharacters) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

#pragma mark - 删除文本框字符串
- (void)removeCharacters{
    /* 获得文本框内容 */
    id firstResponder = [[[UIApplication sharedApplication] keyWindow] performSelector:@selector(firstResponder)];
    if ([firstResponder isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)firstResponder;
        NSString *str = textField.text;
        if (str.length != 0) {
            /* 匹配[*],末尾有则删除,否则逐个删除 */
            NSArray *result = [[EmojiImageInfoManager shareEmojiManager] matchingEmojiCharacterStrBySquare:str];
            if (result.count != 0) {
                EmojiMatchingResult *mResult = [result lastObject];
                NSRange range = mResult.range;
                str = [str stringByReplacingCharactersInRange:range withString:@""];
            }else{
                str = [str substringWithRange:NSMakeRange(0, str.length-1)];
            }
            /* 有文本可删 */
            textField.text = str;
        }
    }
    
    if ([firstResponder isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)firstResponder;
        NSString *str = textView.text;
        if (str.length != 0) {
            /* 匹配[*],末尾有则删除,否则逐个删除 */
            NSArray *result = [[EmojiImageInfoManager shareEmojiManager] matchingEmojiCharacterStrBySquare:str];
            if (result.count != 0) {
                EmojiMatchingResult *mResult = [result lastObject];
                NSRange range = mResult.range;
                str = [str stringByReplacingCharactersInRange:range withString:@""];
            }else{
                str = [str substringWithRange:NSMakeRange(0, str.length-1)];
            }
            /* 有文本可删 */
            textView.text = str;
        }
    }
}

@end
