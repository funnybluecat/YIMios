//
//  NSData+YImBytes.h
//  YIMios
//
//  Created by yan on 2021/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (YImBytes)
+(NSData *)intToData:(int) num;

+ (int) intFromData:(NSData *)data;



@end

NS_ASSUME_NONNULL_END
