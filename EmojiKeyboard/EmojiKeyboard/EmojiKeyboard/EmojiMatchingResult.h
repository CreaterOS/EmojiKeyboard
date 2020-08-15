//
//  EmojiMatchingResult.h
//  EmojiKeyboard
//
//  Created by Bryant Reyn on 2020/8/13.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmojiMatchingResult : NSObject
@property (nonatomic,assign)NSRange range; //匹配Emoji文本range
@property (nonatomic,strong)UIImage *emojiIcons;
@property (nonatomic,copy)NSString *emojiDesc;
@end

NS_ASSUME_NONNULL_END
