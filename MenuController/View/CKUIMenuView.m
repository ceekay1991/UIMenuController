//
//  CKUIMenuView.m
//  UIMenuController
//
//  Created by ceekay1991 on 15/11/11.
//  Copyright © 2015年 com.crh.objc.. All rights reserved.
//

#import "CKUIMenuView.h"
typedef NS_ENUM(int, CKUIMenuBgViewArrowDirection)
{
    E_LeftDown,
    E_LeftUp,
    E_RightUp,
    E_RightDown,
};
const CGFloat CKSmearMenuViewHeight = 45;
const CGFloat CKSmearMenuContentViewHeight = 36;
const CGFloat CKSmearMenuContentViewArrowWidth = 16;
const CGFloat CKSmearMenuContentViewArrowHeight = 9;
const CGFloat CKSmearMenuViewMarginTarget = 5;
const CGFloat CKSmearMenuViewToEdge = 20;
const CGFloat CKSmearMenuViewArrowToEdge = 23;

@implementation CKUIMenuView
{
    CKUIMenuBgViewArrowDirection _direction;
    CKUIMenuContentView *_contentView;
    CGRect _roundRect;
    UIView *_showInView;
    CGFloat _radius;
    CGMutablePathRef _arrowpath;
    
}
- (id)initWithShowView:(UIView *)showView
         rightTopNoMenuRect:(CGRect)rect
             radius:(CGFloat)radius
{
    self = [super init];
    if (self)
    {
        _showInView = showView;
        _noMenuRect = rect;
        _direction = E_RightUp;
        _radius = radius;
        [_showInView addSubview:self];
        
    }
    return self;
}
-(void)showOtherView:(UIView *)aView onItem:(int)itemIndex
{
    [_contentView showOtherView:aView onItem:itemIndex];
}
-(void)hiddenOtherView:(UIView *)aView onItem:(int)itemIndex
{
    [_contentView hiddenOtherView:aView onItem:itemIndex];
}
-(void)showInRect:(CGRect)targetRect
        andTitles:(NSArray *)titles

