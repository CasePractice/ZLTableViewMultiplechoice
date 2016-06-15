//
//  ZLTableViewCell.m
//  ZLTableViewMultiplechoice
//
//  Created by mac on 16/6/12.
//  Copyright © 2016年 zhiYou. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "ZLTableViewCell.h"
#import <Masonry.h>

@interface ZLTableViewCell ()
@property(weak,nonatomic)UIImageView *iconImageView;
@property(weak,nonatomic)UILabel *contentLabel;
@property(weak,nonatomic)UILabel *priceLabel;
@property(weak,nonatomic)UILabel *buyCountLabel;
@end
@implementation ZLTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *iconImageView=[[UIImageView alloc]init];
        [self.contentView addSubview:iconImageView];
        self.iconImageView=iconImageView;
        UILabel *contentLabel=[[UILabel alloc]init];
        [self.contentView addSubview:contentLabel];
        self.contentLabel=contentLabel;
        UILabel *priceLabel=[[UILabel alloc]init];
        [self.contentView addSubview:priceLabel];
        self.priceLabel=priceLabel;
        UILabel *buyCountLabel=[[UILabel alloc]init];
        [self.contentView addSubview:buyCountLabel];
        buyCountLabel.textColor=[UIColor lightGrayColor];
        buyCountLabel.textAlignment=NSTextAlignmentRight;
        self.buyCountLabel=buyCountLabel;
        
        CGFloat offsetNumber=10.f;
        __weak typeof(self)weakSelf=self;
        [iconImageView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(offsetNumber);
            make.left.equalTo(weakSelf.contentView).offset(offsetNumber);
            make.bottom.equalTo(weakSelf.contentView).offset(-offsetNumber);
            make.width.equalTo(weakSelf.frame.size.width/3);
        }];
        [contentLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconImageView);
            make.left.equalTo(iconImageView.right).offset(offsetNumber);
            make.right.equalTo(weakSelf.contentView).offset(-offsetNumber);
            make.height.equalTo(offsetNumber*4);
        }];
        [priceLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentLabel.bottom);
            make.left.equalTo(iconImageView.right).offset(offsetNumber);
            make.bottom.equalTo(weakSelf.contentView).offset(-offsetNumber);
            make.width.equalTo(weakSelf.frame.size.width/3);
        }];
        [buyCountLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentLabel.bottom);
            make.left.equalTo(priceLabel.right).offset(offsetNumber);
            make.bottom.equalTo(weakSelf.contentView).offset(-offsetNumber);
            make.right.equalTo(weakSelf.contentView).offset(-offsetNumber);
        }];
    }
    return self;
}
//重写本类model属性，在model有值的那一刻给cell的各个属性进行赋值
-(void)setModel:(ZLShopModel *)model{
    self.iconImageView.image=[UIImage imageNamed:model.icon];
    self.contentLabel.text=model.title;
    self.priceLabel.text=[NSString stringWithFormat:@"￥ %@",model.price];
    self.buyCountLabel.text=[NSString stringWithFormat:@"%@人已购买",model.buyCount];
}
//封闭cell的创建过程，自定义cell，cell的事务应该放在cell里处理
+(instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *identifier=@"cell";
    ZLTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[ZLTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}
@end
