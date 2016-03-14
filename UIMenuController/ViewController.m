//
//  ViewController.m
//  UIMenuController
//
//  Created by ceekay1991 on 16/3/14.
//  Copyright © 2016年 com.crh.objc. All rights reserved.
//

#import "ViewController.h"
#import "CKUIMenuController.h"
@interface ViewController ()<CKUIMenuControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *leftBottom;
@property (weak, nonatomic) IBOutlet UIButton *center;
@property (weak, nonatomic) IBOutlet UIButton *rightTop;
@property (weak, nonatomic) IBOutlet UIButton *rightBottom;
@property (weak, nonatomic) IBOutlet UIButton *leftTop;
@property (weak, nonatomic) IBOutlet UIButton *noMenu;
@property (nonatomic,strong) CKUIMenuController *menuController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _menuController = [[CKUIMenuController alloc]initWithShowView:self.view];
    _menuController.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)menuController:(CKUIMenuController *)controller menuItemClicked:(int)itemIndex
{
    if (itemIndex==0) {
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activity.frame = CGRectMake(5, 5, 35, 35);
        [activity startAnimating];
        [controller showOtherView:activity onItem:itemIndex];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_menuController hiddenOtherView:activity onItem:itemIndex];
            [_menuController hiddenMenu:YES];
        });
    }
    else{
         [_menuController hiddenMenu:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showMenu:(UIButton *)btn
{
    if (!_menuController) {
        _menuController = [[CKUIMenuController alloc]initWithShowView:self.view];
        _menuController.delegate = self;
    }
    
    //设置不显示菜单的区域
    CGRect  rect = _noMenu.frame;
    rect.origin.y = CGRectGetMaxY(rect);
    [_menuController setNoMenuRect:rect];
    
    
    CGRect frame = [self.view convertRect:btn.frame fromView:btn.superview];
    frame.size.width = CGRectGetWidth(frame)*0.5;
    [_menuController showInRect:frame andTitles:@[@"搜索",@"复制"]];
    
   
}


@end
