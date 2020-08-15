//
//  EmojiImageInfoManager.m
//  EmojiKeyboard
//
//  Created by Bryant Reyn on 2020/8/11.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import "EmojiImageInfoManager.h"
#import "EmojiInfo.h"

#define COVERPIC @"cover_pic"
#define EMOTICONS @"emoticons"
#define EMOJIIMAGE @"image"
#define EMOJIDESC @"desc"

@implementation EmojiImageInfoManager

#pragma mark - 单例模式
static EmojiImageInfoManager *_instance = nil;
+ (instancetype)shareEmojiManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        /* 解析EmojiInfo文件 */
        [self parseInfoFile];
    }
    return self;
}

- (void)parseInfoFile{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"EmojiInfo" ofType:@"plist"];
    
    /* 读取路径失败 */
    if (filePath.length == 0) {
        return ;
    }
    NSArray<NSDictionary *> *emojiInfoAllArray = [[NSArray array] initWithContentsOfFile:filePath];

    NSMutableArray<EmojiInfo *> *emojiInfoArray = [NSMutableArray array];
    for (NSDictionary<NSString *,id> *emojiDict in emojiInfoAllArray) {
        /* 获得Emoji字典 */
        EmojiInfo *info = [self parseEmojiDict:emojiDict];
        [emojiInfoArray addObject:info];
    }
    self.allEmojiInfoArray = emojiInfoArray;
}

#pragma mark - 解析Emoji字典
- (EmojiInfo *)parseEmojiDict:(NSDictionary<NSString *,id> *)dict{
    /* 1.Emoji名称 */
    NSString *coverPicName = dict[COVERPIC];
    /* 2.Emoji图片 */
    NSMutableArray<EmojiIcons *> *emojiIconsArray = [[NSMutableArray alloc] init];
    
    NSArray<NSDictionary<NSString *,NSString *> *> *emoticons = dict[EMOTICONS];

    for (NSDictionary<NSString *,NSString *> *emoticonsDict in emoticons) {
        EmojiIcons *emojiIcons = [[EmojiIcons alloc] init];
        emojiIcons.imageName = emoticonsDict[EMOJIIMAGE];
        emojiIcons.desc = emoticonsDict[EMOJIDESC];
        
        /* 添加EmojiIcons */
        [emojiIconsArray addObject:emojiIcons];
    }
    
    EmojiInfo *info = [[EmojiInfo alloc] init];
    info.coverPic = coverPicName;
    info.emoticons = emoticons;
    
    return info;
}

#pragma mark - 替换Emoji
- (NSMutableAttributedString *)replaceAttributedStringByEmojiCharacterStr:(NSMutableAttributedString *)emojiCharacterStr{
    if (emojiCharacterStr.length == 0) {
        return [[NSMutableAttributedString alloc] init];
    }
    
    /* 匹配[*]格式 */
    NSArray<EmojiMatchingResult *> *matchingResults = [self matchingEmojiCharacterStrBySquare:emojiCharacterStr.string];
  
    if (matchingResults && matchingResults.count != 0) {
        NSUInteger offset = 0;
        for (EmojiMatchingResult *result in matchingResults) {
            if (result.emojiIcons) {
                NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
                attachment.image = result.emojiIcons;
                attachment.bounds = CGRectMake(0, 0, 25, 25);
                NSMutableAttributedString *emojiAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
                if (!emojiAttributedString) {
                    continue;
                }
                NSRange actualRange = NSMakeRange(result.range.location - offset, result.emojiDesc.length);
                [emojiCharacterStr replaceCharactersInRange:actualRange withAttributedString:emojiAttributedString];
                offset += result.emojiDesc.length - emojiAttributedString.length;
            }
        }
    }
    
    return emojiCharacterStr;
}

#pragma mark - 匹配Emoji字符串
- (NSArray<EmojiMatchingResult *> *)matchingEmojiCharacterStrBySquare:(NSString *__nonnull)emojiCharacterStr{
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@"\\[.+?\\]" options:NSRegularExpressionCaseInsensitive error:nil];
 
    NSArray<NSTextCheckingResult *> *results = [expression matchesInString:emojiCharacterStr options:0 range:NSMakeRange(0, emojiCharacterStr.length)];

    if (results && results.count) {
        NSMutableArray *emojiMatchingResults = [[NSMutableArray alloc] init];
        for (NSTextCheckingResult *result in results) {
            NSString *showingDescription = [emojiCharacterStr substringWithRange:result.range];
         
            NSString *emojiSubString = [showingDescription substringFromIndex:1];
            emojiSubString = [emojiSubString substringWithRange:NSMakeRange(0, emojiSubString.length - 1)];
            
            EmojiIcons *icons = [self emojiWithEmojiDescription:emojiSubString];
            
            if (icons) {
                EmojiMatchingResult *emojiMatchingResult = [[EmojiMatchingResult alloc] init];
                emojiMatchingResult.range = result.range;
                emojiMatchingResult.emojiDesc = showingDescription;
                emojiMatchingResult.emojiIcons = [UIImage imageNamed:[@"Emoji.bundle" stringByAppendingPathComponent:[NSString stringWithFormat:@"Contents/Resources/%@",icons.imageName]]];
                [emojiMatchingResults addObject:emojiMatchingResult];
            }
        }
        return emojiMatchingResults;
    }
    return [NSArray array];
}

- (EmojiIcons *)emojiWithEmojiDescription:(NSString *__nonnull)emojiDescription
{
    
    for (EmojiInfo *info in self.allEmojiInfoArray) {
        
        for (NSDictionary *dict in info.emoticons) {
            if ([dict[@"desc"] isEqualToString:emojiDescription]) {
                EmojiIcons *icons = [[EmojiIcons alloc] init];
                icons.desc = emojiDescription;
                icons.imageName = dict[@"image"];
                return icons;
            }
        }
    }
    return nil;
}

@end
