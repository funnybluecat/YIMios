//
//  YIMMessageCellRecive.m
//  YIMios_Example
//
//  Created by yan on 2021/7/19.
//  Copyright © 2021 yan. All rights reserved.
//

#import "YIMMessageCellRecive.h"
#import "YIMMessageResponseCustome.h"
@implementation YIMMessageCellRecive



-(void)updateLayout{
    
    
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatar.mas_right).offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
      
        make.width.mas_lessThanOrEqualTo(200);
        
        make.height.mas_greaterThanOrEqualTo(10);
      
       
        
    }];
    
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.nickNameLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.avatar.mas_right).offset(45);
        make.width.mas_lessThanOrEqualTo(200);
       // make.height.mas_greaterThanOrEqualTo(40);
        make.bottom.mas_equalTo(self.contentView).offset(-20);

    }];
    
    
    
    
    
//

    [self.chatImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.contentLabel.mas_top).offset(-5);
        make.left.mas_equalTo(self.avatar.mas_right).offset(10);

        make.right.mas_equalTo(self.contentLabel.mas_right).offset(25);
        make.bottom.mas_equalTo(self.contentLabel.mas_bottom).offset(5);


    }];

    
   self.chatImageView.image = [self resizableImage:[UIImage imageNamed:@"chat_image_left"]];
    
    
}

- (void)setMessage:(YIMMessageBase *)message{
    
    
    
    YIMMessageResponseCustome * result = (YIMMessageResponseCustome *)message;
    
    
    
    self.contentLabel.text = result.content;
    self.nickNameLabel.text = result.fromNickName;
    
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:result.fromAvatar]];
    
}

@end
