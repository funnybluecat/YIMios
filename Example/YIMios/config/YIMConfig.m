//
//  YIMConfig.m
//  appdev
//
//  Created by yan on 2021/7/13.
//

#import "YIMConfig.h"
#import <MJExtension/MJExtension.h>

#import "GCDAsyncSocket.h"



#import "NSData+YImBytes.h"




#import "YIMMessageBuild.h"
#import "YImMessageText.h"
#import "YIMMessageRequestVerity.h"
static int const Retry_time = 10; // 重连间隔时间
static int const Retry_count = 10; // 重试次数
@interface YIMConfig()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) NSString * appkey;
@property (nonatomic, strong) NSString * secret;
@property (nonatomic, strong) NSString * host;
@property (nonatomic, assign) NSInteger  port;
@property (nonatomic, strong) GCDAsyncSocket * clientSocket;
@property (nonatomic, strong) NSData * messageHeadData;
@property (nonatomic, strong) NSMutableData * reciveMessageData;





@end


@implementation YIMConfig


+ (YIMConfig *)getInstance{
    static YIMConfig *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[YIMConfig alloc] init];
    });
    return _instance;
}
- (void)initWithAppKey:(NSString *)appId secret:(NSString *)secret host:(NSString *)host prot:(NSInteger )prot{
    self.messageHeadData = [self getMessageHead];
    self.reciveMessageData = [NSMutableData data];
    self.clientSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
  
    
    self.appkey = appId;
    self.secret = secret;
    self.host = host;
    self.port = prot;
}
-(void)loginIm:(NSString *)uid{

 //localhost:8080/im-server/auth/getToken?appKey=1111&appSecret=33333&uid=token678&nickName=jaha&avatar=3423423
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"appKey"] = self.appkey;
    params[@"appSecret"] = self.secret;
    params[@"uid"] =uid;
    params[@"nickName"] =uid;
    params[@"avatar"] =uid;
    
    
    [HttpClientManager getAsyn:@"http://ewhyi4.natappfree.cc/im-server/auth/getToken" params:params success:^(id json) {
       
        
        
        
        if ([json[@"code"] intValue] ==200) {
        
        //登录成功后 执行连接
        UserDefaultSetObjectForKey(json[@"data"],YIM_AUTHORIZATION_KEY);
        [self connectSocket];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
  
    
}
-(void)connectSocket{
    NSError * error = nil;
    [self.clientSocket connectToHost:self.host onPort:self.port withTimeout:10 error:&error];
}
#pragma mark socket delegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    [self sendVerityMessage];
   
}

- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    NSLog(@"连接成功");
    self.clientSocket = newSocket;
}
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"====>断开连接");
    [self performSelector:@selector(loginIm:) withObject:@"dsds" afterDelay:5.0];
  
  //  [self loginIm:@"dsds"];
}
-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"====>写入成功,是否连接失败:====>%d",self.clientSocket.isDisconnected);
    
    
    [self.clientSocket readDataToLength:24 withTimeout:-1 tag:1];
    
  //  [self.clientSocket readDataWithTimeout:-1 tag:100];
    
}
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    
    // 魔术
    //版本
    //xuliehua
    //chatTYpe
    // messageType
    //lenth
    //messageBody
    
    
   
    
    
 
    
    NSData * bodyLengthData =   [data subdataWithRange:NSMakeRange(20, 4)];
    int length =  [NSData intFromData:bodyLengthData];
    
    if (tag ==1) {
        [self.reciveMessageData appendData:data];
        
        
        [self.clientSocket readDataToLength:length withTimeout:-1 tag:2];
        
    }else{
        [self.reciveMessageData appendData:data];
        
        [self dealReviceMessageData:[NSData dataWithData:self.reciveMessageData]];
         
         
      
        
        [self.clientSocket readDataToLength:24 withTimeout:-1 tag:1];
        
    }
    
    
    
    
    
  
  
    [self.clientSocket readDataWithTimeout:-1 tag:100];
    
}

