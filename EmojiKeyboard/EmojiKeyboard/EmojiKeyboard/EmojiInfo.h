//
//  EmojiInfo.h
//  EmojiKeyboard
//
//  Created by Bryant Reyn on 2020/8/11.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

/**
 * EmojiInfo
 * Emoji总称
 * Emoji单个名称下所有图片
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EmojiIcons.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmojiInfo : NSObject
@property (nonatomic,copy)NSString *coverPic; //Emoji名称
@property (nonatomic,strong)NSArray<NSDictionary *> *emoticons; //Emogi图片
@end

NS_ASSUME_NONNULL_END
