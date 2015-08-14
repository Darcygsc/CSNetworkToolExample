//
//  CSNetworkTool.m
//  CSNetworkTool
//
//  Created by chaos on 8/14/15.
//  Copyright (c) 2015 ace. All rights reserved.
//

#import "CSNetworkTool.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "Reachability.h"

@implementation CSNetworkTool

+ (NSString *)currentNetworkStatus
{
    NSString *networkString = @"";
    if (([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0)) { // ios7 以下网络状态
        UIApplication *application = [UIApplication sharedApplication];
        NSArray *subViews = [[[application valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
        
        UIView *itemView = nil;
        for (UIView *view in subViews) {
            if ([view isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
                itemView = view;
                break;
            }
        }
        NSInteger i =  [[itemView valueForKey:@"dataNetworkType"] integerValue];
        switch (i) {
            case 0:
                networkString = @"没有网络";
                break;
            case 1:
                networkString = @"2G";
                break;
            case 2:
                networkString = @"3G";
                break;
            case 3:
                networkString = @"4G";
                break;
            case 4:
                networkString = @"4G";
                break;
            case 5:
                networkString = @"Wifi";
                break;
            default:
                break;
        }
    }else{ // ios7 以上网络状态
        NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
        switch (status) {
            case NotReachable:
                networkString = @"没有网络";
                break;
            case ReachableViaWiFi:
                networkString = @"Wifi";
                break;
            case ReachableViaWWAN:{
                CTTelephonyNetworkInfo *telephonyInfo = [CTTelephonyNetworkInfo new];
                
                if ([telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
                    networkString = @"4G";
                }else if([telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [telephonyInfo.currentRadioAccessTechnology  isEqualToString:CTRadioAccessTechnologyGPRS] || [telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyeHRPD]){
                    networkString = @"2G";
                }else{
                    networkString = @"3G";
                }
            }
                break;
            default:
                break;
        }
    }
    return networkString;
    
}


@end
