//
//  ZFViewController.h
//  ZFramework
//
//  Created by zhaofeng on 14-1-19.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "HudUtils.h"

@interface ZFViewController : UIViewController<UIGestureRecognizerDelegate>
//基于tableView的controllerView的备用
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) MBProgressHUD *hud;

//通过stroyboard创建VC
- (UIViewController *)viewControllerFromStoryboard:(NSString *)stroyboardName identifier:(NSString *)identifier;

//设置是否支持点击背景 消失键盘功能
- (void)setUpForDismissKeyboard;
- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer;

//通过第三方控件MBProgressHUB,为ViewController提供蒙层提示功能
//注意show view和hide view必须成对调用
- (void)showLoadingView;
- (void)showLoadingViewWithText:(NSString *)text;
- (void)hideLoadingView;

- (void)showErrorView;
- (void)showErrorViewWithText:(NSString *)text delay:(NSInteger)delay;
- (void)hideErrorView;

- (void)showSuccessView:(NSString *)text;
- (void)showSuccessView:(NSString *)text imageName:(NSString *)imageName delay:(NSInteger)delay;
- (void)showSuccessView:(NSString *)text delay:(NSInteger)delay;
- (void)showSuccessView:(NSString *)text detailText:(NSString *)detailText delay:(NSInteger)delay;

- (void)showWarnView:(NSString *)text;
- (void)showWarnView:(NSString *)text delay:(NSInteger)delay;
- (void)showWarnView:(NSString *)text detailText:(NSString *)detailText delay:(NSInteger)delay;

@end
