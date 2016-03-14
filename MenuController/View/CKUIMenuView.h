//
//  CKUIMenuView.h
//  UIMenuController
//
//  Created by ceekay1991 on 15/11/11.
//  Copyright © 2015年 com.crh.objc.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKUIMenuContentView.h"

@interface CKUIMenuView:UIView

@property(nonatomic,assign)CGRect noMenuRect;
- (id)initWithShowView:(UIView *)showView
         rightTopNoMenuRect:(CGRect)rect
             radius:(CGFloat)radius;
-(void)showInRect:(CGRect)targetRect
        andTitles:(NSArray *)titles;
-(void)showOtherView:(UIView *)aView onItem:(int)itemIndex;
-(void)hiddenOtherView:(UIView *)aView onItem:(int)itemIndex;
@property(nonatomic,weak)id delegate;
@end
