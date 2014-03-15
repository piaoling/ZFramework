//
//  ZFViewDeckViewController.m
//  ZFramework
//
//  Created by zhaofeng on 14-3-15.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import "ZFViewDeckViewController.h"

@interface ZFViewDeckViewController ()

@end

@implementation ZFViewDeckViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    _centerController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    _leftController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    
    _rightController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];
    
    [self.view addSubview:_centerController.view];
    [_centerController.view setTag:1];
    [_centerController.view setFrame:self.view.bounds];
    
    [self.view addSubview:_leftController.view];
    [_leftController.view setTag:2];
    [_leftController.view setFrame:self.view.bounds];
    
    [self.view addSubview:_rightController.view];
    [_rightController.view setTag:3];
    [_rightController.view setFrame:self.view.bounds];
    
    [self.view bringSubviewToFront:_centerController.view];
    
    //add swipe gesture
    UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    [swipeGestureRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [_centerController.view addGestureRecognizer:swipeGestureRight];
    
    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    [swipeGestureLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_centerController.view addGestureRecognizer:swipeGestureLeft];
}

-(void) swipeGesture:(UISwipeGestureRecognizer *)swipeGestureRecognizer {
    
    CALayer *layer = [_centerController.view layer];
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowOpacity = 1;
    layer.shadowRadius = 20.0;
    if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [_leftController.view setHidden:NO];
        [_rightController.view setHidden:YES];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        if (_centerController.view.frame.origin.x == self.view.frame.origin.x || _centerController.view.frame.origin.x == -100) {
            [_centerController.view setFrame:CGRectMake(_centerController.view.frame.origin.x+100, _centerController.view.frame.origin.y, _centerController.view.frame.size.width, _centerController.view.frame.size.height)];
        }
        
        [UIView commitAnimations];
    }
    if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        [_rightController.view setHidden:NO];
        [_leftController.view setHidden:YES];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        if (_centerController.view.frame.origin.x == self.view.frame.origin.x || _centerController.view.frame.origin.x == 100) {
            [_centerController.view setFrame:CGRectMake(_centerController.view.frame.origin.x-100, _centerController.view.frame.origin.y, _centerController.view.frame.size.width, _centerController.view.frame.size.height)];
        }
        
        [UIView commitAnimations];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
