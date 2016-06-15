//
//  ZLTableViewCell.h
//  ZLTableViewMultiplechoice
//
//  Created by mac on 16/6/12.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLShopModel.h"
@interface ZLTableViewCell : UITableViewCell
@property(strong,nonatomic)ZLShopModel *model;
//根据tableView，创建cell
+(instancetype)cellForTableView:(UITableView *)tableView;
@end
