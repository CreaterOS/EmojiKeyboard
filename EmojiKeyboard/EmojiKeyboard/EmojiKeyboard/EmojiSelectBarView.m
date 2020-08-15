//
//  EmojiSelectBarView.m
//  EmojiKeyboard
//
//  Created by Bryant Reyn on 2020/8/11.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import "EmojiSelectBarView.h"
#import "EmojiIconsView.h"
#import "EmojiHeight.h"

@interface EmojiSelectBarView()
@property (nonatomic,strong)NSArray<EmojiInfo *> *emojiIconsArray;
@property (nonatomic,strong)EmojiIconsView *iconsView;
@property (nonatomic,strong)UIImageView *emojiIconView;
@end

@implementation EmojiSelectBarView
#pragma mark - 初始化
- (instancetype)initWithEmojiIconsArray:(NSArray<EmojiInfo *> *)emojiIconsArray
{
    self = [super init];
    if (self) {
        CGFloat y = KEYBOARDHEIGHT-SELECTBARHEIGHT;
        self.frame = CGRectMake(0, y, SCREENW-110, SELECTBARHEIGHT);
        self.backgroundColor = [UIColor whiteColor];
        
        /* 内容大小 */
        NSInteger arrayNum = emojiIconsArray.count;
        CGFloat contentW = 60 * arrayNum;
        self.contentSize = CGSizeMake(contentW, SELECTBARHEIGHT);
        /* 取消滑动条 */
        self.showsHorizontalScrollIndicator = NO;
        
        //添加控件
        self.emojiIconsArray = emojiIconsArray;
        
        [self addSubEmojiIconView:emojiIconsArray];
        
    }
    return self;
}

#pragma mark - 添加Emoji图片视图
- (void)addSubEmojiIconView:(NSArray<EmojiInfo *> *)emojiIconsArray{
    for (NSUInteger i = 0; i < emojiIconsArray.count; ++i) {
        UIImage *image = [UIImage imageNamed:[@"Emoji.bundle" stringByAppendingPathComponent:[NSString stringWithFormat:@"Contents/Resources/%@",emojiIconsArray[i].coverPic]]];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        
        CGFloat width = SELECTBARHEIGHT;
        CGFloat height = SELECTBARHEIGHT;
        CGFloat y = 0.0;
        CGFloat x = 0.0;
        if (i != 0) {
            x = i * (width + 15);
        }else{
            x = i * width;
        }
        
        imageView.frame = CGRectMake(x, y, width, height);
        imageView.image = image;
        
        [self addSubview:imageView];
        
        /* 添加点击手势 */
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmojiIcon:)];
        [imageView addGestureRecognizer:tap];
    }
}

#pragma mark - 点击Emoji视图
- (void)clickEmojiIcon:(UITapGestureRecognizer *)tap{
    if (self.emojiIconView) {
        self.emojiIconView.backgroundColor = [UIColor whiteColor];
    }
    
    UIImageView *emojiIconView = (UIImageView *)tap.view;
    self.emojiIconView = emojiIconView;
    [emojiIconView setBackgroundColor:[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1]];
    
    NSInteger emojiIconViewTag = emojiIconView.tag;
    EmojiInfo *info = self.emojiIconsArray[emojiIconViewTag];
    NSArray<NSDictionary *> *emoticons = info.emoticons;

    if (self.iconsView != nil) {
        [self.iconsView removeFromSuperview];
    }
 
    CGFloat iconViewH = KEYBOARDHEIGHT-SELECTBARHEIGHT;
    self.iconsView = [[EmojiIconsView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, iconViewH) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    [self.superview addSubview:self.iconsView];
    
    self.iconsView.emoticons = emoticons;
}

@end
