//
//  ViewController.m
//  CSNetworkToolExample
//
//  Created by chaos on 8/14/15.
//  Copyright (c) 2015 ace. All rights reserved.
//

#import "ViewController.h"
#import "CSNetworkTool.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    NSString *network = [CSNetworkTool currentNetworkStatus];
    NSLog(@"network:  %@",network);
    
    //    [self logNameAndTypeWithClass:@"UIStatusBar"];
    
    //    UIApplication *application = [UIApplication sharedApplication];
    //    NSArray *subViews = [[[application valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    //
    //    UIView *itemView = nil;
    //    for (UIView *view in subViews) {
    //        NSLog(@"%@",view);
    //        if ([view isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
    //            itemView = view;
    //            break;
    //        }
    //    }
    
    //    [self logNameAndTypeWithClass:@"UIStatusBarDataNetworkItemView"];
    //    [self logNameAndTypeWithClass:@"UIStatusBarForegroundView"];
    
}

- (void)logNameAndTypeWithClass:(NSString *)class
{
    unsigned int count;
    Ivar *ivar = class_copyIvarList(NSClassFromString(class), &count);
    for (NSInteger i = 0; i < count; i++) {
        const char *name = ivar_getName(ivar[i]);
        const char *type = ivar_getTypeEncoding(ivar[i]);
        NSString *strName = [NSString stringWithUTF8String:name];
        NSString *strType = [NSString stringWithUTF8String:type];
        NSLog(@"%@---------%@",strName,strType);
    }
}

@end
