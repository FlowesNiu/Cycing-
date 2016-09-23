//
//  NCNew.m
//  健康骑行
//
//  Created by qingyun on 16/9/13.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "NCNew.h"
#import "NCNewModel.h"

@implementation NCNew
-(void)setModel:(NCNewModel *)model{
    _model = model;
    //_strTitle.text = model.title;
    //_steTime.text = model.timer;


}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
