//
//  YLViewController.m
//  YIMios
//
//  Created by yan on 07/13/2021.
//  Copyright (c) 2021 yan. All rights reserved.
//

#import "YLViewController.h"
#import  <Masonry/Masonry.h>

#import "YIMMessageCellBase.h"
#import "YIMConfig.h"

#import "YIMMessageCellRecive.h"
#import "YIMMessageCellSend.h"
#import "DKSKeyboardView.h"
@interface YLViewController ()<YIMConfigDelegate,UIGestureRecognizerDelegate,DKSKeyboardDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * mainTabView;
@property (nonatomic, strong) UITextField * textFiled;
@property (nonatomic, strong) UIButton * sendButton;
@property (nonatomic, strong) NSString * fromAvatar;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) DKSKeyboardView * keyView;

@end

@implementation YLViewController


-(UITableView *)mainTabView{
    
    if (_mainTabView == nil) {
        _mainTabView = [[UITableView  alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainTabView.delegate = self;
        _mainTabView.dataSource = self;
        [_mainTabView registerClass:[YIMMessageCellBase class]  forCellReuseIdentifier:@"YIMMessageCellBase"];
        [_mainTabView registerClass:[YIMMessageCellRecive class]  forCellReuseIdentifier:@"YIMMessageCellRecive"];
        [_mainTabView registerClass:[YIMMessageCellSend class]  forCellReuseIdentifier:@"YIMMessageCellSend"];
       _mainTabView.rowHeight=UITableViewAutomaticDimension;
        _mainTabView.estimatedRowHeight = 100;

        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
        tapGesture.delegate = self;
        [_mainTabView addGestureRecognizer:tapGesture];
    }
    
    
    return _mainTabView;
    
}


-(NSMutableArray *)dataArr{
    
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    

    [self.view addSubview:self.mainTabView];
    
    [self.mainTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-51);
    }];
    
    
    
   
    
   [ [YIMConfig getInstance] loginIm:@"token"];
    [[YIMConfig getInstance] setDelegate:self];
    
    
    self.keyView = [[DKSKeyboardView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 51, SCREEN_WIDTH, 51)];
       //设置代理方法
      self.keyView.delegate = self;
       [self.view addSubview:_keyView];
    
    

}


#pragma mark ====== DKSKeyboardDelegate ======
//发送的文案
- (void)textViewContentText:(NSString *)textStr {
    [[YIMConfig getInstance] sendTextMessage:1111 content:textStr];
//    [self.tableView reloadData];
    [self scrollToBottom];
}
- (void)scrollToBottom {
    if (self.dataArr.count >= 1) {
        [self.mainTabView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:MAX(0, self.dataArr.count - 1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}
//keyboard的frame改变
- (void)keyboardChangeFrameWithMinY:(CGFloat)minY {
    [self scrollToBottom];
    // 获取对应cell的rect值（其值针对于UITableView而言）
    
    if (self.dataArr.count >0) {
        NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:self.dataArr.count - 1 inSection:0];
        CGRect rect = [self.mainTabView rectForRowAtIndexPath:lastIndex];
        CGFloat lastMaxY = rect.origin.y + rect.size.height;
        //如果最后一个cell的最大Y值大于tableView的高度
        if (lastMaxY <= self.mainTabView.height) {
            if (lastMaxY >= minY) {
                self.mainTabView.y = minY - lastMaxY;
            } else {
                self.mainTabView.y = 0;
            }
        } else {
            self.mainTabView.y += minY - self.mainTabView.maxY;
        }
    }
    
   
}



- (void)sendNewMessage:(YIMMessageRequestBase *)message{
    
    [self.dataArr addObject:message];
    
    
    [self.mainTabView reloadData];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)reciveNewMessage:(YIMMessageResponseCustome *)message{
    
    [self.dataArr addObject:message];
    
    
    [self.mainTabView reloadData];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.dataArr.count;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
    
}



// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
   // YIMMessageCellBase * cell = [tableView dequeueReusableCellWithIdentifier:@"YIMMessageCellBase"];
    
    
    YIMMessageBase * message = [self.dataArr objectAtIndex:indexPath.row];
   
    
    if ([message.fromUid isEqual:@"token"]) {
        
        
            
        
        YIMMessageCellSend  * cell= [tableView dequeueReusableCellWithIdentifier:@"YIMMessageCellSend"];
        
        
        cell.message = self.dataArr[indexPath.row];
           
        return cell;
        
    }else{
        
        
        YIMMessageCellRecive  * cell= [tableView dequeueReusableCellWithIdentifier:@"YIMMessageCellRecive"];
        
        
        cell.message = self.dataArr[indexPath.row];
        
        return cell;
    }
    
  
    
    
    
  
    
    
}


#pragma mark ====== 点击UITableView ======
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //收回键盘
    [[NSNotificationCenter defaultCenter] postNotificationName:@"keyboardHide" object:nil];
    //若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}



@end
