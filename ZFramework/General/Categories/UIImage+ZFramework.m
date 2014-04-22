//
//  UIImage+ZFramework.m
//  ZFramework
//
//  Created by zhaofeng on 14-4-22.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import "UIImage+ZFramework.h"

typedef enum {
    ALPHA = 0,
    BLUE = 1,
    GREEN = 2,
    RED = 3
} PIXELS;

@implementation UIImage(ZFramework)

- (UIImage *)zf_scaleTo:(CGSize)size
{
    CGSize sourceSize = [self size];
    CGRect destinationRectangle = CGRectMake(0, 0, size.width, size.height);
    
    // I want to keep the aspect ratio of the original image.
    float ratio = MAX(destinationRectangle.size.height / sourceSize.height,
                      destinationRectangle.size.width / sourceSize.width);
    
    // Create a virtual graphics context
    UIGraphicsBeginImageContextWithOptions(destinationRectangle.size, NO, 0.0);
    
    CGRect destinationRectanble;
    destinationRectanble.size.width = ratio * sourceSize.width;
    destinationRectanble.size.height = ratio * sourceSize.height;
    destinationRectanble.origin.x = (destinationRectangle.size.width - destinationRectanble.size.width) / 2;
    destinationRectanble.origin.y = (destinationRectangle.size.height - destinationRectanble.size.height) / 2;
    
    [self drawInRect:destinationRectanble];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    // Close the virtual graphics context
    UIGraphicsEndImageContext();
    
    // Deliver the resized image.
    return result;
}

//展示全部的缩放内容，与上面的那个方法互补
- (UIImage *)zf_scaleToByMinScale:(CGSize)size
{
    CGSize sourceSize = [self size];
    CGRect destinationRectangle = CGRectMake(0, 0, size.width, size.height);
    
    // I want to keep the aspect ratio of the original image.
    float ratio = MIN(destinationRectangle.size.height / sourceSize.height,
                      destinationRectangle.size.width / sourceSize.width);
    
    // Create a virtual graphics context
    UIGraphicsBeginImageContextWithOptions(destinationRectangle.size, NO, 0.0);
    
    CGRect destinationRectanble;
    destinationRectanble.size.width = ratio * sourceSize.width;
    destinationRectanble.size.height = ratio * sourceSize.height;
    destinationRectanble.origin.x = (destinationRectangle.size.width - destinationRectanble.size.width) / 2;
    destinationRectanble.origin.y = (destinationRectangle.size.height - destinationRectanble.size.height) / 2;
    
    [self drawInRect:destinationRectanble];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    // Close the virtual graphics context
    UIGraphicsEndImageContext();
    
    // Deliver the resized image.
    return result;
}

- (UIImage *)zf_convertToGrayImage
{
    CGSize size = [self size];
    int width = size.width;
    int height = size.height;
	
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
	
    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));
	
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
	
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [self CGImage]);
	
    for(int y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
			
            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            uint32_t gray = 0.3 * rgbaPixel[RED] + 0.59 * rgbaPixel[GREEN] + 0.11 * rgbaPixel[BLUE];
			
            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }
	
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef image = CGBitmapContextCreateImage(context);
	
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
	
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:image];
	
    // we're done with image now too
    CGImageRelease(image);
	
    return resultUIImage;
}


@end
