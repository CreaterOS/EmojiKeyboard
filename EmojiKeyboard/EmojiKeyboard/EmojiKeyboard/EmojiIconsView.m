//
//  EmojiIconsView.m
//  EmojiKeyboard
//
//  Created by Bryant Reyn on 2020/8/11.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import "EmojiIconsView.h"
#import "EmojiHeight.h"
#import "EmojiIcons.h"
#import <AudioToolbox/AudioToolbox.h>

#define IDENTIFIER @"emojiCell"
#define IMAGENAME @"image"
#define EMOJIDESC @"desc"

@interface EmojiIconsView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UIButton *thumbnailView;
@end

@implementation EmojiIconsView
- (UIButton *)thumbnailView{
    if (!_thumbnailView) {
        _thumbnailView = [[UIButton alloc] init];
    }
    
    return _thumbnailView;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        self.dataSource = self;
        self.delegate = self;
        
        /* 注册cell */
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:IDENTIFIER];
        
        /* 初始化cell大小 */
        [self setUp:layout];
    }
    return self;
}

- (void)setUp:(UICollectionViewLayout *)layout{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)layout;
    //最小内边距
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //滑动方向
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.emoticons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER forIndexPath:indexPath];

    cell.tag = indexPath.row;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSUInteger row = indexPath.row;
        NSDictionary *emojiDict = self.emoticons[row];
        UIImage *image = [UIImage imageNamed:[@"Emoji.bundle" stringByAppendingPathComponent:[NSString stringWithFormat:@"Contents/Resources/%@",emojiDict[IMAGENAME]]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = image;
            imageView.frame = cell.contentView.frame;
            [cell.contentView addSubview:imageView];
            
            //添加长按手势
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showThumbnail:)];
            [cell addGestureRecognizer:longPress];
        });
    });
    
    return cell;
}

/* 设置item大小 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    CGFloat minIS = flowLayout.minimumInteritemSpacing;
    
    return CGSizeMake((SCREENW - 7*minIS)/8.0, (KEYBOARDHEIGHT-SELECTBARHEIGHT - 4*minIS)/5.0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    /* 播放声音 */
    AudioServicesPlaySystemSound(1057);
    
    NSUInteger row = indexPath.row;
    NSDictionary *emojiDict = self.emoticons[row];
    NSString *desc = emojiDict[EMOJIDESC];
    
    /* 将表情包表述信息转换成[desc]添加到文本末尾 */
    /* 获得响应键盘的第一响应者 */
    id firstResponder = [[[UIApplication sharedApplication] keyWindow] performSelector:@selector(firstResponder)];
    if([firstResponder isKindOfClass:[UITextField class]]){
        UITextField *textField = (UITextField *)firstResponder;
        textField.text = [textField.text stringByAppendingString:[NSString stringWithFormat:@"[%@]",desc]];
    }
    if([firstResponder isKindOfClass:[UITextView class]]){
        UITextView *textView = (UITextView *)firstResponder;
        textView.text = [textView.text stringByAppendingString:[NSString stringWithFormat:@"[%@]",desc]];
    }
}

#pragma mark - 长按显示缩略图
- (void)showThumbnail:(UILongPressGestureRecognizer *)longPress{
    UICollectionViewCell *cell = (UICollectionViewCell *)longPress.view;
    if (longPress.state == UIGestureRecognizerStateBegan) {
        AudioServicesPlaySystemSound(1107);
        
        if (self.thumbnailView != nil) {
            self.thumbnailView = [[UIButton alloc] init];
        }
        
        NSDictionary *emojiDict = self.emoticons[cell.tag];
        NSString *desc = emojiDict[EMOJIDESC];
        
        /* 显示缩略图 */
        CGFloat cell_x = cell.frame.origin.x;
        CGFloat thumbnailView_x = cell_x - 5;
        CGFloat thumbnailView_y = cell.frame.origin.y - 120;
        self.thumbnailView.frame = CGRectMake(thumbnailView_x, thumbnailView_y, 55, 120);
        [self.thumbnailView setBackgroundImage:[UIImage imageNamed:@"emoji-preview-bg"] forState:UIControlStateNormal];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(10, 10, self.thumbnailView.frame.size.width-20, self.thumbnailView.frame.size.width-20);
        imageView.image = [UIImage imageNamed:[@"Emoji.bundle" stringByAppendingPathComponent:[NSString stringWithFormat:@"Contents/Resources/%@",emojiDict[IMAGENAME]]]];
        [self.thumbnailView addSubview:imageView];
        
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.frame = CGRectMake(10, imageView.frame.origin.y + imageView.frame.size.height + 5, self.thumbnailView.frame.size.width-20, 20);
        descLabel.text = desc;
        descLabel.textAlignment = NSTextAlignmentCenter;
        [descLabel setFont:[UIFont systemFontOfSize:[UIFont smallSystemFontSize]]];
        [self.thumbnailView addSubview:descLabel];
        self.clipsToBounds = NO;
        [self addSubview:self.thumbnailView];
    }else if(longPress.state == UIGestureRecognizerStateEnded){
        /* 移除视图 */
        [self.thumbnailView removeFromSuperview];
        /* 发送 */
        NSUInteger row = cell.tag;
        NSDictionary *emojiDict = self.emoticons[row];
        NSString *desc = emojiDict[EMOJIDESC];
        
        /* 将表情包表述信息转换成[desc]添加到文本末尾 */
        /* 获得响应键盘的第一响应者 */
        id firstResponder = [[[UIApplication sharedApplication] keyWindow] performSelector:@selector(firstResponder)];
        if([firstResponder isKindOfClass:[UITextField class]]){
            UITextField *textField = (UITextField *)firstResponder;
            textField.text = [textField.text stringByAppendingString:[NSString stringWithFormat:@"[%@]",desc]];
        }
        if([firstResponder isKindOfClass:[UITextView class]]){
            UITextView *textView = (UITextView *)firstResponder;
            textView.text = [textView.text stringByAppendingString:[NSString stringWithFormat:@"[%@]",desc]];
        }
    }
}


@end
