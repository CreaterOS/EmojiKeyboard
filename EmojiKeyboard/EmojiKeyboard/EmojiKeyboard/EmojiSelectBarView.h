//
//  EmojiSelectBarView.h
//  EmojiKeyboard
//
//  Created by Bryant Reyn on 2020/8/11.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmojiInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmojiSelectBarView : UIScrollView

- (instancetype)initWithEmojiIconsArray:(NSArray<EmojiInfo *> *)emojiIconsArray;

@end

NS_ASSUME_NONNULL_END
