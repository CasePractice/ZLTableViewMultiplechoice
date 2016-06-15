//
//  ZLShopModel.m
//  ZLTableViewMultiplechoice
//
//  Created by mac on 16/6/12.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "ZLShopModel.h"
@implementation ZLShopModel
+(instancetype)shopModelWithDictionary:(NSDictionary *)dict{
    ZLShopModel *shop=[[self alloc]init];
    [shop setValuesForKeysWithDictionary:dict];
    return shop;
}
@end
