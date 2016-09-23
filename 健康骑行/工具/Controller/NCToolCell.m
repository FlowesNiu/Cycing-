//
//  NCToolCell.m
//  健康骑行
//
//  Created by qingyun on 16/9/17.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "NCToolCell.h"

@implementation NCToolCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWillTableView:(UITableView *)tableView{
    static NSString *str = @"NCToolCell";
    NCToolCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NCToolCell" owner:nil options:nil]firstObject];
    }
    
    return cell;
    
    
}

@end
