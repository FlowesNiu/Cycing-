//
//  accountUserName.h
//  健康骑行
//
//  Created by qingyun on 16/9/6.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface NCAccountUserName : UITableViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/**定义一个block 退出登录*/
@property(nonatomic,copy)void(^logOutBlock)();

@end
