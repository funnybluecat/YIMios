//
//  YIMMessageBase.h
//  YIMios_Example
//
//  Created by yan on 2021/7/14.
//  Copyright © 2021 yan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, MessageContentType) {
    ///文字
    YIMMESSAGECONTENTTEXT = 1,
    /// 图片
    YIMMESSAGECONTENTIMAGE=2,
 
};
typedef NS_ENUM(NSUInteger, ChatType) {
    /// 单聊
    YIMCHATSIGLE = 1,
    /// 群组
    YIMCHATGROUP =2,
    //检验
    YIMCHATVERITY = 3,
    
    
};
typedef NS_ENUM(NSUInteger, MessageType) {
    /// 普通 发送消息 request
    YIMMESSAGETYPECOMMON = 1,
    
    /// 接受普通消息
    YIMMESSAGETYPECOMMON_RECIVE = 2,

    
    //撤回
    YIMMESSAGEIMAGETYPE_RETRACT=3,
    /// 已读
    YIMMESSAGEIMAGETYPE_READ =4,
   
   
    
    
};


typedef NS_ENUM(NSUInteger, GCDRECIVEMESSAGE) {
    /// 单聊
    GCDRECIVEMESSAGEHEAD = 1,
    /// 群组
    GCDRECIVEMESSAGEBODY =2,
  
    
};

@interface YIMMessageBase : NSObject

@end

NS_ASSUME_NONNULL_END
