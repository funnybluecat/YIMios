//
//  YIMMessageResponseCustome.h
//  YIMios_Example
//
//  Created by yan on 2021/7/16.
//  Copyright © 2021 yan. All rights reserved.
//

#import "YIMMessageResponseBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface YIMMessageResponseCustome : YIMMessageResponseBase

@property (nonatomic, strong) NSString * fromAvatar;
@property (nonatomic, strong) NSString * fromNickName;


@property (nonatomic, strong) NSString * toUid;
@property (nonatomic, strong) NSString * toAvatar;
@property (nonatomic, strong) NSString * toNickName;
// dian'liao
@property (nonatomic, strong) NSString * conversionId;



@property (nonatomic, strong) NSString * ext;

@end

NS_ASSUME_NONNULL_END
