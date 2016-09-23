//
//  NCTool.m
//  健康骑行
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "NCTool.h"
#import "AFNetworking.h"
#import "NCToolCell.h"
#import <AVOSCloud/AVOSCloud.h>

@interface NCTool ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSArray *datas;
//@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *arrMation;
@property(nonatomic,strong)NSDictionary *dict;
/*提示信息**/
@property(nonatomic,strong)UIAlertController *alertCtr;
@property(nonatomic,strong) NSString *objectId;
@end

@implementation NCTool

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *strDef = [defaults objectForKey:@"txtUserName"];
    if (strDef){
        [self setLogin];
    }else{
        [self alertActionWithMessage:@"您还没有登陆,请先点击个人进行登陆"]; 
//        self.view.backgroundColor = [UIColor lightTextColor];
    }
    
    
}
-(void)setLogin{

    _arrMation = [NSMutableArray array];
    AVQuery *query = [AVQuery queryWithClassName:@"userInfoMation"];
    [query whereKey:@"userName" equalTo:[AVUser currentUser].username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        NSLog(@"%@",objects);
        //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (AVObject *userObj in objects) {
            self.objectId = userObj.objectId;
            _dict = [userObj valueForKey:@"localData"][@"mation"];
//            NSLog(@"%@",_dict);
        }
        self.dict = _dict;
        [_arrMation addObjectsFromArray:objects];
        //        });
        [self.tableView reloadData];
    }];
    
    

}
//懒加载数组
-(NSMutableArray *)arrMation{
    if (_arrMation) {
        return _arrMation;
    }
    _arrMation = [NSMutableArray array];
    
    
    return _arrMation;
    
}
-(void)viewDidLoad{
    self.title = @"数据";
  self.tableView .estimatedRowHeight = 80;
    [self loadDefaultSetting];
//    [self.tableViewsetEditing:YES];
//    self.tableView.editing = YES;
}

-(void)loadDefaultSetting{
    // 添加一个编辑按钮
    UIButton *btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnEdit setTitle:@"编辑" forState:UIControlStateNormal];
    [btnEdit setTitle:@"完成" forState:UIControlStateSelected];
    [btnEdit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnEdit setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [btnEdit addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnEdit sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnEdit];

    
    
    
}
//navigationItem.rightBarButtonItem的点击事件
- (void)editAction:(UIButton *)button {
       button.selected = !button.isSelected;
    if (button.isSelected == YES) {
        [self.tableView setEditing:YES animated:YES];
    } else {
        [self.tableView setEditing:NO animated:YES];
    }
//    NSLog(@"%@", self.arrMation);
}

#pragma mark ---UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.arrMation.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        NCToolCell *cell = [NCToolCell cellWillTableView:tableView];
    cell.lalCycingTimer.text = self.dict[@"lalCyclingTime"];
    cell.lalMileage.text = self.dict[@"lalMileage"];
    cell.lalVelocity.text = self.dict[@"lalAverageSpeed"];
    cell.lalRengTimer.text = self.dict[@"lalRestTime"];
      return cell;
}

//编辑cell
- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.arrMation removeObjectAtIndex:row];
        [self deleteSouces];

    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(void)deleteSouces{

    // 执行 CQL 语句实现删除一个 Todo 对象
    [AVQuery doCloudQueryInBackgroundWithCQL:[NSString stringWithFormat:@"delete from userInfoMation where objectId='%@'",self.objectId] callback:^(AVCloudQueryResult *result, NSError *error) {
        // 如果 error 为空，说明保存成功
        if (!error) {
            
        }
//        NSLog(@"%@",error);
    }];




}
/** 提示信息*/
-(void)alertActionWithMessage:(NSString *)message {
    self.alertCtr = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [self.alertCtr addAction:alertAction];
    [self presentViewController:self.alertCtr animated:YES completion:nil];
}


@end
