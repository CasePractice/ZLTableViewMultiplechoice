//
//  ViewController.m
//  ZLTableViewMultiplechoice
//
//  Created by mac on 16/6/12.
//  Copyright © 2016年 zhiYou. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "ViewController.h"
#import <Masonry.h>
#import "ZLShopModel.h"
#import "ZLTableViewCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(weak,nonatomic)UITableView *tableView;
/** plist的model数据可变数组*/
@property(strong,nonatomic)NSMutableArray *modelArray_M;
@end

@implementation ViewController

/** 懒加载获取plist文件的数据，并把数据转换成模型存入数组*/ //TODO:modelArray的懒加载
-(NSMutableArray *)modelArray_M{
    if (!_modelArray_M) {
        NSArray *array=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tgs" ofType:@"plist"]];
        NSMutableArray *temporaryArray=[[NSMutableArray alloc]init];
        for (int a=0; a<array.count; a++) {
            ZLShopModel *model=[ZLShopModel shopModelWithDictionary:array[a]];
            [temporaryArray addObject:model];
        }
        _modelArray_M=temporaryArray;
    }
    return _modelArray_M;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
    [self addButtonWithTitle:@"进入编辑状态" LeftOrRightConstraint:@"left" Tag:1];
    [self addButtonWithTitle:@"删除" LeftOrRightConstraint:@"right" Tag:2];
}

/** 添加TableView,并对它进行约束*/
-(void)addTableView{
    UITableView *tableView=[[UITableView alloc]init];
    [self.view addSubview:tableView];
    self.tableView=tableView;
    tableView.rowHeight=100.f;
    tableView.dataSource=self;
    tableView.delegate=self;
    __weak typeof(self)weakSelf=self;
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(50);
        make.left.equalTo(weakSelf.view);
        make.width.equalTo(weakSelf.view);
        make.height.equalTo(weakSelf.view).offset(-50);
    }];
}

#pragma mark- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray_M.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLTableViewCell *cell=[ZLTableViewCell cellForTableView:tableView];
    cell.model=self.modelArray_M[indexPath.row];
    return cell;
}

/** 此方法用来创建顶部的按钮-->
 *title：按钮的文字
 *LeftOrRightConstraint：选择left或者是right（字符串类型）
 */
-(UIButton *)addButtonWithTitle:(NSString*)title LeftOrRightConstraint:(NSString *)constraint Tag:(NSInteger)tag{
    UIButton *button=[[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor=[constraint isEqualToString:@"left"]?[UIColor blueColor]:[UIColor redColor];
    [self.view addSubview:button];
    button.tag=tag;
    __weak typeof(self)weakSelf=self;
    [button makeConstraints:^(MASConstraintMaker *make) {
        [constraint isEqualToString:@"left"]?make.left.equalTo(weakSelf.view):make.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
        make.width.equalTo(150);
        make.height.equalTo(50);
    }];
    return button;
}

/** 顶部按钮的点击事件*/ //TODO:顶部按钮的点击事件
-(void)buttonClick:(UIButton *)sender{
    if (sender.tag==1) {
        //允许在编辑模式进行勾选操作
        self.tableView.allowsMultipleSelectionDuringEditing=YES;
        self.tableView.editing=!self.tableView.editing;
        return;
    }
    NSArray *array=[self.tableView indexPathsForSelectedRows];
    NSMutableArray *deleteModelArray=[[NSMutableArray alloc]init];
    for (NSIndexPath *idexPath in array) {
        [deleteModelArray addObject:[self.modelArray_M objectAtIndex:idexPath.row]];
    }
    [self.modelArray_M removeObjectsInArray:deleteModelArray];
    [deleteModelArray removeAllObjects];
    [self.tableView reloadData];
}
@end
