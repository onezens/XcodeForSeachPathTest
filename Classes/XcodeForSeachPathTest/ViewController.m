//
//  ViewController.m
//  XcodeForSeachPathTest
//
//  Created by wangzhen on 16/10/18.
//  Copyright © 2016年 onezen.cc. All rights reserved.
//

#import "ViewController.h"
#import "zhenLib.h"
#import <zhenFW/zhenFW.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn1 = [UIButton new];
    [btn1 setTitle:@"test lib" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(testLib) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn1 sizeToFit];
    btn1.center = CGPointMake(100, 100);
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton new];
    [btn2 setTitle:@"test framework" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(testFramework) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn2 sizeToFit];
    btn2.center = CGPointMake(100, 160);
    [self.view addSubview:btn2];
    
}

- (void)testLib {
    [zhenLib showLibAlert];
}

- (void)testFramework {
    [zhenLibFW showFWAlert];
}



@end
