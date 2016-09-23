//
//  NCRecordCell.m
//  健康骑行
//
//  Created by qingyun on 16/9/14.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "NCRecordCell.h"



@interface NCRecordCell()
@property (weak, nonatomic) IBOutlet UILabel *lalCycTimeCell;

@property (weak, nonatomic) IBOutlet UILabel *lalCycMileageCell;

@property (weak, nonatomic) IBOutlet UILabel *lalCycRestCell;
@property (weak, nonatomic) IBOutlet UILabel *lalCycAverageCell;
@end

@implementation NCRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWillTableView:(UITableView *)tableView{
static NSString *str = @"NCRecordCell";
    NCRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NCRecordCell" owner:nil options:nil]firstObject];
    }

    return cell;


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