/**
   处理接受消息
 */

-(void)dealReviceMessageData:(NSData *)reciveMessageData{
    
    // 处理消息
    //获取消息类型
    
    self.reciveMessageData = [NSMutableData data];
    
    NSData * chatTypeData =   [reciveMessageData subdataWithRange:NSMakeRange(12, 4)];
    
    NSData * bodyLengthData =   [reciveMessageData subdataWithRange:NSMakeRange(20, 4)];
    int chatType =  [NSData intFromData:chatTypeData];
    
    int length =  [NSData intFromData:bodyLengthData];
    NSData * messageBody =   [reciveMessageData subdataWithRange:NSMakeRange(24, length)];
    
    NSString * messageStrJson = [[NSString alloc]initWithData:messageBody encoding:NSUTF8StringEncoding];
    if (chatType== YIMCHATVERITY) {
        // 检验登录消
        YIMMessageResponseBase *  message =     [YIMMessageResponseBase mj_objectWithKeyValues:messageStrJson];
        
        if (message.code!=200) {
            if (self.delegate) {
                [self.clientSocket disconnect];
                [self.delegate LogOutByService];
            }
        }
        
    }else{
        // 普通回调消息
        YIMMessageResponseCustome *  message =     [YIMMessageResponseCustome mj_objectWithKeyValues:messageStrJson];
        
    
        
        if (self.delegate) {
            [self.delegate reciveNewMessage:message];
        }
    }
}

-(NSMutableData *) getMessageHead{
      NSData *magicData = [NSData intToData:9559];
      NSData *versiondata = [NSData intToData:1];
      NSData *serializabledata = [NSData intToData:2];
    NSMutableData *data = [NSMutableData data];
    [data appendData:magicData];//魔术
    [data appendData:versiondata];//消息版本（，SDK 版本）
    [data appendData:serializabledata];//序列化方式（json,java序列化）
    return  data;
}
-(void)sendTextMessage:(NSInteger)conversionID content:(NSString *)text{
    
    NSMutableData * extData = [NSMutableData new];
    
    NSData *mesageTypeData = [NSData intToData:1];
    NSData *chatType = [NSData intToData:1];
    
    [extData appendData:chatType];
    [extData appendData:mesageTypeData];
    
    YIMMessageRequestBase * message= [YIMMessageRequestBase new];
    message.chatType = YIMCHATSIGLE;
    message.messageType = YIMMESSAGETYPECOMMON;
    message.messageContentType = YIMMESSAGECONTENTTEXT;
    message.fromUid= @"token";
    message.toUid = @"token2";
    message.content = text;
    [self getMessageDataWitExtData:extData hMessageBody:message];
    
}
/**
  发送校验消息
 */
-(void)sendVerityMessage{
    NSMutableData * verityData = [NSMutableData new];
    [verityData appendData:[NSData intToData:YIMCHATVERITY]];
    [verityData appendData:[NSData intToData:YIMMESSAGETYPECOMMON]];
    [self getMessageDataWitExtData:verityData hMessageBody:[[YIMMessageBuild getInstance] getVerityMessageWithtoken:UserDefaultObjectForKey(YIM_AUTHORIZATION_KEY)]];
}

/**
     获取发布数据
 */

-(void) getMessageDataWitExtData:(NSData *) extData   hMessageBody:(id ) message{
       NSMutableData * messageData = [NSMutableData dataWithData:self.messageHeadData];
       [messageData appendData:extData];
       NSData * contentData =   [[message mj_JSONString] dataUsingEncoding:NSUTF8StringEncoding];
       int len =(int)contentData.length;
       NSData *lengthData =   [NSData intToData:len];
       [messageData appendData:lengthData];
       //数据
       [messageData appendData:contentData];
    [self.clientSocket writeData:messageData withTimeout:10 tag:GCDRECIVEMESSAGEHEAD];
}
-(void)logOut{
    
    //退出登录
    
    [self.clientSocket disconnect];
    
    
}

@end

