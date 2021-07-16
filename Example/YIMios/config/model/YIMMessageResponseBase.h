//
//  YIMMessageResponseBase.h
//  YIMios_Example
//
//  Created by yan on 2021/7/16.
//  Copyright © 2021 yan. All rights reserved.
//

#import "YIMMessageBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface YIMMessageResponseBase : YIMMessageBase
@property (nonatomic, assign) int  code;

@property (nonatomic, assign) ChatType  chatType;
@property (nonatomic, assign) MessageType  messageType;

@property (nonatomic, assign) MessageContentType  messageContentType;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, assign) long  messageId;
@property (nonatomic, assign) long  timeStamp;


@end

NS_ASSUME_NONNULL_END
