//
//  ActivityViewShareController.m
//  EUExLoadingView
//
//  Created by 黄锦 on 16/1/4.
//  Copyright © 2016年 zhijian du. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityViewShareController.h"

@implementation ActivityViewShareController

+ (ActivityViewShareController* )sharedManager {
    static ActivityViewShareController *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager=[[ActivityViewShareController alloc]init];
    });
    return sharedMyManager;
}


-(void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:self.activityView];
    [self.activityView startAnimating];
}

-(void)back{
    [self dismissModalViewControllerAnimated:NO];
}
@end