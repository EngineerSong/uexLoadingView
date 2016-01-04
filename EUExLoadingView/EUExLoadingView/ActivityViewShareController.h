//
//  ActivityViewShareController.h
//  EUExLoadingView
//
//  Created by 黄锦 on 16/1/4.
//  Copyright © 2016年 zhijian du. All rights reserved.
//

@protocol ActivityViewShareController <NSObject>



@end


@interface ActivityViewShareController : UIViewController

+(ActivityViewShareController *)sharedManager;

@property (retain, nonatomic)  UIActivityIndicatorView *activityView;
@property(nonatomic,assign)id<ActivityViewShareController> delegate;

@end
