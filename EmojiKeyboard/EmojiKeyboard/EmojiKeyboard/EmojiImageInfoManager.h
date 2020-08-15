//
//  EmojiImageInfoManager.h
//  EmojiKeyboard
//
//  Created by Bryant Reyn on 2020/8/11.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EmojiIcons.h"
#import "EmojiMatchingResult.h"

@class EmojiInfo;

NS_ASSUME_NONNULL_BEGIN

@interface EmojiImageInfoManager : NSObject

@property (nonatomic,strong)NSArray<EmojiInfo *> *allEmojiInfoArray; //所有Emoji

/* 单例模式 */
+ (instancetype)shareEmojiManager;

/**
 * 替换服务器传来的[拜拜]为本地表情包
 * 1.属性字符串
 * 2.使用字体
 */
- (NSMutableAttributedString *)replaceAttributedStringByEmojiCharacterStr:(NSMutableAttributedString *)emojiCharacterStr;

- (NSArray<EmojiMatchingResult *> *)matchingEmojiCharacterStrBySquare:(NSString *__nonnull)emojiCharacterStr;

@end

NS_ASSUME_NONNULL_END

