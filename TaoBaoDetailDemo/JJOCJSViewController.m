//
//  JJOCJSViewController.m
//  TaoBaoDetailDemo
//
//  Created by vpjacob on 2017/6/2.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJOCJSViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JJOCJSModel.h"

@interface JJOCJSViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *webView;
@end

@implementation JJOCJSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"index.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    [self.webView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    JJOCJSModel *model = [JJOCJSModel new];
    context[@"ttf"] = model;
    __weak typeof(self) weakSelf = self;
    model.myBlock = ^(NSString *str) {
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    };
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, JJSCREEN_W, JJSCREEN_H - 64)];
        _webView.delegate = self;
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
