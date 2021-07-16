//
//  ViewController.m
//  appdev
//
//  Created by yan on 2021/7/12.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"
#import <MJExtension/MJExtension.h>
#import <Masonry/Masonry.h>
#import "NSData+bytes.h""
@interface ViewController ()<GCDAsyncSocketDelegate>
@property (nonatomic, strong) UITextField * hostField;
@property (nonatomic, strong) UITextField * portField;
@property (nonatomic, strong) UIButton * button;
@property (nonatomic, strong) UIButton * sendbutton;
@property (nonatomic, strong) GCDAsyncSocket * clientSocket;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // self.view.backgroundColor = [UIColor redColor];
    
    self.clientSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    self.hostField = [[UITextField    alloc]init];
    
    [self.view addSubview:self.hostField];
    self.hostField.backgroundColor = [UIColor blueColor];
    
    self.hostField.placeholder = @"IP";
    
    [self.hostField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.left.mas_equalTo(self.view.mas_left).offset(100);
        
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    
    self.portField = [[UITextField    alloc]init];
    
    [self.view addSubview:self.portField];
    self.portField.backgroundColor = [UIColor blueColor];
    
    self.portField.placeholder = @"IP";
    
    [self.portField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.hostField).offset(100);
        make.left.mas_equalTo(self.view.mas_left).offset(100);
        
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    
    self.button = [[UIButton alloc] init];
    self.button.backgroundColor = [UIColor   redColor];
    [self.view addSubview:self.button];
    
    [self.button addTarget:self action:@selector(connectSocket) forControlEvents:UIControlEventTouchUpInside];
    
    self.button.backgroundColor = [UIColor yellowColor];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.portField.mas_bottom).offset(50);
        make.left.mas_equalTo(self.view.mas_left).offset(100);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    
    self.sendbutton = [[UIButton alloc] init];
    
    [self.view addSubview:self.sendbutton];
    
    [self.sendbutton addTarget:self action:@selector(connect) forControlEvents:UIControlEventTouchUpInside];
    
    self.sendbutton.backgroundColor = [UIColor yellowColor];
    
    [self.sendbutton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.button.mas_bottom).offset(50);
        make.left.mas_equalTo(self.view.mas_left).offset(100);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    
    [self.clientSocket readDataWithTimeout:-1 tag:0];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)clickWithBtn{
    
    NSLog(@"dsadsadas");
    
    NSError * error = nil;
    [self.clientSocket connectToHost:self.hostField.text onPort:[self.portField.text integerValue] error:&error];
    
}
//- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
//{
//    //这里需要对Socket的工作原理进行一点解释，当Socket accept一个连接服务请求时，将生成一个新的Socket，即此处的newSocket。在此可查看newSocket.connectedHost和newSocket.connectedPort等参数，并通过新的socket向客户端发送一包数据后会关闭你一开始创建的socket(self.serverSocket),接下来你都将使用newSocket(我将此保存为self.clientSocket)
//    self.clientSocket = newSocket;
//}
//
//- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err;
//{
//}
//
//-(void)send{
//
//
//   // [self.clientSocket writeStream]
//
//
//    //注意此处使用的是上面的newSocket
//    [self.clientSocket writeData:[@"dsdsad" dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
//        //我创建了一个Socket单例，这里只讨论Socket,单例创建可看Demo
////        SocketManager * socketManager = [SocketManager sharedSocketManager];
////        [socketManager.mySocket readDataWithTimeout:-1 tag:0];
//}
//- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
//{
//    NSLog(@"接收到消息%@,要怎么处理，您看着办",data);
//}



- (void)connectSocket
{
    //判断是否登录
//    if (![XBUserInfo manage].sessionKey) {
//        return;
////    }
//    NSString *host = @"socket地址";
//    UInt32 port = 端口号;
//
    //创建GCDAsyncSocket
    NSError *error = nil;
    [self.clientSocket connectToHost:@"server.natappfree.cc" onPort:39123 error:&error];
    if (error != nil) {
        NSLog(@"%@",error);
    }
    //初始化，和服务器建立连接
//    SignedByte protocolByte = 1;//协议编号
//    SignedByte stateCodebyte = 0x01;//状态码
//    //登录data
//    NSDictionary *dict = @{@"token":@"dsadasdsadassa",@"deviceFlag":@(1)};
    //发送登录的byte数据包
   // [self sendMsgWithProtocolByte:protocolByte stateCodebyte:stateCodebyte content:dict];
}

