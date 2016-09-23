//
//  NCEquipmentFour.m
//  健康骑行
//
//  Created by qingyun on 16/9/17.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "NCEquipmentFour.h"
#define BASE_URL @"http://m.jd.com/product/1484835149.html?resourceType=jdapp_share&resourceValue=CopyURL&utm_source=androidapp&utm_medium=appshare&utm_campaign=t_335139774&utm_term=CopyURL"
@interface NCEquipmentFour ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation NCEquipmentFour

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}
-(void)loadDefaultSetting{
    _webView = [[UIWebView alloc]init];
    self.view = _webView;
    self.webView = _webView;
    self.webView.delegate = self;
    NSURL *url = [NSURL URLWithString:BASE_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:request];
    
    
    
}
#pragma  mark 
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('content').style.display = 'none';"];
    
    
}


@end
