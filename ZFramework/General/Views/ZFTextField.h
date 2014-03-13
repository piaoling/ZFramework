//
//  ZFTextField.h
//  ZFramework
//
//  Created by zhaofeng on 14-1-19.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFTextField : UITextField

//系统的控件的起始输入位置过于考前，设置其实输入位置的偏移量，（建议5个像素，这样更美观）
@property (assign, nonatomic) CGFloat editOffset;

@end
