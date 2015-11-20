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

@property (strong, nonatomic) UIButton * testBtn;

@property (strong, nonatomic) RJKeyboard * testView;

@end

@implementation ViewController

@synthesize textField;
@synthesize testBtn;
@synthesize testView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 300, 100, 30)];
    textField.layer.borderColor = [UIColor blackColor].CGColor;
    textField.layer.borderWidth = 1;
    [self.view addSubview:textField];
    
    CGRect testViewFrame = CGRectMake(0, 0, 320, 216);
    testView = [[RJKeyboard alloc] initWithFrame:testViewFrame];
    testView.mainTextField = textField;
    [testView configKeyboard];
    
    //键盘上方的view
//    textField.inputAccessoryView = testBtn;
//    textField.inputView = testView;
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
