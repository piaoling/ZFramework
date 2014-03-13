//
//  ZFTableViewController.m
//  ZFramework
//
//  Created by zhaofeng on 14-2-12.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import "ZFTableViewController.h"

@interface ZFTableViewController ()
@end

@implementation ZFTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.endReached = NO;
    self.loading = NO;
    self.pageCount = 0;
    self.pageCurrent = 1;
    self.numberOfSections = 1;
    
    if (self.isShowPullRefreshView) {
        __weak typeof(self) weakSelf = self;
        // setup pull-to-refresh
        [self.tableView addPullToRefreshWithActionHandler:^{
            [weakSelf requestRefreshData];
        }];
    }
    
}

//下拉刷新
- (void)requestRefreshData
{
    if ([self shouldRefreshData]) {
        [self refreshData];
    }
}

- (BOOL)shouldRefreshData
{
    //加载中时不应再次加载数据
    if (self.loading) {
        return NO;
    }
    return YES;
}

//下拉刷新数据, 需要重载具体实现,并维护loading状态
- (void)refreshData
{
    
}

//待加载的数据是否是首次加载数据，即加载第一页数据
- (BOOL)isFirstPageLoading
{
    if (self.pageCurrent == 1) {
        return YES;
    }
    
    return NO;
}

//待加载的数据是否以超过总页数，即数据已全部加载完毕
- (BOOL)isLastPageLoaded
{
    //pageCount为零，认为数据还没开始加载，因此此时数据并未全部加载完毕
    if (self.pageCount == 0) {
        return NO;
    }
    
    //当前待加载的数据页面已超过总页数，说明数据已全部加载完毕
    if (self.pageCurrent > self.pageCount) {
        return YES;
    }
    
    return NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //加载第一页数据的时候不显示加载中的 cell
    //数据全部加载完毕的时候不显示加载中的 cell
    //上拉加载的提示是单独的一个section
    if (!self.isFirstPageLoading && !self.isLastPageLoaded) {
        return self.numberOfSections + 1;
    }
    else {
        return self.numberOfSections;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == self.numberOfSections && !self.endReached) {
        return 1;
    }
    
    // this condition should not happen.
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == self.numberOfSections && !self.endReached) {
        return 44;
    }
    
    // this condition should not happen.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == self.numberOfSections)  {
        
        static NSString *CellIdentifier = @"LoadingCell";
		
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            UIActivityIndicatorView *newSpin = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [newSpin startAnimating];
            [newSpin setFrame:CGRectMake( 110, 12, 20, 20) ];
            [cell.contentView addSubview:newSpin];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(130, 12, 60, 20)];
            label.text = @"加载中";
            label.textColor = [UIColor lightGrayColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:label];
		}
        UIActivityIndicatorView *indicator = [cell.contentView subviews][0];
        [indicator startAnimating];
        
        [self requestHttpData];
        
        return cell;
    }
    
    // this condition should not happen.
    return nil;
}

- (UIViewController *)viewControllerFromStoryboard:(NSString *)stroyboardName identifier:(NSString *)identifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:stroyboardName bundle:nil];
    UIViewController * viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    return viewController;
}


- (void)requestHttpData
{
    if ([self shouldLoadingData]) {
        [self loadData];
    }
}

- (BOOL)shouldLoadingData
{
    //加载中时不应再次加载数据
    if (self.loading) {
        return NO;
    }
    
    //当前数据已全部加载完毕，不应再次加载数据
    if (self.isLastPageLoaded) {
        self.endReached = YES;
        self.loading = NO;
        
        return NO;
    }
    
    return YES;
}

//上拉加载数据，需要覆写此方法，请求数据，并维护loading状态
- (void)loadData
{
    
}

- (BOOL)endReached
{
    if (_pageCount == 0) {
        _endReached = YES;
    }
    
    return _endReached;
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

- (UIView*)errorView
{
    return nil;
}

- (UIView*)loadingView
{
    return nil;
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
    [self hubShowInView].userInteractionEnabled = NO;
}

- (void)hideLoadingView
{
    [self.hud hide:YES];
    [self hubShowInView].userInteractionEnabled = YES;
    self.hud = nil;
}

- (void)showErrorView
{
    [self showErrorViewWithText:TIP_SERVER_ERROR delay:TIP_DELAY_IN_SECOND];
}

- (void)showErrorViewWithText:(NSString *)text delay:(NSInteger)delay
{
    [HudUtils hudWithLabel:text customView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mb_error"]] inView:[self hubShowInView] delay:delay];
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

#pragma mark- UIScrollViewDelegate Method
//需要重载完成具体控制，比如tableview滑动消失键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}





@end
