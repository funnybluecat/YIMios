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
@property (nonatomic, strong) UILabel * sendLabel;

@property (nonatomic, strong) YIMMessageResponseCustome * message;

@end

NS_ASSUME_NONNULL_END
