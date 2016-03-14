//
//  CKUIMenuController.m
//  UIMenuController
//
//  Created by ceekay1991 on 15/11/11.
//  Copyright © 2015年 com.crh.objc.. All rights reserved.
//

#import "CKUIMenuController.h"
#import "CKUIMenuContentView.h"
#import "CKUIMenuControllerBgView.h"
#import "CKUIMenuView.h"
@interface CKUIMenuController()<CKUIMenuContentViewDelegate,CKUIMenuControllerBgViewDelegate>
{
    CKUIMenuControllerBgView *_bgView;
    CKUIMenuView *_menuView;
    UIView *_showInView;
}
@end

@implementation CKUIMenuController
- (id)initWithShowView:(UIView *)showView
         rightTopNoMenuRect:(CGRect)rect
             radius:(CGFloat)radius
{
    self = [super init];
    if (self)
    {
        _bgView = [[CKUIMenuControllerBgView alloc]initWithFrame:showView.bounds];
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.delegate = self;
        [showView addSubview:_bgView];
        
        _menuView = [[CKUIMenuView alloc]initWithShowView:_bgView rightTopNoMenuRect:rect radius:radius];
        _menuView.alpha = 0;
        _menuView.delegate = self;
    }
    return self;
}
- (id)initWithShowView:(UIView *)showView
                radius:(CGFloat)radius
{
    return [self initWithShowView:showView rightTopNoMenuRect:CGRectZero radius:radius];
}
- (id)initWithShowView:(UIView *)showView
{
    return [self initWithShowView:showView rightTopNoMenuRect:CGRectZero radius:8];
}

- (void)menuControllerBgViewTouched:(UIView *)view;
{
    [self hiddenMenu:NO];
   
}
-(void)showInRect:(CGRect)targetRect
        andTitles:(NSArray *)titles
{
    [_menuView showInRect:targetRect andTitles:titles];
    [self showMenu];
}

-(void)smearMenuContentView:(CKUIMenuContentView *)contentView menuItemClicked:(int)itemIndex
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuController:menuItemClicked:)])
    {
        [self.delegate menuController:self menuItemClicked:itemIndex];
    }
    //[self hiddenMenu];
}
-(void)showOtherView:(UIView *)aView onItem:(int)itemIndex
{
    [_menuView showOtherView:aView onItem:itemIndex];
}
-(void)hiddenOtherView:(UIView *)aView onItem:(int)itemIndex
{
    [_menuView hiddenOtherView:aView onItem:itemIndex];
}
-(void)setNoMenuRect:(CGRect)rect
{
    [_menuView setNoMenuRect:rect];
}
-(void)hiddenMenu:(BOOL)animation
{
    CGFloat duration = animation?0.35:0;
    [UIView animateWithDuration:duration animations:^{
        _menuView.alpha = 0.;
    } completion:^(BOOL finished) {
        _bgView.hidden = YES;
        if (_delegate && [_delegate respondsToSelector:@selector(menuControllerDissMissMenu:)]) {
            [_delegate menuControllerDissMissMenu:self];
        }
    }];
}
-(void)showMenu
{
    _bgView.hidden = NO;
    [UIView animateWithDuration:0.35 animations:^{
        _menuView.alpha = 1.;
    } completion:^(BOOL finished) {
        
    }];
}
@end

