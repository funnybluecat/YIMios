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


+ (int) intFromData:(NSData *)data
{
    int intSize = sizeof(int); // change it to fixe length
    unsigned char * buffer = malloc(intSize * sizeof(unsigned char));
    [data getBytes:buffer length:intSize];
    int num = 0;
    for (int i = 0; i < intSize; i++) {
        num = (num << 8) + buffer[i];
    }
    free(buffer);
    return num;
}


@end

