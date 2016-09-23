//
//  NCEquipmentOne.m
//  健康骑行
//
//  Created by qingyun on 16/9/17.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "NCEquipmentOne.h"
#import "AFNetworking.h"
#define BASE_URL @"http://m.jd.com/product/1030925565.html?resourceType=jdapp_share&resourceValue=CopyURL&utm_source=androidapp&utm_medium=appshare&utm_campaign=t_335139774&utm_term=CopyURL"
@interface NCEquipmentOne ()<UIWebViewDelegate>
@property(nonatomic,strong)AFHTTPSessionManager * manager;
@property(nonatomic,strong)UIWebView *webView;

@end

@implementation NCEquipmentOne

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDefaultSetting];

}
-(void)loadDefaultSetting{
    self.webView = [[UIWebView alloc]init];
    self.view = _webView;
    _webView.delegate = self;
    NSURL *webUrl = [NSURL URLWithString:BASE_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:webUrl];
    [_webView loadRequest:request];
       
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('content').style.display = 'none';"];
}

@end
