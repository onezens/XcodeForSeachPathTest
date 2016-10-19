//
//  zhenLib.m
//  zhenLib
//
//  Created by wangzhen on 16/10/18.
//  Copyright © 2016年 onezen.cc. All rights reserved.
//

#import "zhenLib.h"

@implementation zhenLib

+ (void)showLibAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"showLibAlert" message:@"This is a alert for showLibAlert" delegate:nil cancelButtonTitle:@"confirm" otherButtonTitles:nil, nil];
    [alert show];
}

@end
