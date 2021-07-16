//
//  YIMConfig.h
//  appdev
//
//  Created by yan on 2021/7/13.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#import "YIMMessageBase.h"
#import "YIMMessageResponseCustome.h"
NS_ASSUME_NONNULL_BEGIN


@protocol YIMConfigDelegate <NSObject>

//登录成功 回调
-(void)LoginCallBack:(NSInteger )code message:(NSString *) status;
//账号在其他地方被登录
-(void)LogOutByService;

-(void)reciveNewMessage:(YIMMessageResponseCustome *) message;



@end



@interface YIMConfig : NSObject
+ (YIMConfig *)getInstance;

@property (nonatomic, weak) id<YIMConfigDelegate>  delegate;


-(void)initWithAppKey:(NSString *) appId secret:(NSString *)secret host:(NSString *) host prot:(NSInteger ) prot;



/**
    平台用户唯一标识
 */

-(void)loginIm:(NSString *)uid;



-(void)logOut;




/**
    发送单聊消息
 */
-(void)sendTextMessage:(NSInteger ) conversionID content:(NSString *) text;

-(void)sendMessageWithChatType:(ChatType) chatType messageContentType:(MessageContentType ) messageContentType      conversionID:(NSInteger ) conversionID content:(NSString *) text;



@end

NS_ASSUME_NONNULL_END
