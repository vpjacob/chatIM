//
//  ViewController.m
//  TaoBaoDetailDemo
//
//  Created by vpjacob on 2017/6/2.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"
#import "LoginViewController.h"


#define kWaveViewH 200
static NSString *tableViewReuseIdentifier = @"UITableViewCell";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate,UIWebViewDelegate>
@property(strong,nonatomic)UIScrollView *scrollView;
@property(strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)  UIWebView *webView;
@property (nonatomic, strong) UIButton *toolButton;
@property (nonatomic, assign)UIStatusBarStyle barStyle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"tb详情界面";
    self.navigationController.navigationBar.translucent = NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.toolButton];
    [self.scrollView addSubview:self.tableView];
    [self.scrollView addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    [self addHeaderFooter];
    _barStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
}


#pragma mark - addHeaderFooter
- (void)addHeaderFooter{
    CGFloat duration = 0.3f;
    
    // 1.设置 UITableView 上拉显示商品详情
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0, self.scrollView.bounds.size.height);
        } completion:^(BOOL finished) {
            [self.tableView.footer endRefreshing];
        }];
    }];
    footer.automaticallyHidden = NO;
    footer.stateLabel.backgroundColor = self.tableView.backgroundColor;
    [footer setTitle:@"继续拖动，查看图文详情" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开，即可查看图文详情" forState:MJRefreshStatePulling];
    [footer setTitle:@"松开，即可查看图文详情" forState:MJRefreshStateRefreshing];
    self.tableView.footer = footer;
    
    
    // 2.设置 UIWebView 下拉显示商品详情
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [self.webView.scrollView.header endRefreshing];
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置文字、颜色、字体
    [header setTitle:@"下拉，返回商品简介" forState:MJRefreshStateIdle];
    [header setTitle:@"释放，返回商品简介" forState:MJRefreshStatePulling];
    [header setTitle:@"释放，返回商品简介" forState:MJRefreshStateRefreshing];
    header.stateLabel.textColor = [UIColor redColor];
    header.stateLabel.font = [UIFont systemFontOfSize:12.f];
    self.webView.scrollView.header = header;

}

#pragma mark - UIWebViewDelegate sf-header
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

- (void)btnClick{
     LoginViewController *loginVC = [LoginViewController new];
    [self.navigationController pushViewController:loginVC animated:YES];
}


    


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    JJOCJSViewController *vc = [JJOCJSViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%zd行",indexPath.row + 1];
//    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return _barStyle;
}

#pragma mark - setGeter
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, JJSCREEN_W, JJSCREEN_H - 64 - 40)];
        _scrollView.contentSize = CGSizeMake(JJSCREEN_W, (JJSCREEN_H - 64) * 2);
        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}



- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.scrollView.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewReuseIdentifier];
    }
    return _tableView;
}

- (UIButton *)toolButton{
    if (!_toolButton) {
        _toolButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _toolButton.frame = CGRectMake(0,CGRectGetMaxY(self.scrollView.frame), JJSCREEN_W, 40);
        [_toolButton setBackgroundColor:[UIColor redColor]];
        [_toolButton setTitle:@"联系客服" forState:UIControlStateNormal];
        _toolButton.backgroundColor = [UIColor redColor];
        [_toolButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _toolButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_toolButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        _toolButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    }
    return _toolButton;
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.bounds), JJSCREEN_W, self.tableView.bounds.size.height)];
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
