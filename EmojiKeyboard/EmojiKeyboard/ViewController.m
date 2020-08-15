//
//  ViewController.m
//  EmojiKeyboard
//
//  Created by Bryant Reyn on 2020/8/11.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import "ViewController.h"
#import "EmojiKeyboard/EmojiImageInfoManager.h"
#import "EmojiKeyboard/EmojiInputView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(50, 250, 250, 44)];
    UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 280, 44)];
    
    textF.backgroundColor = [UIColor grayColor];
    EmojiInputView *inputView = [[EmojiInputView alloc] initWithOrderView:lable];
    textF.inputView = inputView;
    [self.view addSubview:lable];
    [self.view addSubview:textF];
}


@end
