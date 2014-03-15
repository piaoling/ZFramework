//
//  ZFViewDeckViewController.h
//  ZFramework
//
//  Created by zhaofeng on 14-3-15.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//


//只是一个概念描述，实现和功能都不完整，具体项目中需要根据效果具体开发
//要参照IIViewDeckController的源码来定制
#import <UIKit/UIKit.h>

@interface ZFViewDeckViewController : UIViewController

@property(nonatomic, strong) UIViewController *centerController;
@property(nonatomic, strong) UIViewController *rightController;
@property(nonatomic, strong) UIViewController *leftController;

@end
