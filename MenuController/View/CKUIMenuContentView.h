//
//  CKUIMenuContentView.h
//  UIMenuController
//
//  Created by ceekay1991 on 15/11/11.
//  Copyright © 2015年 com.crh.objc.. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CKUIMenuContentView;
@protocol CKUIMenuContentViewDelegate <NSObject>

-(void)smearMenuContentView:(CKUIMenuContentView *)contentView menuItemClicked:(int)itemIndex;

@end
@interface CKUIMenuContentView : UIView
@property(nonatomic,assign)CGFloat radius;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,weak)id<CKUIMenuContentViewDelegate> delegate;
-(id)initWithFrame:(CGRect)frame
         andRadius:(CGFloat)radius
         andTitles:(NSArray *)titles;
-(void)showOtherView:(UIView *)aView onItem:(int)itemIndex;
-(void)hiddenOtherView:(UIView *)aView onItem:(int)itemIndex;
@end
