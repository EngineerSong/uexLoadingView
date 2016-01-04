//
//  EUExLoadingView.m
//  EUExLoadingView
//
//  Created by zhijian du on 15/2/6.
//  Copyright (c) 2015年 zhijian du. All rights reserved.
//

#import "EUExLoadingView.h"
#import "EUtility.h"
#import "JSON.h"
@interface EUExLoadingView () <MONActivityIndicatorViewDelegate>
@property (retain, nonatomic)  TYDotIndicatorView *circleView;
@property (retain, nonatomic)  MONActivityIndicatorView  *indicatorView;
@property (retain, nonatomic)  NSMutableArray *pointColorArr;
@property (retain, nonatomic)  UIActivityIndicatorView *activityView;
@property (retain, nonatomic)  UIView *activityViewBG;
@end


@implementation EUExLoadingView

-(id)initWithBrwView:(EBrowserView *)eInBrwView{
    self = [super initWithBrwView:eInBrwView];
    if (self) {
        
    }
    return self;
}
-(void)open:(NSMutableArray *)inArguments{

    NSInteger x = 0;
    NSInteger y = 0;
    NSInteger w = 0;
    NSInteger h = 0;
    NSInteger styleId = 0;
    NSInteger pointNum = 0;
    
    if (inArguments.count > 0 ) {
       
        NSString *dataJson = [inArguments objectAtIndex:0];
        NSDictionary *dataDict = [dataJson JSONValue];
        x = [[dataDict objectForKey:@"x"] integerValue];
        y = [[dataDict objectForKey:@"y"] integerValue];
        w = [[dataDict objectForKey:@"w"] integerValue];
        h = [[dataDict objectForKey:@"h"] integerValue];
        NSDictionary *styleDict = [dataDict objectForKey:@"style"];
        styleId = [[styleDict objectForKey:@"styleId"] integerValue];
        pointNum = [[styleDict objectForKey:@"pointNum"] integerValue];
        self.pointColorArr = [styleDict objectForKey:@"pointColor"];
    }
    if (styleId == 0) {
        if (self.indicatorView) {
            [_indicatorView removeFromSuperview];
            self.indicatorView = nil;
        }
        MONActivityIndicatorView *indicatorView = [[MONActivityIndicatorView alloc] init];
        self.indicatorView = indicatorView;
        [indicatorView release];
        self.indicatorView.delegate = self;
        self.indicatorView.numberOfCircles = pointNum;
        self.indicatorView.radius = 10;
        self.indicatorView.internalSpacing = 5;
        [self.indicatorView setColorArr:self.pointColorArr];
        self.indicatorView.frame = CGRectMake(x, y, w, h);
        [self.indicatorView startAnimating];
        [EUtility brwView:meBrwView addSubview:self.indicatorView];
        
    }else{
        if (self.circleView) {
            [_circleView removeFromSuperview];
            self.circleView = nil;
        }
        self.circleView = [[TYDotIndicatorView alloc] initWithFrame:CGRectMake(x, y, w, h) dotStyle:TYDotIndicatorViewStyleCircle dotColor:self.pointColorArr dotSize:CGSizeMake(20, 20) numberOfCircle:pointNum];
        [ self.circleView startAnimating];
         self.circleView.layer.cornerRadius = 10.0f;
        [EUtility brwView:meBrwView addSubview: self.circleView];
        [ self.circleView release];
    }
}
//-(void)openCircleLoading:(NSMutableArray *)inArguments{
//    if (self.activityView) {
//        [self.activityView stopAnimating];
//        [_activityView removeFromSuperview];
//        //[_activityViewBG removeFromSuperview];
//        //self.activityViewBG = nil;
//        self.activityView = nil;
//    }
////    NSInteger x = 0;
////    NSInteger y = 0;
////    NSInteger w = 0;
////    NSInteger h = 0;
////    if (inArguments.count > 0 ) {
////        NSString *dataJson = [inArguments objectAtIndex:0];
////        NSDictionary *dataDict = [dataJson JSONValue];
////        x = [[dataDict objectForKey:@"x"] integerValue];
////        y = [[dataDict objectForKey:@"y"] integerValue];
////        w = [[dataDict objectForKey:@"w"] integerValue];
////        h = [[dataDict objectForKey:@"h"] integerValue];
////    }
////    self.activityView = [[UIActivityIndicatorView alloc]  initWithFrame:CGRectMake(0, 0, w, h)];
////    self.activityView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
////    self.activityView.center=CGPointMake(x-w/2,y-h/2);
////    self.activityView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
////    self.activityViewBG=[[UIView alloc]initWithFrame:[EUtility brwViewFrame:meBrwView ]];
////    self.activityViewBG.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3];
////    [self.activityViewBG addSubview:self.activityView];
////    [EUtility brwView:meBrwView addSubview: self.activityViewBG];
////    [self.activityView startAnimating];
////    
////    [self.activityView release];
////    [self.activityViewBG release];
//    
//    self.activityView = [[UIActivityIndicatorView alloc]  initWithFrame:[EUtility brwViewFrame:meBrwView ]];
//    self.activityView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
//    self.activityView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
//    self.activityView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3];
//    [EUtility brwView:meBrwView addSubview: self.activityView];
//    [self.activityView startAnimating];
//    
//    [self.activityView release];
//    
//}
//#pragma mark -
//
//-(void)close:(NSMutableArray *)inArguments {
//    
//    if (self.indicatorView) {
//        [_indicatorView removeFromSuperview];
//        self.indicatorView = nil;
//    }
//    if (self.circleView) {
//        [_circleView removeFromSuperview];
//        self.circleView = nil;
//    }
//    if (self.activityView) {
//        [self.activityView stopAnimating];
//        [_activityView removeFromSuperview];
//        //[_activityViewBG removeFromSuperview];
//        //self.activityViewBG = nil;
//        self.activityView = nil;
//    }
//    self.pointColorArr  = nil;
//}


-(void)openCircleLoading:(NSMutableArray *)inArguments{
    ActivityViewShareController *shareView=[ActivityViewShareController sharedManager];
    if (shareView.activityView) {
        [shareView.activityView stopAnimating];
        [shareView.activityView removeFromSuperview];
        shareView.activityView = nil;
    }
    
    shareView.activityView = [[UIActivityIndicatorView alloc]  initWithFrame:[EUtility brwViewFrame:meBrwView ]];
    shareView.activityView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
    shareView.activityView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        shareView.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    }else{
        shareView.modalPresentationStyle=UIModalPresentationCurrentContext;
        
    }
    [EUtility brwView:meBrwView presentModalViewController:shareView animated:NO];
    
    [shareView.activityView release];
    
}
#pragma mark -

-(void)close:(NSMutableArray *)inArguments {
    
    if (self.indicatorView) {
        [_indicatorView removeFromSuperview];
        self.indicatorView = nil;
    }
    if (self.circleView) {
        [_circleView removeFromSuperview];
        self.circleView = nil;
    }
    ActivityViewShareController *shareView=[ActivityViewShareController sharedManager];
    if (shareView.activityView) {
        [shareView.activityView stopAnimating];
        [shareView.activityView removeFromSuperview];
        shareView.activityView = nil;
        [shareView back];
    }
    self.pointColorArr  = nil;
}

-(void)clean{
    [self close:nil];
}
-(void)dealloc{
    [self close:nil];
    [super dealloc];
}

@end
