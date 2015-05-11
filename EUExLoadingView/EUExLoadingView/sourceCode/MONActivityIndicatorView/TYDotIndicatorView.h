//
//  TYDotIndicatorView.h
//  TYDotIndicatorView
//
//  Created by Tu You on 14-1-12.
//  Copyright (c) 2014年 Tu You. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EUtility.h"

typedef NS_ENUM(NSInteger, TYDotIndicatorViewStyle)
{
    TYDotIndicatorViewStyleSquare,
    TYDotIndicatorViewStyleRound,
    TYDotIndicatorViewStyleCircle
};

@interface TYDotIndicatorView : UIView
- (id)initWithFrame:(CGRect)frame
           dotStyle:(TYDotIndicatorViewStyle)style
           dotColor:(NSMutableArray *)dotColorArr
            dotSize:(CGSize)dotSize
     numberOfCircle:(NSInteger)numberOfCircles;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;


@end
