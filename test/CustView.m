//
//  CustView.m
//  test
//
//  Created by changhaozhang on 2017/8/18.
//  Copyright © 2017年 changhaozhang. All rights reserved.
//

#import "CustView.h"

@implementation CustView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, rect);
    
    //设置图形上下文状态属性
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    CGContextSetLineWidth(context, 1);
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
