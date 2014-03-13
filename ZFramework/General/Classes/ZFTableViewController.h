//
//  ZFTableViewController.h
//  ZFramework
//
//  Created by zhaofeng on 14-2-12.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HudUtils.h"
#import "MBProgressHUD.h"
//#import "TNTableHeaderView.h"
//#import "TA.h"
#import "SVPullToRefresh.h"

#define kNumberPerPagePureNumber 10
#define kNumberPerPage @(kNumberPerPagePureNumber)

@protocol ZFTableViewControllerDelegate;

@interface ZFTableViewController : UITableViewController<UIScrollViewDelegate>

@property (nonatomic, assign) BOOL loading; //是否正在加载数据
@property (nonatomic, assign) NSInteger numberOfSections;
@property (nonatomic, assign) BOOL endReached;  //是否所有数据已全部加载完毕
@property (assign, nonatomic) int pageCurrent; //当前等待加载的页数
@property (assign, nonatomic) int pageCount; //总页数
@property (assign, nonatomic) int numberPerPage; //每页加载的数据数量
@property (assign, nonatomic) BOOL isFirstPageLoading; //待加载的数据是否是第一页
@property (assign, nonatomic) BOOL isLastPageLoaded; //最后一页数据是否加载，即数据是否已全部加载完毕
@property (nonatomic, weak)   id<ZFTableViewControllerDelegate> delegateForHeaderView;
@property (strong, nonatomic) MBProgressHUD *hud;
//@property (strong, nonatomic) TNTableHeaderView *headerView;
@property (assign, nonatomic) BOOL isShowButtonAndTitle;

@property (assign, nonatomic) BOOL isShowPullRefreshView;//下拉刷新

- (UIViewController *)viewControllerFromStoryboard:(NSString *)stroyboardName identifier:(NSString *)identifier;
- (void)loadData;

- (UIView *)errorView;
- (UIView *)loadingView;

- (void)showLoadingView;
- (void)showLoadingViewWithText:(NSString *)text;
- (void)hideLoadingView;

- (void)showErrorView;
- (void)showErrorViewWithText:(NSString *)text delay:(NSInteger)delay;
- (void)hideErrorView;

- (void)showSuccessView:(NSString *)text;
- (void)showSuccessView:(NSString *)text delay:(NSInteger)delay;
- (void)showSuccessView:(NSString *)text detailText:(NSString *)detailText delay:(NSInteger)delay;

- (void)showWarnView:(NSString *)text;
- (void)showWarnView:(NSString *)text delay:(NSInteger)delay;
- (void)showWarnView:(NSString *)text detailText:(NSString *)detailText delay:(NSInteger)delay;

@end

@protocol ZFTableViewControllerDelegate <NSObject>

@optional

- (void)whenTableViewHeaderViewButtonPressed:(UIButton *)button AtIndex:(NSInteger)index;
- (void)whenTableViewHeaderViewPullForReloadData;
- (BOOL)isNeedTableViewHeaderHideButton;

@end
