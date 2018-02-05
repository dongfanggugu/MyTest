//
//  ViewController.m
//  test
//
//  Created by changhaozhang on 2017/8/17.
//  Copyright © 2017年 changhaozhang. All rights reserved.
//

#import "ViewController.h"
#import "CustView.h"
#import "SocketViewController.h"
#import "location.h"

@interface ViewController () <CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) CALayer *aniLayer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self initView];
//    [self customView];
    [self animation];
//    [[location sharedLocation] startLocationService];
    
//    [NSTimer scheduledTimerWithTimeInterval:10 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"inner time: %ld", (NSInteger)[[NSDate date] timeIntervalSince1970]);
//    }];
}

- (void)initView
{
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = CGRectMake(0, 0, 200, 200);
    _shapeLayer.position = self.view.center;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    //设置线条宽度和颜色
    _shapeLayer.lineWidth = 5.0f;
    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    //贝塞尔曲线 椭圆
//    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 200)];
//    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:100 startAngle:-M_PI_2 endAngle:M_PI * 3 / 2 clockwise:YES];
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:100 startAngle: 0 endAngle:M_PI * 2 clockwise:YES];
    //关联贝塞尔曲线和CAShapeLayer
    //关联贝塞尔曲线和CAShapeLayer
    _shapeLayer.path = circlePath.CGPath;
    
    _shapeLayer.strokeStart = 0;
    _shapeLayer.strokeEnd = 0;
    
    [self.view.layer addSublayer:_shapeLayer];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor greenColor];
    
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 100;
    
    [self.view addSubview:btn];
    
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] init];
    [recognizer addTarget:self action:@selector(longPress:)];
    recognizer.minimumPressDuration = 1;
    [btn addGestureRecognizer:recognizer];
    
    [btn addTarget:self action:@selector(socket) forControlEvents:UIControlEventTouchUpInside];
}

- (void)longPress:(UILongPressGestureRecognizer *)recognizer
{
    if (UIGestureRecognizerStateBegan == recognizer.state)
    {
        [self addTimer];
    }
}

- (void)addTimer
{
    _shapeLayer.strokeStart = 0;
    _shapeLayer.strokeEnd = 0;
    [NSTimer scheduledTimerWithTimeInterval:0.1f repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"zhenhao:%.3lf", _shapeLayer.strokeEnd);
        
        if (_shapeLayer.strokeEnd >= 1)
        {
            [timer invalidate];
        }
        
        _shapeLayer.strokeEnd = _shapeLayer.strokeEnd + 0.01;
    }];
}

- (void)customView
{
    CustView *view = [[CustView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor clearColor];
    view.center = CGPointMake(150, 100);
    [self.view addSubview:view];
}

- (void)socket
{
    SocketViewController *controller = [[SocketViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}



@end
