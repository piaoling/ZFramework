//
//  UIAlertView+Blocks.h
//  TuNiuApp
//
//  Created by Yu Liang on 13-9-9.
//  Copyright (c) 2013年 Yu Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DismissBlock)(int buttonIndex);
typedef void (^CancelBlock)();

@interface UIAlertView (Blocks) <UIAlertViewDelegate>

+ (UIAlertView *) showAlertViewWithTitle:(NSString *)title
                                 message:(NSString *)message
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                        otherButtonTitle:(NSString *)otherButton;

+ (UIAlertView *) showAlertViewWithTitle:(NSString *)title
                                 message:(NSString *)message
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                        otherButtonTitle:(NSString *)otherButton
                                onCancel:(CancelBlock)cancelled
                               onDismiss:(DismissBlock)dismissed;

+ (UIAlertView *) showAlertViewWithTitle:(NSString *)title
                                message:(NSString *)message
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                      otherButtonTitles:(NSArray *)otherButtons;

+ (UIAlertView *) showAlertViewWithTitle:(NSString *)title
                                message:(NSString *)message
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                      otherButtonTitles:(NSArray *)otherButtons
                               onCancel:(CancelBlock)cancelled
                              onDismiss:(DismissBlock)dismissed;

@end