{
    CGPoint targetPoint = CGPointMake(CGRectGetMaxX(targetRect), CGRectGetMinY(targetRect));
    
    CGFloat targetHeight = CGRectGetHeight(targetRect);
    
    if (_contentView)
    {
        [_contentView removeFromSuperview];
        _contentView = nil;
    }
    CGRect fakeRect = CGRectMake(0, 0, 0, CKSmearMenuContentViewHeight);
    _contentView = [[CKUIMenuContentView alloc]initWithFrame:fakeRect
                                                   andRadius:_radius
                                                   andTitles:titles];
    _contentView.delegate = _delegate;
    CGFloat max_x = CGRectGetWidth(_contentView.frame)+targetPoint.x+CKSmearMenuViewToEdge;
    
    BOOL arrowIsLeft = NO;
    //高度 超出了左上角的限定区域
    CGFloat min_y = targetPoint.y-CKSmearMenuViewMarginTarget-CKSmearMenuViewHeight;
    BOOL inNoMenuRect = min_y < CGRectGetMaxY(_noMenuRect);
    
    BOOL isOverBoundsNotLeftTop = max_x <= CGRectGetMaxX(_showInView.frame)&&!inNoMenuRect;
    BOOL isOverBounds = max_x<=CGRectGetMaxX(_noMenuRect)&&inNoMenuRect;
    if (isOverBoundsNotLeftTop||isOverBounds)
    {
        arrowIsLeft = YES;
    }
    
    if (!arrowIsLeft)
    {
        if (inNoMenuRect||min_y<0)
        {
            _direction = E_RightUp;
        }
        else
        {
            _direction = E_RightDown;
        }
    }
    else
    {
        if (min_y<0)
        {
            _direction = E_LeftUp;
        }
        else
        {
            _direction = E_LeftDown;
        }
    }
    CGFloat w = CGRectGetWidth(_contentView.bounds);
    CGFloat h = CKSmearMenuViewHeight;
    
    CGFloat arrowWidth = CKSmearMenuContentViewArrowWidth;
    CGFloat arrowToLeft = CKSmearMenuViewArrowToEdge;
    CGFloat arrowheight = CKSmearMenuContentViewArrowHeight;
    
    // LEFT_DOWN
    CGFloat
    arrowPointLeft_x =arrowToLeft,
    arrowPointLeft_y =h-arrowheight,
    
    arrowPointCenter_x =arrowPointLeft_x+0.5*arrowWidth,
    arrowPointCenter_y =h,
    
    arrowPointRight_x =arrowPointLeft_x+arrowWidth,
    arrowPointRight_y =h-arrowheight;
    _roundRect = CGRectMake(0, 0, w, h-arrowheight);
    
    CGFloat arrowMagin = arrowToLeft +arrowWidth/2;
    CGFloat self_x = (targetPoint.x-arrowMagin)>CKSmearMenuViewToEdge?(targetPoint.x-arrowMagin):CKSmearMenuViewToEdge;
    CGFloat self_y = min_y;
    switch (_direction)
    {
        case E_RightDown:
        {
            if ((targetPoint.x+arrowMagin)+CKSmearMenuViewToEdge>CGRectGetMaxX(_showInView.frame))
            {
                self_x = (targetPoint.x+arrowMagin)- w-CKSmearMenuViewToEdge;
            }
            else
            {
                self_x = targetPoint.x+arrowMagin - w;
            }
            self_y = min_y;
            arrowPointLeft_x =w-arrowToLeft-arrowWidth,
            arrowPointLeft_y =h-arrowheight,
            
            arrowPointCenter_x =arrowPointLeft_x+0.5*arrowWidth,
            arrowPointCenter_y =h,
            
            arrowPointRight_x =arrowPointCenter_x+0.5*arrowWidth,
            arrowPointRight_y =h-arrowheight;
            _roundRect = CGRectMake(0, 0, w, h-arrowheight);
        }
            break;
        case E_RightUp:
        {
            if (targetPoint.x+CKSmearMenuViewToEdge>CGRectGetMaxX(_showInView.frame))
            {
                self_x = targetPoint.x+arrowMagin - w-CKSmearMenuViewToEdge;
            }
            else
            {
                self_x = targetPoint.x+arrowMagin - w;
            }
            
            self_y = targetPoint.y+CKSmearMenuViewMarginTarget+targetHeight;
            
            arrowPointLeft_x =w-arrowToLeft-arrowWidth,
            arrowPointLeft_y =arrowheight,
            
            arrowPointCenter_x =arrowPointLeft_x+0.5*arrowWidth,
            arrowPointCenter_y =0,
            
            arrowPointRight_x =arrowPointCenter_x+0.5*arrowWidth,
            arrowPointRight_y =arrowheight;
            _roundRect = CGRectMake(0, arrowheight, w, h-arrowheight);
        }
            break;
        case E_LeftUp:
        {
            self_x = targetPoint.x-arrowMagin>CKSmearMenuViewToEdge?targetPoint.x-arrowMagin:CKSmearMenuViewToEdge;
            self_y = targetPoint.y+CKSmearMenuViewMarginTarget+targetHeight;
            arrowPointLeft_x =arrowToLeft,
            arrowPointLeft_y =arrowheight,
            
            arrowPointCenter_x =arrowPointLeft_x+0.5*arrowWidth,
            arrowPointCenter_y =0,
            
            arrowPointRight_x =arrowPointCenter_x+0.5*arrowWidth,
            arrowPointRight_y =arrowheight;
            _roundRect = CGRectMake(0, arrowheight, w, h-arrowheight);
        }
            break;
            
        default:
            break;
    }
    CGRect  selfFrame = CGRectMake(self_x, self_y, w, h);
    
    CGMutablePathRef arrowpath= CGPathCreateMutable();
    CGPathMoveToPoint(arrowpath, NULL, arrowPointLeft_x, arrowPointLeft_y);
    CGPathAddLineToPoint(arrowpath, NULL, arrowPointCenter_x, arrowPointCenter_y);
    CGPathAddLineToPoint(arrowpath, NULL, arrowPointRight_x, arrowPointRight_y);
    _arrowpath = arrowpath;
    _contentView.frame = _roundRect;
    _contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentView];
    self.frame = selfFrame;
    [self setNeedsDisplay];
    self.backgroundColor = [UIColor clearColor];
    
}
-(void)drawRect:(CGRect)rect
{
    if (_arrowpath)
    {
        CGContextRef context=UIGraphicsGetCurrentContext();
        CGContextBeginPath(context);
        CGContextSetFillColorWithColor(context,[UIColor blackColor].CGColor);
        CGContextAddPath(context, _arrowpath);
        CGContextFillPath(context);
    }
}

@end

