//
//  ZFTextField.m
//  ZFramework
//
//  Created by zhaofeng on 14-1-19.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import "ZFTextField.h"

@implementation ZFTextField

- (id)init
{
    self = [super init];
    if (self) {
        _editOffset = 5.0f;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _editOffset = 5.0f;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _editOffset = 5.0f;
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + self.editOffset, bounds.origin.y, bounds.size.width, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + self.editOffset, bounds.origin.y, bounds.size.width, bounds.size.height);
}

@end
