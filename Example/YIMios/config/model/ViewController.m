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
//    //???????????????Socket???????????????????????????????????????Socket accept???????????????????????????????????????????????????Socket???????????????newSocket??????????????????newSocket.connectedHost???newSocket.connectedPort???????????????????????????socket???????????????????????????????????????????????????????????????socket(self.serverSocket),????????????????????????newSocket(??????????????????self.clientSocket)
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
//    //?????????????????????????????????newSocket
//    [self.clientSocket writeData:[@"dsdsad" dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
//        //??????????????????Socket????????????????????????Socket,??????????????????Demo
////        SocketManager * socketManager = [SocketManager sharedSocketManager];
////        [socketManager.mySocket readDataWithTimeout:-1 tag:0];
//}
//- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
//{
//    NSLog(@"???????????????%@,??????????????????????????????",data);
//}



- (void)connectSocket
{
    //??????????????????
//    if (![XBUserInfo manage].sessionKey) {
//        return;
////    }
//    NSString *host = @"socket??????";
//    UInt32 port = ?????????;
//
    //??????GCDAsyncSocket
    NSError *error = nil;
    [self.clientSocket connectToHost:@"server.natappfree.cc" onPort:39123 error:&error];
    if (error != nil) {
        NSLog(@"%@",error);
    }
    //????????????????????????????????????
//    SignedByte protocolByte = 1;//????????????
//    SignedByte stateCodebyte = 0x01;//?????????
//    //??????data
//    NSDictionary *dict = @{@"token":@"dsadasdsadassa",@"deviceFlag":@(1)};
    //???????????????byte?????????
   // [self sendMsgWithProtocolByte:protocolByte stateCodebyte:stateCodebyte content:dict];
}

-(void)connect{
  //????????????

  
      NSData *magicData = [NSData intToData:9559];
  
    
    NSData *versiondata = [NSData intToData:1];
    NSData *serializabledata = [NSData intToData:2];
    /**
            ????????????
     */
    NSData *mesageTypeData = [NSData intToData:1];
    NSDictionary *dict = @{@"token":@"dsadasdsadassa",@"deviceFlag":@(1)};
    
    NSString * json = [dict mj_JSONString];
    
    NSData *loginData = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *appKey = [@"yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *appSercert = [@"zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz" dataUsingEncoding:NSUTF8StringEncoding];
        //????????????
        int len =(int)loginData.length;
    NSData *lengthData =   [NSData intToData:len];
    NSMutableData *data = [NSMutableData data];
    [data appendData:magicData];//??????
    [data appendData:versiondata];//??????????????????SDK ?????????
    [data appendData:serializabledata];//??????????????????json,java????????????
    [data appendData:mesageTypeData];//???????????????????????????????????????
    [data appendData:appKey];
    [data appendData:appSercert];
    
    
    
    
    
    [data appendData:lengthData];//????????????
    [data appendData:loginData];//??????
    
    [self.clientSocket  writeData:data withTimeout:-1 tag:111];
    [self.clientSocket  readDataWithTimeout:-1 tag:101];
}

#pragma mark socket delegate

-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"====>????????????");
  //  [self threadStart];
    [self.clientSocket  readDataWithTimeout:-1 tag:101];
    
}

-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"====>????????????");
    [self connectSocket];
    [self.clientSocket  readDataWithTimeout:-1 tag:101];
    
}

-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"====>????????????,??????????????????:====>%d",self.clientSocket.isDisconnected);
    [self.clientSocket  readDataWithTimeout:-1 tag:tag];
    
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    Byte *testByte = (Byte *)[data bytes];
    Byte * result = malloc(data.length - 20);
    [self bytesplit2byte:testByte orc:result begin:20 count: data.length - 20];

    NSData *datadsd = [NSData dataWithBytes:result length: data.length - 20];

    
  //  NSDate  * recF  =   [datadsd subdataWithRange:NSMakeRange(80, data.length-1)];
    
       NSString *receiverStr = [[NSString alloc] initWithData: datadsd encoding:NSUTF8StringEncoding];
       NSLog(@"??????????????????------------------%@",receiverStr);
    
    
    
    
    [self.clientSocket  readDataWithTimeout:-1 tag:tag]; //??????????????? ??????
    
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

////???????????????
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
//    NSLog(@"~~~???????????????~~~");
//    SignedByte protocolByte = 0x01;//????????????????????????
//    SignedByte stateCodebyte = 0x01;//?????????
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

