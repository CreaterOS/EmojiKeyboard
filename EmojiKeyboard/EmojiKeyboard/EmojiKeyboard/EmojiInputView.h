//
//  EmojiInputView.h
//  EmojiKeyboard
//
//  Created by Bryant Reyn on 2020/8/11.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

/**
 * EmojiInputView
 * 自定义InputView Emoji内容视图
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmojiInputView : UIInputView

- (instancetype)initWithOrderView:(UILabel *)orderView;

@end

NS_ASSUME_NONNULL_END
