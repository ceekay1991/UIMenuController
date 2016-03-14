//
//  CKUIMenuDrawUtil.h
//  UIMenuController
//
//  Created by ceekay1991 on 15/11/11.
//  Copyright © 2015年 com.crh.objc.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
/*!
     @header    CKUIDrawArcUtil.h
     @abstract    画圆角工具类
     @discussion
     @author    ceekay1991
     @copyright    Baidu
     @version    1.0 2015-11-11 13:46:05 Creation
 */
@interface CKUIDrawArcUtil:NSObject

/*!
     @method
     @abstract    画圆角
     @discussion
     @param     bubblePath     需要添加圆角的bubblePath
     @param     rect     圆角矩形区域
     @param     radius     圆角大小
     @result
 */
+(void)bubblePath:(CGMutablePathRef)bubblePath
 addRoundRectPath:(CGRect)rect
        andRadius:(CGFloat)radius;

@end;
