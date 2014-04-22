//
//  NSString+TNExtends.h
//  TuNiuApp
//
//  Created by XiongCaixing on 13-10-23.
//  Copyright (c) 2013年 XiongCaixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *MPHexStringFromBytes(void *bytes, NSUInteger len);

@interface NSString(ZFramework)

- (BOOL)zf_isEmpty;
- (BOOL)zf_isEmptyIgnoringWhitespace:(BOOL)ignoreWhitespace;
- (NSString *)zf_stringByTrimmingWhitespace;
- (NSString *)zf_stringByTrimmingEscapeCharacter;

- (NSString *)zf_MD5Hash;
- (NSString *)zf_SHA1Hash;
- (NSString *)zf_MD5Hash32bit;

#pragma mark countWord
- (int)countWord;
- (int)convertToInt:(NSString*)strtemp;

@end

@interface NSMutableString(ZFramework)

- (void)trimCharactersInSet:(NSCharacterSet *)aCharacterSet;
- (void)trimWhitespace;

@end
