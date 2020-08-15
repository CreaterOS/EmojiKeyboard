//
//  EmojiIcons.h
//  EmojiKeyboard
//
//  Created by Bryant Reyn on 2020/8/11.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

/**
 * EmojiIcons
 * Emoji image: 图片
 * Emoji decs: 图片描述
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmojiIcons : NSObject
@property (nonatomic,copy)NSString *imageName;
@property (nonatomic,copy)NSString *desc;
@end

NS_ASSUME_NONNULL_END
