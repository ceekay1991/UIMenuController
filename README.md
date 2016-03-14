##实现类似UIMenuController的功能 点击弹出菜单

#一、需要添加的其它依赖
1、添加MenuController目录到工程中
#二、使用步骤
* 1、初始化
		
	   if (!_menuController) {
        _menuController = [[BDUIMenuController alloc]initWithShowView:self.view];
        _menuController.delegate = self;
    		}
    
    		//设置不显示菜单的区域 可选 
    		CGRect  rect = _noMenu.frame;
    		rect.origin.y = CGRectGetMaxY(rect);
    		[_menuController setNoMenuRect:rect];

* 2、展现

  			CGRect frame = [self.view convertRect:btn.frame fromView:btn.superview];
    		frame.size.width = CGRectGetWidth(frame)*0.5;
    		[_menuController showInRect:frame andTitles:@[@"搜索",@"复制"]];

* 3、在菜单项上展示额外的View

		 UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activity.frame = CGRectMake(5, 5, 35, 35);
        [activity startAnimating];
        [controller showOtherView:activity onItem:itemIndex];
  #截图
  ![image](https://raw.githubusercontent.com/ceekay1991/UIMenuController/master/screenShoot/1.png)
 ----------------------
 ----------------------
  ![image](https://raw.githubusercontent.com/ceekay1991/UIMenuController/master/screenShoot/2.png)
   ----------------------
 ----------------------
  ![image](https://raw.githubusercontent.com/ceekay1991/UIMenuController/master/screenShoot/4.png)
  ----------------------
 ----------------------
  ![image](https://raw.githubusercontent.com/ceekay1991/UIMenuController/master/screenShoot/3.png)
   ----------------------
 ----------------------