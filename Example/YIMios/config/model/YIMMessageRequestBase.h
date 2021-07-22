//
//  YIMMessageRequestBase.h
//  YIMios_Example
//
//  Created by yan on 2021/7/14.
//  Copyright © 2021 yan. All rights reserved.
//

#import "YIMMessageBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface YIMMessageRequestBase : YIMMessageBase
@property (nonatomic, assign) ChatType  chatType;
@property (nonatomic, assign) MessageType  messageType;
@property (nonatomic, assign) MessageContentType  messageContentType;

@property (nonatomic, strong) NSString * fromAvatar;
@property (nonatomic, strong) NSString * fromNickName;


@property (nonatomic, strong) NSString * toUid;
@property (nonatomic, strong) NSString * toAvatar;
@property (nonatomic, strong) NSString * toNickName;
// dian'liao
@property (nonatomic, strong) NSString * conversionId;

@property (nonatomic, strong) NSString * content;

@property (nonatomic, strong) NSString * ext;

@property (nonatomic, assign) long  timeStamp;

@end

NS_ASSUME_NONNULL_END
