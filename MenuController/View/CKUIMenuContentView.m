//
//  CKUIMenuContentView.m
//  UIMenuController
//
//  Created by ceekay1991 on 15/11/11.
//  Copyright © 2015年 com.crh.objc.. All rights reserved.
//

#import "CKUIMenuContentView.h"
#import "CKUIDrawArcUtil.h"
const int CKSmearMenuContentViewTag = 200;
#define CKSmearMenuContentViewFount [UIFont systemFontOfSize:14]
#define ColorRedGreenBlue(r, g, b)				[UIColor colorWithRed : (r) / 255.0f green : (g) / 255.0f blue : (b) / 255.0f alpha : 1.0f]

@interface UIImage(ColorImage)
+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius;
@end
@implementation UIImage(ColorImage)
+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius {
    CGFloat minEdgeSize = cornerRadius * 2 + 1;
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}


@end



@implementation CKUIMenuContentView

-(id)initWithFrame:(CGRect)frame
         andRadius:(CGFloat)radius
         andTitles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _radius = radius;
        _titles = titles;
        self.frame = [self initContentSubView];
    }
    return self;
}

-(CGRect)initContentSubView
{
    for (UIView * view in self.subviews)
    {
        [view removeFromSuperview];
    }
    CGRect frame = self.frame;
    
    CGFloat menuMinwidth = 62;
    CGFloat lineWith = 1;
    CGFloat menuHeight = frame.size.height;
    if ([[UIScreen mainScreen]scale]==2)
    {
        lineWith = 0.5;
    }
    CGFloat x = 0, y = 0;
    for (int i = 0; i<[_titles count]; i++)
    {
        NSString *title = [_titles objectAtIndex:i];
        UIButton *item = [self menuItemWithTitle:title andInex:i];
        CGFloat titleWidth = [title sizeWithFont:CKSmearMenuContentViewFount].width+2*_radius;
        if (titleWidth<menuMinwidth)
        {
            titleWidth = menuMinwidth;
        }
        item.frame = CGRectMake(x, y, titleWidth, menuHeight);
        [self addSubview:item];
        x +=titleWidth;
        if (i != [_titles count]-1)
        {
            UIView *line = [self seperateLine];
            line.frame = CGRectMake(x, 0, lineWith, menuHeight);
            [self addSubview:line];
            x+=lineWith;
        }
    }
    CGSize size = CGSizeMake(x, menuHeight);
    frame.size = size;
    return frame;
}
-(void)showOtherView:(UIView *)aView onItem:(int)itemIndex
{
    UIButton *button = (UIButton *)[self viewWithTag:itemIndex+CKSmearMenuContentViewTag];
    button.hidden = YES;
    aView.center = button.center;
    [self addSubview:aView];
}
-(void)hiddenOtherView:(UIView *)aView onItem:(int)itemIndex
{
    [aView removeFromSuperview];
    UIButton *button = (UIButton *)[self viewWithTag:itemIndex+CKSmearMenuContentViewTag];
    button.hidden = NO;
}
-(UIButton *)menuItemWithTitle:(NSString *)title andInex:(int)index
{
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    [item.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [item setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4] forState:UIControlStateHighlighted];
    [item setTitle:title forState:UIControlStateNormal];
    [item addTarget:self action:@selector(menuItemTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    item.tag = index+CKSmearMenuContentViewTag;
    UIImage *bgimg = [UIImage imageWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.4] cornerRadius:_radius];
    
    [item setBackgroundImage:bgimg forState:UIControlStateHighlighted];
    return item;
}
-(UIView *)seperateLine
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = ColorRedGreenBlue(102, 102, 102);
    return view;
}
-(void)menuItemTouchUpInside:(UIButton *)item
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(smearMenuContentView:menuItemClicked:)])
    {
        [self.delegate smearMenuContentView:self menuItemClicked:(int)item.tag - CKSmearMenuContentViewTag];
    }
}
-(void)drawRect:(CGRect)rect
{
    if (CGRectEqualToRect(CGRectZero, rect))
    {
        return;
    }
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    [CKUIDrawArcUtil bubblePath:path addRoundRectPath:rect andRadius:_radius];
    CGContextBeginPath(context);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGPathRelease(path);
}

@end

