//
//  CKUIMenuDrawUtil.m
//  UIMenuController
//
//  Created by ceekay1991 on 15/11/11.
//  Copyright © 2015年 com.crh.objc.. All rights reserved.
//

#import "CKUIDrawArcUtil.h"

@implementation CKUIDrawArcUtil

+(void)bubblePath:(CGMutablePathRef)bubblePath
 addRoundRectPath:(CGRect)rect
        andRadius:(CGFloat)radius

{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    // 移动到初始点
    CGPathMoveToPoint(bubblePath, NULL, radius, 0);
    
    // 绘制第1个1/4圆弧和第1条线,左上圆弧
    
    CGPathAddArc(bubblePath, NULL, radius, radius, radius,1.5 *M_PI, M_PI,1);
    
    CGPathAddLineToPoint(bubblePath,NULL, 0, height - radius);
    
    // 绘制第2个1/4圆弧和第2条线，左下圆弧
    
    CGPathAddArc(bubblePath, NULL, radius, height - radius, radius,M_PI,0.5 * M_PI,1);
    
    CGPathAddLineToPoint(bubblePath,NULL, width - radius, height);
    CGPathAddArc(bubblePath, NULL, width - radius, height - radius, radius,0.5 *M_PI, 0,1);
    CGPathAddLineToPoint(bubblePath,NULL, width,height - radius);
    // 绘制第4个1/4圆弧和第4条线,右上圆弧
    CGPathAddArc(bubblePath, NULL, width - radius, radius, radius,0, -0.5 *M_PI,1);
    CGPathAddLineToPoint(bubblePath,NULL,radius,0);
    
}

@end
