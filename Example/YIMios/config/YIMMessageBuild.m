//
//  YIMMessageBuild.m
//  YIMios_Example
//
//  Created by yan on 2021/7/14.
//  Copyright © 2021 yan. All rights reserved.
//

#import "YIMMessageBuild.h"
#import "YImMessageText.h"
#import "YIMMessageRequestVerity.h"
#import <MJExtension/MJExtension.h>
#import "NSData+YImBytes.h"

@interface YIMMessageBuild()
@end
@implementation YIMMessageBuild

+ (YIMMessageBuild *)getInstance{
    static YIMMessageBuild *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[YIMMessageBuild alloc] init];
    });
    return _instance;
}

-(NSData *)getTextMessageWithContent:(NSString *)text fromUid:(NSString *) uid{
    
    
    YImMessageText * message = [[YImMessageText alloc]init];
    
    message.content=@"dsdsd";
    
    return [self getMessageDataWitMessageBody:message];
    
}

-(YIMMessageBase*)getVerityMessageWithtoken:(NSString *)token{
    
    
    
    YIMMessageRequestVerity * message =  [YIMMessageRequestVerity new];
   
    message.authToken = token;
    
    
    return message;
}









/**
     获取发布数据
 */

-(NSMutableData *) getMessageDataWitMessageBody:(id ) message{
    
    
       NSMutableData * messageData = [NSMutableData new];
    
       NSData * contentData =   [[message mj_JSONString] dataUsingEncoding:NSUTF8StringEncoding];
    
       int len =(int)contentData.length;
       NSData *lengthData =   [NSData intToData:len];
       
       [messageData appendData:lengthData];
       //数据
       
       [messageData appendData:contentData];
       
       return messageData;
    
}


@end
