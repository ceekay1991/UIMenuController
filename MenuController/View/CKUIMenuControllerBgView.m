//
//  CKUIMenuControllerBgView.m
//  UIMenuController
//
//  Created by ceekay1991 on 15/11/11.
//  Copyright © 2015年 com.crh.objc.. All rights reserved.
//

#import "CKUIMenuControllerBgView.h"

@implementation CKUIMenuControllerBgView


//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(smearBgHitTest:withEvent:)])
//    {
//        return [self.delegate smearBgHitTest:point withEvent:event];
//    }
//    return [super hitTest:point withEvent:event];
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if ([touches anyObject].view == self) {
        if (_delegate && [_delegate respondsToSelector:@selector(menuControllerBgViewTouched:)]) {
            [_delegate menuControllerBgViewTouched:self];
        }
    }
}

@end
