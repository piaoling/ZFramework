//
//  UIImage+ZFramework.h
//  ZFramework
//
//  Created by zhaofeng on 14-4-22.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage(ZFramework)

//缩放展示中间的部分，可能展示不全
- (UIImage *)zf_scaleTo:(CGSize)size;

//展示全部的缩放内容，与上面的那个方法互补
- (UIImage *)zf_scaleToByMinScale:(CGSize)size;

- (UIImage *)zf_convertToGrayImage;

@end
