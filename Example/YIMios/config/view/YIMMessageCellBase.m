//
//  YIMMessageCellBase.m
//  YIMios_Example
//
//  Created by yan on 2021/7/16.
//  Copyright © 2021 yan. All rights reserved.
//

#import "YIMMessageCellBase.h"

@implementation YIMMessageCellBase

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setUpUI];
    }
    
    return self;
}

-(UILabel *)contentLabel{
    
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc]init];
    }
    
    return _contentLabel;
}

-(void)setUpUI{
    
    [self.contentView addSubview:self.contentLabel];
    
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.contentView);
        
    }];
    
    
    

    
    
}





-(void)setMessage:(YIMMessageResponseCustome *)message{
    
    
    
    self.contentLabel.text = message.content;
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
