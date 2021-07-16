//
//  YIMMessageBuild.h
//  YIMios_Example
//
//  Created by yan on 2021/7/14.
//  Copyright © 2021 yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YIMMessageBase.h"
NS_ASSUME_NONNULL_BEGIN

@interface YIMMessageBuild : NSObject


+ (YIMMessageBuild *)getInstance;


-(NSData *)getTextMessageWithContent:(NSString *)text fromUid:(NSString *) uid;

-(NSData *)getVerityMessageWithtoken:(NSString *)token;




@end

NS_ASSUME_NONNULL_END
