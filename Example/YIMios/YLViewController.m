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
@interface YLViewController ()<YIMConfigDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * mainTabView;
@property (nonatomic, strong) UITextField * textFiled;
@property (nonatomic, strong) UIButton * sendButton;
@property (nonatomic, strong) NSString * fromAvatar;
@property (nonatomic, strong) NSMutableArray * dataArr;
@end

@implementation YLViewController


-(UITableView *)mainTabView{
    
    if (_mainTabView == nil) {
        _mainTabView = [[UITableView  alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainTabView.delegate = self;
        _mainTabView.dataSource = self;
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
        
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-100);
    }];
    
    
    
    [self.mainTabView registerClass:[YIMMessageCellBase class]  forCellReuseIdentifier:@"YIMMessageCellBase"];
    
    
    [[YIMConfig getInstance] loginIm:@""];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    
    [self.view addGestureRecognizer:tap];
    
    [[YIMConfig getInstance] setDelegate:self];
    
    
    self.textFiled = [[UITextField alloc]init];
    
    [self.view addSubview:self.textFiled];
    
    self.textFiled.backgroundColor = [UIColor redColor];
    
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mainTabView.mas_bottom);
      
        make.right.mas_equalTo(self.view.mas_right).offset(-100);
    }];
    
    
    
    self.sendButton = [[UIButton alloc]init];
    
    [self.sendButton addTarget:self action:@selector(sendmessage) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.sendButton];
    
    self.sendButton.backgroundColor = [UIColor blueColor];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mainTabView.mas_bottom);
        make.left.mas_equalTo(self.textFiled.mas_right);
    }];
    
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}


-(void)click{
    
   // [[YIMConfig getInstance] sendTextMessage:1111 content:@"hahahah"];
    
    
}


-(void)sendmessage{
    
    [[YIMConfig getInstance] sendTextMessage:1111 content:self.textFiled.text];
    
    
    YIMMessageResponseCustome * message = [YIMMessageResponseCustome new];
    
    message.content = self.textFiled.text;
    
    
    
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
    
    return 44;
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return 44;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    YIMMessageCellBase * cell = [tableView dequeueReusableCellWithIdentifier:@"YIMMessageCellBase"];
    
    
    
    
    
    cell.message = self.dataArr[indexPath.row];
    
    
    
    return cell;
    
    
}

@end