-(void)connect{
  //协议编号

  
      NSData *magicData = [NSData intToData:9559];
  
    
    NSData *versiondata = [NSData intToData:1];
    NSData *serializabledata = [NSData intToData:2];
    /**
            消息类型
     */
    NSData *mesageTypeData = [NSData intToData:1];
    NSDictionary *dict = @{@"token":@"dsadasdsadassa",@"deviceFlag":@(1)};
    
    NSString * json = [dict mj_JSONString];
    
    NSData *loginData = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *appKey = [@"yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *appSercert = [@"zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz" dataUsingEncoding:NSUTF8StringEncoding];
        //消息长度
        int len =(int)loginData.length;
    NSData *lengthData =   [NSData intToData:len];
    NSMutableData *data = [NSMutableData data];
    [data appendData:magicData];//魔术
    [data appendData:versiondata];//消息版本（，SDK 版本）
    [data appendData:serializabledata];//序列化方式（json,java序列化）
    [data appendData:mesageTypeData];//消息类型，发送，已读，撤回
    [data appendData:appKey];
    [data appendData:appSercert];
    
    
    
    
    
    [data appendData:lengthData];//消息长度
    [data appendData:loginData];//内容
    
    [self.clientSocket  writeData:data withTimeout:-1 tag:111];
    [self.clientSocket  readDataWithTimeout:-1 tag:101];
}

#pragma mark socket delegate

-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"====>连接成功");
  //  [self threadStart];
    [self.clientSocket  readDataWithTimeout:-1 tag:101];
    
}

-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"====>断开连接");
    [self connectSocket];
    [self.clientSocket  readDataWithTimeout:-1 tag:101];
    
}

-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"====>写入成功,是否连接失败:====>%d",self.clientSocket.isDisconnected);
    [self.clientSocket  readDataWithTimeout:-1 tag:tag];
    
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    Byte *testByte = (Byte *)[data bytes];
    Byte * result = malloc(data.length - 20);
    [self bytesplit2byte:testByte orc:result begin:20 count: data.length - 20];

    NSData *datadsd = [NSData dataWithBytes:result length: data.length - 20];

    
  //  NSDate  * recF  =   [datadsd subdataWithRange:NSMakeRange(80, data.length-1)];
    
       NSString *receiverStr = [[NSString alloc] initWithData: datadsd encoding:NSUTF8StringEncoding];
       NSLog(@"收到的数据：------------------%@",receiverStr);
    
    
    
    
    [self.clientSocket  readDataWithTimeout:-1 tag:tag]; //接受到消息 处理
    
//    
//    
//    [self.clientSocket readDataToData:<#(nullable NSData *)#> withTimeout:<#(NSTimeInterval)#> tag:<#(long)#>]
//    
//    
    
    
    
}

-(void)bytesplit2byte:(Byte[])src orc:(Byte[])orc begin:(NSInteger)begin count:(NSInteger)count{
    
    for (NSInteger i = begin; i < begin+count; i++){
        orc[i-begin] = src[i];
      }
 
    }

////心跳包发送
//- (void)threadStart
//{
//    if (!_connectTimer) {
//        self.connectTimer =  [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(heartBeat) userInfo:nil repeats:YES];
//        [[NSRunLoop mainRunLoop] addTimer: self.connectTimer forMode:NSDefaultRunLoopMode];
//    }
//
//}

//- (void)heartBeat
//{
//    NSLog(@"~~~开始心跳了~~~");
//    SignedByte protocolByte = 0x01;//协议编号为心跳包
//    SignedByte stateCodebyte = 0x01;//状态码
//    [self sendMsgWithProtocolByte:protocolByte stateCodebyte:stateCodebyte content:@""];
//}
//
//


- (NSString *)hexFromInt:(NSInteger)val {
    return [NSString stringWithFormat:@"%lX", (long)val];
}
- (NSData *)dataFromHexString:(NSString *)hexString
{
    NSAssert((hexString.length > 0) && (hexString.length % 2 == 0), @"hexString.length mod 2 != 0");
    NSMutableData *data = [[NSMutableData alloc] init];
    for (NSUInteger i=0; i<hexString.length; i+=2) {
        NSRange tempRange = NSMakeRange(i, 2);
        NSString *tempStr = [hexString substringWithRange:tempRange];
        NSScanner *scanner = [NSScanner scannerWithString:tempStr];
        unsigned int tempIntValue;
        [scanner scanHexInt:&tempIntValue];
        [data appendBytes:&tempIntValue length:1];
    }
    return data;
}


@end

