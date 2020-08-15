//
//  EmojiSendButton.h
//  EmojiKeyboard
//
//  Created by Bryant Reyn on 2020/8/12.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmojiSendButton : UIButton

- (instancetype)initWithOrderView:(UILabel *)orderView;

- (void)sendText; //发送文本

@end

NS_ASSUME_NONNULL_END
