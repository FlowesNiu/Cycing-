//
//  Guidevc.m
//  健康骑行
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 牛广道. All rights reserved.
//引导页


#import "Guidevc.h"
#import "AppDelegate.h"

@interface Guidevc ()<NSObject>
@property(nonatomic,weak)UIScrollView *scrollView;

@end

@implementation Guidevc

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadDefaultSetting];
}
-(void)loadDefaultSetting{
    //添加scroller
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled =YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    //给scroller添加图片
    //数zu
    NSArray *arrImageNames = @[@"scroller_Guide_1",
                               @"scroller_Guide_2",
                               @"scroller_Guide_3",
                               @"scroller_Guide_4",
                               ];
    NSUInteger count = arrImageNames.count;
    CGFloat width = CGRectGetWidth(scrollView.frame);
    CGFloat height = CGRectGetHeight(scrollView.frame);
    for (NSUInteger index = 0; index < count; index ++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(index *width, 0, width ,height);
        imageView.image = [UIImage imageNamed:arrImageNames[index]];
//        imageView.contentMode = UIViewContentModeCenter;
        [scrollView addSubview:imageView];
        if (index == count -1) {
            [self loadActionButton:imageView];
        }
    }
    //设置scroller的contenSize
    [scrollView setContentSize:CGSizeMake(count * width, 0)];
    
}

-(void)loadActionButton:(UIImageView *)imageView{

    UIButton *btnAction = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnAction setTitle:@"开启骑行之旅" forState:UIControlStateNormal];
    [btnAction setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    btnAction.titleLabel.font = [UIFont italicSystemFontOfSize:40];
    [self.scrollView addSubview:btnAction];
    CGFloat width = 250;
    CGFloat X =([[UIScreen mainScreen] bounds].size.width - width) * 0.5 + CGRectGetMinX(imageView.frame);
    CGFloat Y = [[UIScreen mainScreen] bounds].size.height - 100;
    btnAction.frame = CGRectMake(X, Y, width, 50);
    
    btnAction.layer.cornerRadius = 5.0;
    btnAction.layer.borderColor = [UIColor orangeColor].CGColor;
    btnAction.layer.borderWidth = 1.0;
    btnAction.layer.masksToBounds = YES;
    [btnAction addTarget:self action:@selector(tapBtnAction) forControlEvents:UIControlEventTouchUpInside];

}
-(void)tapBtnAction{

    // 保存版本号
    // NSUserDefaults:单例, 用法类似NSDictionary 就是能把信息存储到Bundle中的一个plist文件中
    NSString *strVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] setObject:strVersion forKey:@"oldVersionKey"];
    [[NSUserDefaults standardUserDefaults] synchronize]; // 强制现在就写入plist
    
    //NSLog(@"%@", NSHomeDirectory());
    
    // 跳转
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate loadMainViewController];



}
@end
