//
//  TYDotIndicatorView.m
//  TYDotIndicatorView
//
//  Created by Tu You on 14-1-12.
//  Copyright (c) 2014年 Tu You. All rights reserved.
//

#import "TYDotIndicatorView.h"

static const CGFloat dotSeparatorDistance = 12.0f;

@interface TYDotIndicatorView ()

@property (nonatomic, assign) TYDotIndicatorViewStyle dotStyle;
@property (nonatomic, assign) CGSize dotSize;
@property (nonatomic, retain) NSMutableArray *dots;
@property (nonatomic, assign) BOOL animating;

@end

@implementation TYDotIndicatorView

- (id)initWithFrame:(CGRect)frame
           dotStyle:(TYDotIndicatorViewStyle)style
           dotColor:(NSMutableArray *)dotColorArr
            dotSize:(CGSize)dotSize numberOfCircle:(NSInteger)numberOfCircles
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _dotStyle = style;
        _dotSize = dotSize;
        
        _dots = [[NSMutableArray alloc] init];
        
        CGFloat xPos = frame.origin.x;
        CGFloat yPos = CGRectGetHeight(frame) / 2 - _dotSize.height / 2;
        UIColor *customColor = nil;
        UIColor *defaultColor = nil;
        
        for (int i = 0; i < numberOfCircles; i++) {
            CAShapeLayer *dot = [CAShapeLayer new];
            dot.path = [self createDotPath].CGPath;
            dot.frame = CGRectMake(xPos, yPos, _dotSize.width, _dotSize.height);
            //dot.frame = frame;
            dot.opacity = 0.3 * i;
            if (i < dotColorArr.count) {
                customColor = [EUtility ColorFromString:[dotColorArr objectAtIndex:i]];
            }else{
                defaultColor = [self randomGetColor];
            }
            dot.fillColor = customColor.CGColor?customColor.CGColor:defaultColor.CGColor;
            [self.layer addSublayer:dot];
            [_dots addObject:dot];
            
            xPos = xPos + (dotSeparatorDistance + _dotSize.width);
        }

    }
    return self;
}

- (UIColor *)randomGetColor {
    CGFloat red   = (arc4random() % 256)/255.0;
    CGFloat green = (arc4random() % 256)/255.0;
    CGFloat blue  = (arc4random() % 256)/255.0;
    CGFloat alpha = 1.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


- (UIBezierPath *)createDotPath
{
    CGFloat cornerRadius = 0.0f;
    if (_dotStyle == TYDotIndicatorViewStyleSquare)
    {
        cornerRadius = 0.0f;
    }
    else if (_dotStyle == TYDotIndicatorViewStyleRound)
    {
        cornerRadius = 2;
    }
    else if (_dotStyle == TYDotIndicatorViewStyleCircle)
    {
        cornerRadius = self.dotSize.width / 2;
    }
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.dotSize.width, self.dotSize.height) cornerRadius:cornerRadius];
    
    return bezierPath;
}

- (CAAnimation *)fadeInAnimation:(CFTimeInterval)delay
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @(0.3f);
    animation.toValue = @(1.0f);
    animation.duration = 0.9f;
    animation.beginTime = delay;
    animation.autoreverses = YES;
    animation.repeatCount = HUGE_VAL;
    return animation;
}

- (void)startAnimating {
    
    if (_animating)
    {
        return;
    }

    for (int i = 0; i < _dots.count; i++)
    {
        [_dots[i] addAnimation:[self fadeInAnimation:i * 0.8] forKey:@"fadeIn"];
    }
    
    _animating = YES;
}


- (void)stopAnimating
{
    if (!_animating)
    {
        return;
    }
    
    for (int i = 0; i < _dots.count; i++)
    {
        [_dots[i] addAnimation:[self fadeInAnimation:i * 0.8] forKey:@"fadeIn"];
    }
    
    _animating = NO;
    

}

- (BOOL)isAnimating
{
    return _animating;
}

- (void)removeFromSuperview
{
    [self stopAnimating];
    
    [super removeFromSuperview];
}

@end
