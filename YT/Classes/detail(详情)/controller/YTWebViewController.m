//
//  YTWebViewController.m
//  YT
//
//  Created by wangzhenhai on 15/10/17.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTWebViewController.h"
#import "goodsModel.h"
#import "galleryModel.h"
@interface YTWebViewController ()<UIWebViewDelegate>

@end

@implementation YTWebViewController

- (void)loadView
{
    self.view = [[UIWebView alloc] init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style: UIBarButtonItemStyleDone target:self action:@selector(back)];
    UIWebView *webview = (UIWebView *)self.view;
    
    webview.delegate = self;
    NSString *path =[NSString stringWithFormat:@"http://app.yetang.com/appgate/pgate/storyDetail?pid=%@",self.url];
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showSuccess:@"加载中"];
}

//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    [MBProgressHUD hideHUD];
//}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
