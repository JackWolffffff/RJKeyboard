//
//  RJKeyboard.h
//  RJKeyboard
//
//  Created by a on 15-11-19.
//  Copyright (c) 2015年 elinkdata. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RJKeyboardDelegate <NSObject>

@end

@interface RJKeyboard : UIView

///使用安全键盘的输入框
@property (strong, nonatomic) UITextField * mainTextField;

///自定义隐藏键盘按钮
@property (strong, nonatomic) UIButton * customCloseBtn;


//配置键盘
-(void)configKeyboard;

@end
