//
//  ZLShopModel.h
//  ZLTableViewMultiplechoice
//
//  Created by mac on 16/6/12.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLShopModel : NSObject
/** 已购买人数*/
@property(copy,nonatomic)NSString *buyCount;
/** 饭店配图*/
@property(copy,nonatomic)NSString *icon;
/** 价格*/
@property(copy,nonatomic)NSString *price;
/** 饭店名*/
@property(copy,nonatomic)NSString *title;
//字典转模型
+(instancetype)shopModelWithDictionary:(NSDictionary *)dict;
@end
