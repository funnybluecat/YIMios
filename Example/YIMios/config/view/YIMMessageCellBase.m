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
        
        [_contentLabel setNumberOfLines:0];
        [_contentLabel sizeToFit];

    }
    return _contentLabel;
}
-(UIImageView *)avatar{
    if (_avatar == nil) {
        _avatar = [[UIImageView  alloc]init];
       
        _avatar.layer.cornerRadius = 5;
        [_avatar clipsToBounds];
    }
    return _avatar;
}
- (UILabel *)nickNameLabel{
    if (_nickNameLabel == nil) {
        _nickNameLabel = [[UILabel    alloc]init];
        [_nickNameLabel setNumberOfLines:1];
        
        [_nickNameLabel sizeToFit];
       
    }
    return _nickNameLabel;
}
- (UIImageView *)chatImageView{
    if (_chatImageView == nil) {
        _chatImageView = [[UIImageView alloc]init];
    }
    return _chatImageView;
}
-(void)setUpUI{
    [self.contentView addSubview:self.chatImageView];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.avatar];
    [self.contentView addSubview:self.nickNameLabel];
    [self updateLayout];
   
    
}


-(void)updateLayout{
    
    
    
    
}



- (UIImage*)resizableImage:(UIImage *)image

{
    
       CGFloat top = image.size.height - 5;
       CGFloat left = image.size.width / 2 + 2;
      CGFloat right = image.size.width / 2 - 2;
      CGFloat bottom = image.size.height - 4;
return [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch];
}
-(void)setMessage:(YIMMessageResponseCustome *)message{
  
   
}
@end
