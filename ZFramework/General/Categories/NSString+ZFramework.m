//
//  NSString+TNExtends.m
//  TuNiuApp
//
//  Created by XiongCaixing on 13-10-23.
//  Copyright (c) 2013年 XiongCaixing. All rights reserved.
//

#import "NSString+ZFramework.h"
#import <CommonCrypto/CommonDigest.h>

NSString *MPHexStringFromBytes(void *bytes, NSUInteger len)
{
	NSMutableString *output = [NSMutableString string];
	
	unsigned char *input = (unsigned char *)bytes;
	
	NSUInteger i;
	for (i = 0; i < len; i++)
		[output appendFormat:@"%02x", input[i]];
	return output;
}

@implementation NSString(ZFramework)

- (BOOL)zf_isEmpty
{
	return [self zf_isEmptyIgnoringWhitespace:YES];
}

- (BOOL)zf_isEmptyIgnoringWhitespace:(BOOL)ignoreWhitespace
{
	NSString *toCheck = (ignoreWhitespace) ? [self zf_stringByTrimmingWhitespace] : self;
	return [toCheck isEqualToString:@""];
}

- (NSString *)zf_stringByTrimmingWhitespace
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)zf_stringByTrimmingEscapeCharacter
{
    if ([self rangeOfString:@"\\n"].length > 0) {
        return [[self componentsSeparatedByString:@"\\n"] componentsJoinedByString:@"\n"];
    }
    else {
        return self;
    }
}

- (NSString *)zf_MD5Hash
{
	const char *input = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(input, strlen(input), result);
	return MPHexStringFromBytes(result, CC_MD5_DIGEST_LENGTH);
}

- (NSString *)zf_MD5Hash32bit
{
    const char *input = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(input, strlen(input), result);
	return MPHexStringFromBytes(result, CC_MD5_DIGEST_LENGTH);
}

- (NSString *)zf_SHA1Hash
{
	const char *input = [self UTF8String];
	unsigned char result[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1(input, strlen(input), result);
	return MPHexStringFromBytes(result, CC_SHA1_DIGEST_LENGTH);
}

#pragma mark countWord
- (int)zf_countWord
{
    
    int i, n = [self length], l = 0, a = 0, b = 0;
    
    unichar c;
    
    for(i=0;i<n;i++){
        
        c=[self characterAtIndex:i];
        
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    
    if(a==0 && l==0) return 0;
    
    return l+(int)ceilf((float)(a+b)/2.0);
    
}

#pragma mark -
//计算NSString字节长度,汉字占2个，英文占1个
-  (int)zf_convertToInt:(NSString*)strtemp {
    
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
    
}

@end

@implementation NSMutableString(TNExtends)

- (void)zf_trimCharactersInSet:(NSCharacterSet *)aCharacterSet
{
	// trim front
	NSRange frontRange = NSMakeRange(0, 1);
	while ([aCharacterSet characterIsMember:[self characterAtIndex:0]])
		[self deleteCharactersInRange:frontRange];
	
	// trim back
	while ([aCharacterSet characterIsMember:[self characterAtIndex:([self length] - 1)]])
		[self deleteCharactersInRange:NSMakeRange(([self length] - 1), 1)];
}

- (void)zf_trimWhitespace
{
	[self trimCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end

