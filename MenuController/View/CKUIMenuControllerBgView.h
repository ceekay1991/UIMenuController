//
//  CKUIMenuControllerBgView.h
//  UIMenuController
//
//  Created by ceekay1991 on 15/11/11.
//  Copyright © 2015年 com.crh.objc.. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CKUIMenuControllerBgView;
@protocol CKUIMenuControllerBgViewDelegate <NSObject>
- (void)menuControllerBgViewTouched:(UIView *)view;
@end
@interface CKUIMenuControllerBgView : UIView
@property(nonatomic,weak)id<CKUIMenuControllerBgViewDelegate> delegate;
@end
