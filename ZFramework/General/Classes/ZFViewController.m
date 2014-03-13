//
//  ZFViewController.m
//  ZFramework
//
//  Created by zhaofeng on 14-1-19.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import "ZFViewController.h"
#import "Macros.h"
@interface ZFViewController ()

@end

@implementation ZFViewController

- (UIViewController *)viewControllerFromStoryboard:(NSString *)stroyboardName identifier:(NSString *)identifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:stroyboardName bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    return viewController;
}

- (void)setUpForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    singleTapGR.delegate = self;
    singleTapGR.cancelsTouchesInView = NO;
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
//如果设置消失键盘功能，请在子类中重载
//    gestureRecognizer.cancelsTouchesInView = NO;
//    [self.view endEditing:YES];
}

#pragma mark--UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //不要把按钮的点击事件，当作消失键盘的背景点击事件
    if([touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    return YES;
}

#pragma mark--蒙层功能
- (UIView *)hubShowInView
{
    UIView *inView;
    if (self.tableView) {
        inView = self.tableView;
    }
    else {
        inView = self.view;
    }
    return inView;
}

- (void)showLoadingView
{
    [self showLoadingViewWithText:TIP_LOADING];
}

- (void)showLoadingViewWithText:(NSString *)text
{
    if (!self.hud) {
        self.hud = [HudUtils hudWithLabel:text inView:[self hubShowInView]];
    }
    
}

- (void)hideLoadingView
{
    [self.hud hide:YES];
    self.hud = nil;
}

- (void)showErrorView
{
    [self showErrorViewWithText:TIP_SERVER_ERROR delay:TIP_DELAY_IN_SECOND];
}

- (void)showErrorViewWithText:(NSString *)text delay:(NSInteger)delay
{
    [HudUtils hudWithLabel:text customView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mb_error"]] inView:self.view delay:delay];
}

- (void)hideErrorView
{
    [self.hud hide:YES];
    self.hud = nil;
}

- (void)showSuccessView:(NSString *)text
{
    [self showSuccessView:text delay:TIP_DELAY_IN_SECOND];
}

- (void)showSuccessView:(NSString *)text imageName:(NSString *)imageName delay:(NSInteger)delay
{
    [HudUtils hudWithLabel:text customView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]] inView:[self hubShowInView] delay:delay];
}

- (void)showSuccessView:(NSString *)text delay:(NSInteger)delay
{
    [HudUtils hudWithLabel:text customView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check_mark"]] inView:[self hubShowInView] delay:delay];
}

- (void)showSuccessView:(NSString *)text detailText:(NSString *)detailText delay:(NSInteger)delay
{
    [HudUtils hudWithLabel:text detailText:detailText customView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check_mark"]] inView:[self hubShowInView] delay:delay];
}

- (void)showWarnView:(NSString *)text
{
    [self showWarnView:text delay:TIP_DELAY_IN_SECOND];
}

- (void)showWarnView:(NSString *)text delay:(NSInteger)delay
{
    [HudUtils hudWithLabel:text customView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mb_warn"]] inView:[self hubShowInView] delay:delay];
}

- (void)showWarnView:(NSString *)text detailText:(NSString *)detailText delay:(NSInteger)delay
{
    [HudUtils hudWithLabel:text detailText:detailText customView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mb_warn"]] inView:[self hubShowInView] delay:delay];
}



@end
