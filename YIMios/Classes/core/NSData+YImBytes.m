//
//  NSData+YImBytes.m
//  YIMios
//
//  Created by yan on 2021/7/13.
//

#import "NSData+YImBytes.h"

@implementation NSData (YImBytes)
+ (NSData *)intToData:(int)i{
    Byte b1=i & 0xff;
                               Byte b2=(i>>8) & 0xff;
                               Byte b3=(i>>16) & 0xff;
                               Byte b4=(i>>24) & 0xff;
                               Byte byte[] = {b4,b3,b2,b1};
                               NSData *adddata = [NSData dataWithBytes:byte length:sizeof(byte)];
    
    return adddata;
}
@end

