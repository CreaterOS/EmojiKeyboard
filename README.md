### EmojiKeyboard

表情包键盘,内置3000多个Emoji表情包(分为:笑脸,鬼脸,动物,爱心,手势,人,旗帜七大类)。大量Emoji 图片通过.bundle封装,通过plist文件进行统一管理。

#### EmojiKeyboard 使用简单

~~~objective-c
```
UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(50, 250, 250, 44)];

UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 280, 44)];
textF.backgroundColor = [UIColor grayColor];

EmojiInputView *inputView = [[EmojiInputView alloc] initWithOrderView:lable];

textF.inputView = inputView;

[self.view addSubview:lable];

[self.view addSubview:textF];
```
~~~

初始化一个显示表情的目标Lable就可以了。

EmojiInputView *inputView = [[EmojiInputView alloc] initWithOrderView:lable];





### EmojiKeyboard 后期提供多达4000-6000个不同风格的Emoji表情,免费下载,欢迎大家star～～～

