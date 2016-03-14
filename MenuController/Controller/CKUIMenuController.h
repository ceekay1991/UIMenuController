//
//  CKUIMenuController.h
//  UIMenuController
//
//  Created by ceekay1991 on 15/11/11.
//  Copyright © 2015年 com.crh.objc.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CKUIMenuController;
@protocol CKUIMenuControllerDelegate <NSObject>

- (void)menuController:(CKUIMenuController *)controller menuItemClicked:(int)itemIndex;

@optional
- (void)menuControllerDissMissMenu:(CKUIMenuController *)controller;
@end
/*!
     @header    CKUIMenuController.h
     @abstract    实现类似系统UIMenuController的功能
     @discussion
     @author    ceekay1991
     @copyright    Baidu
     @version    1.0 2015-11-11 14:02:36 Creation
 */
@interface CKUIMenuController : NSObject


@property (nonatomic, weak) id<CKUIMenuControllerDelegate> delegate;

/*!
     @method
     @abstract    初始化方法
     @discussion
     @param     showView     menu的superView
     @param     rect     superView上右上角不显示menu的区域
                         后续实现任意path不显示Menu
     @param     radius     menu圆角的大小
     @result    CKUIMenuController
 */
- (id)initWithShowView:(UIView *)showView
         rightTopNoMenuRect:(CGRect)rect
             radius:(CGFloat)radius;
/*!
 @method
 @abstract    初始化方法
 @discussion
 @param     showView     menu的superView
 @param     radius     menu圆角的大小
 @result    CKUIMenuController
 */
- (id)initWithShowView:(UIView *)showView
                radius:(CGFloat)radius;

/*!
 @method
 @abstract    初始化方法
 @discussion
 @param     showView     menu的superView
 @result    CKUIMenuController
 */
- (id)initWithShowView:(UIView *)showView;

/*!
     @method
     @abstract    显示菜单
     @discussion
     @param     targetRect     显示菜单的目标控件的frame
     @param     titles     菜单项的标题
     @result
 */
- (void)showInRect:(CGRect)targetRect
         andTitles:(NSArray *)titles;

/*!
     @method
     @abstract    隐藏菜单
     @discussion
     @param     animation     YES显示动画
     @result
 */
- (void)hiddenMenu:(BOOL)animation;

/*!
     @method
     @abstract    设置右上角不显示menu的区域
     @discussion
     @param     rect
     @result
 */
- (void)setNoMenuRect:(CGRect)rect;

/*!
     @method
     @abstract    在菜单项上添加其它View
     @discussion
     @param     aView 要展示的View
     @param     itemIndex     菜单项itemsindex 与初始化参数titles index一致
     @result
 */
- (void)showOtherView:(UIView *)aView
               onItem:(int)itemIndex;

/*!
     @method
     @abstract     隐藏菜单项上其它View
     @discussion
     @param     aView     要隐藏的View
     @param     itemIndex     与初始化参数titles index一致
     @result
 */
- (void)hiddenOtherView:(UIView *)aView
                 onItem:(int)itemIndex;

@end
