//
//  ViewController.m
//  RJKeyboard
//
//  Created by a on 15-11-19.
//  Copyright (c) 2015年 elinkdata. All rights reserved.
//

#import "ViewController.h"
#import "RJKeyboard.h"

@interface ViewController ()

@property (strong, nonatomic) UITextField * textField;

@property (strong, nonatomic) UITextField * textField1;

@property (strong, nonatomic) UIButton * testBtn;

@property (strong, nonatomic) RJKeyboard * testView;

@property (strong, nonatomic) UIView *view1;
@property (strong, nonatomic) UIView *view2;

@end

@implementation ViewController

@synthesize textField;
@synthesize textField1;
@synthesize testBtn;
@synthesize testView;

#pragma mark LazyLoad
- (UIView *)view1 {
    if (_view1 == nil) {
        _view1 = [[UIView alloc] init];
        _view1.backgroundColor = [UIColor redColor];
    }
    return _view1;
}

- (UIView *)view2 {
    if (_view2 == nil) {
        _view2 = [[UIView alloc] init];
        _view2.backgroundColor = [UIColor blueColor];
    }
    return _view2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 300, 100, 30)];
    textField.layer.borderColor = [UIColor blackColor].CGColor;
    textField.layer.borderWidth = 1;
    [self.view addSubview:textField];
    
    textField1 = [[UITextField alloc] init];
    textField1.frame = CGRectMake(150, 300, 100, 30);
    [self.view addSubview:textField1];
    UIView *av = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    av.backgroundColor = [UIColor redColor];
    textField1.inputAccessoryView = av;
    textField1.keyboardType = UIKeyboardTypeDefault;
    
    CGRect testViewFrame = CGRectMake(0, 0, 320, 216);
    testView = [[RJKeyboard alloc] initWithFrame:testViewFrame];
    testView.mainTextField = textField;
    [testView configKeyboard];
    [[UIApplication sharedApplication].keyWindow addSubview:self.view1];
    [[UIApplication sharedApplication].keyWindow addSubview:self.view2];
    
    //键盘上方的view
//    textField.inputAccessoryView = testBtn;
//    textField.inputView = testView;
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    NSLog(@"keyboardInfo:%@", notification.userInfo);
    
    NSValue *value1 = notification.userInfo[UIKeyboardFrameBeginUserInfoKey];
    NSValue *value2 = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect rect1 = value1.CGRectValue;
    CGRect rect2 = value2.CGRectValue;
    
    self.view1.frame = CGRectMake(rect1.origin.x, rect1.origin.y, rect1.size.width, 1);
    self.view2.frame = CGRectMake(rect2.origin.x, rect2.origin.y, rect2.size.width, 1);
    
    
}

- (void)keyboardDidHide:(NSNotification *)notification {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
