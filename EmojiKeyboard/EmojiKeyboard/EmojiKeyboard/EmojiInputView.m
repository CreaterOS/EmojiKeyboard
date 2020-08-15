//
//  EmojiInputView.m
//  EmojiKeyboard
//
//  Created by Bryant Reyn on 2020/8/11.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import "EmojiInputView.h"
#import "EmojiSelectBarView.h"
#import "EmojiClearButton.h"
#import "EmojiSendButton.h"
#import "EmojiIconsView.h"
#import "EmojiImageInfoManager.h"
#import "EmojiHeight.h"

@implementation EmojiInputView

- (instancetype)initWithOrderView:(UILabel *)orderView
{
    self = [super init];
    if (self) {
        /* 设定Frame,键盘高度是260 */
        CGFloat y = SCREENH - KEYBOARDHEIGHT;
        self.frame = CGRectMake(0, y, SCREENW, KEYBOARDHEIGHT);
        self.backgroundColor = [UIColor whiteColor];
        
        EmojiImageInfoManager *infoManager = [EmojiImageInfoManager shareEmojiManager];
        
        //选择按钮
        EmojiSelectBarView *selectBV = [[EmojiSelectBarView alloc] initWithEmojiIconsArray:infoManager.allEmojiInfoArray];
        [self addSubview:selectBV];
        
        //清除按钮
        EmojiClearButton *clearButton = [[EmojiClearButton alloc] init];
        [self addSubview:clearButton];
        
        //发送按钮
        EmojiSendButton *sendButton = [[EmojiSendButton alloc] initWithOrderView:orderView];
        [self addSubview:sendButton];
        
        //添加展示页面
        CGFloat iconViewH = KEYBOARDHEIGHT-SELECTBARHEIGHT;
        EmojiIconsView *iconsView = [[EmojiIconsView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, iconViewH) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        [self addSubview:iconsView];
        
        EmojiInfo *info = [infoManager.allEmojiInfoArray firstObject];
        NSArray<NSDictionary *> *emoticons = info.emoticons;
        iconsView.emoticons = emoticons;
    }
    return self;
}

@end
