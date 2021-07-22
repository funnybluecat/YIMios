//
//  YIMMessageCellBase.h
//  YIMios_Example
//
//  Created by yan on 2021/7/16.
//  Copyright © 2021 yan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YIMMessageResponseCustome.h"
NS_ASSUME_NONNULL_BEGIN

@interface YIMMessageCellBase : UITableViewCell
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * nickNameLabel;
@property (nonatomic, strong) UIImageView * avatar;
@property (nonatomic, strong) UIImageView * chatImageView;


@property (nonatomic, strong) UIImage * chatBgImage;



@property (nonatomic, strong) YIMMessageBase * message;
- (UIImage*)resizableImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
