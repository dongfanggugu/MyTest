//
//  MyAnimationViewController.m
//  test
//
//  Created by changhaozhang on 2018/2/5.
//  Copyright © 2018年 changhaozhang. All rights reserved.
//

#import "MyAnimationViewController.h"

@interface MyAnimationViewController() <CAAnimationDelegate>

@property (nonatomic, strong) CALayer *aniLayer;

@end

@implementation MyAnimationViewController


- (void)animation
{
    _aniLayer = [[CALayer alloc] init];
    _aniLayer.bounds = CGRectMake(0, 0, 100, 100);
    _aniLayer.position = CGPointMake(100, 200);
    _aniLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:_aniLayer];
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
    displayLink.preferredFramesPerSecond = 30;
    
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)handleDisplayLink:(CADisplayLink *)displayLink
{
    NSLog(@"model tree: %@, presentLayer tree: %@", [NSValue valueWithCGPoint:_aniLayer.position], [NSValue valueWithCGPoint:_aniLayer.presentationLayer.position]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint position = [touches.anyObject locationInView:self.view];
    [self basicAnimation:position];
}

- (void)basicAnimation:(CGPoint)position
{
    CABasicAnimation *baseAni = [CABasicAnimation animationWithKeyPath:@"position"];
    baseAni.delegate = self;
    baseAni.toValue = [NSValue valueWithCGPoint:position];
    baseAni.duration = 3;
    baseAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [baseAni setValue:[NSValue valueWithCGPoint:position] forKey:@"positionToEnd"];
    //    baseAni.speed = 0.1;
    baseAni.removedOnCompletion = NO;
    baseAni.fillMode = kCAFillModeForwards;
    [_aniLayer addAnimation:baseAni forKey:@"my"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CGPoint position = [[anim valueForKey:@"positionToEnd"] CGPointValue];
    _aniLayer.position = position;
}

@end
