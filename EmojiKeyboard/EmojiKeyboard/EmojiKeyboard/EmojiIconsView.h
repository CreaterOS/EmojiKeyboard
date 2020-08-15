//
//  EmojiIconsView.h
//  EmojiKeyboard
//
//  Created by Bryant Reyn on 2020/8/11.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmojiIconsView : UICollectionView
@property (nonatomic,strong)NSArray<NSDictionary *> *emoticons;
@end

NS_ASSUME_NONNULL_END
