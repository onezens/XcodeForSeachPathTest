//
//  zhenLibFW.m
//  LibDemo
//
//  Created by wangzhen on 16/10/18.
//  Copyright © 2016年 onezen.cc. All rights reserved.
//

#import "zhenLibFW.h"

@implementation zhenLibFW

+ (void)showFWAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"showFWAlert" message:@"This is a alert for showFWAlert" delegate:nil cancelButtonTitle:@"confirm" otherButtonTitles:nil, nil];
    [alert show];
}

@end
