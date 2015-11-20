//
//  RJKeyboard.m
//  RJKeyboard
//
//  Created by a on 15-11-19.
//  Copyright (c) 2015年 elinkdata. All rights reserved.
//

#import "RJKeyboard.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface RJKeyboard()


@property (strong, nonatomic) NSMutableString * textStack;

@end

@implementation RJKeyboard

{
    
    NSMutableArray * normalBtnArray;
    CGRect tempFrame1;
    CGRect tempFrame2;
}

@synthesize textStack;
@synthesize mainTextField;

-(instancetype) initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        textStack = [NSMutableString string];
        [self configBtns];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    }
    
    return self;
    
}

//打乱按钮排序
-(void)random {
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    NSMutableArray * tempArray = [NSMutableArray arrayWithArray:normalBtnArray];
    [tempArray removeLastObject];
    
    for (int i = 0; i < 10; i++) {
        
        CGRect btnFrame = CGRectMake(w/3*(i%3), h/4*((int)(i/3)), w/3, h/4);
        
        //退格按钮
        if (i == 9) {
            btnFrame.origin.x += w/3;
            
            UIButton * delBtn = normalBtnArray[i + 1];
            delBtn.frame = CGRectMake(w/3*((i+1)%3)+w/3, h/4*((int)((i+1)/3)), w/3, h/4);
            [self addSubview:delBtn];
            
        }
        
        UIButton * b = [UIButton new];
        int randowIndex = arc4random()%tempArray.count;
        b = tempArray[randowIndex];
        [tempArray removeObjectAtIndex:randowIndex];
        b.frame = btnFrame;
    }
    
    
}

//添加清空按钮
-(void) addClearBtn {

    UIButton * clearBtn = [[UIButton alloc] init];
    clearBtn.backgroundColor = [UIColor whiteColor];
    clearBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    clearBtn.layer.borderWidth = 1;
    [clearBtn setTitle:@"清空" forState:(UIControlStateNormal)];
    [clearBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    clearBtn.frame = CGRectMake(0, self.frame.size.height/4*3, SCREENWIDTH/3, self.frame.size.height/4);
    clearBtn.layer.cornerRadius = 5;
    [clearBtn addTarget:self action:@selector(clearAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:clearBtn];
    
}

//清空
-(void)clearAction {

    textStack = [NSMutableString string];
    mainTextField.text = textStack;
    
}

//配置数字按钮
-(void)configBtns{
    
    normalBtnArray = [NSMutableArray array];
    for (int i = 0; i < 11; i++) {
        UIButton * btn = [[UIButton alloc] init];
        [btn setTitle:[NSString stringWithFormat:@"%d", i] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        [btn setTitleColor:[UIColor blueColor] forState:(UIControlStateSelected)];
        
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.layer.borderWidth = 1;
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        if (i == 10) {
            [btn removeTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [btn addTarget:self action:@selector(delBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [btn setTitle:@"退格" forState:(UIControlStateNormal)];
            
        }
        
        [normalBtnArray addObject:btn];
        [self addSubview:btn];
        
    }
    
    [self addClearBtn];

}

//配置
-(void)configKeyboard{
    
    CGRect closeBtnFrame = CGRectMake(0, 0, 320, 30);
    
    UIButton * closeBtn = [[UIButton alloc] init];
    closeBtn = [[UIButton alloc] initWithFrame:closeBtnFrame];
    [closeBtn setTitle:@"关闭键盘" forState:(UIControlStateNormal)];
    closeBtn.backgroundColor = [UIColor redColor];
    [closeBtn.titleLabel setTextAlignment:(NSTextAlignmentCenter)];
    [closeBtn addTarget:self action:@selector(closeKeyboard) forControlEvents:(UIControlEventTouchUpInside)];
    
    mainTextField.inputAccessoryView = closeBtn;
    if (_customCloseBtn != nil) {
        mainTextField.inputAccessoryView = _customCloseBtn;
    }
    
    mainTextField.inputView = self;
    
}

-(void)closeKeyboard {
    
    [mainTextField resignFirstResponder];
    
}

//数字按键
-(void) btnAction:(UIButton *)sender {
    
    NSString * text = sender.titleLabel.text;
    
    [textStack appendString:text];
    
    mainTextField.text = textStack;
    mainTextField.frame = tempFrame2;
    
}

//退格按钮
-(void) delBtnAction:(UIButton *)sender {
    
    textStack = [NSMutableString stringWithString:mainTextField.text];
    
    if (textStack.length> 0) {
        textStack = [NSMutableString stringWithString:[textStack substringToIndex:textStack.length-1]];
        
        mainTextField.text = textStack;
    } else {
        //
    }
    
}

//键盘即将出现
-(void)keyboardWillShow:(NSNotification *)notification{
    
    textStack = [NSMutableString stringWithString:mainTextField.text];
    
    [self random];
}

//键盘出现
-(void)keyboardDidShow:(NSNotification *)notification {

    tempFrame1 = mainTextField.frame;
    tempFrame2 = mainTextField.frame;
    
    if ((tempFrame2.origin.y + tempFrame2.size.height) > (SCREENHEIGHT - 246)) {
        tempFrame2.origin.y = SCREENHEIGHT - 256 - tempFrame2.size.height;
        
        [UIView animateWithDuration:0.25 animations:^{
            mainTextField.frame = tempFrame2;

        }];
    }

}

//键盘消失
-(void)keyboardDidHide:(NSNotification *)notification {
    
    textStack = [NSMutableString string];
    [UIView animateWithDuration:0.25 animations:^{
        mainTextField.frame = tempFrame1;

    }];
}
@end
