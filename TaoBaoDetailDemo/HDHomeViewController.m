//
//  HDHomeViewController.m
//  IMHelpDeskDemo
//
//  Created by afanda on 6/2/17.
//  Copyright © 2017 easemob. All rights reserved.
//

#import "HDHomeViewController.h"
#import "HDIMViewController.h"
@interface HDHomeViewController ()

@end

@implementation HDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = @[@"客服",@"IM",@"退出"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) { //客服
        HDMessageViewController *chatVC = [[HDMessageViewController alloc] initWithConversationChatter:kDefaultCustomerName];
        [self.navigationController pushViewController:chatVC animated:YES];
    }
    if (indexPath.row == 1) { //IM
        HDIMViewController *im = [[HDIMViewController alloc] init];
        [self.navigationController pushViewController:im animated:YES];
    }
    if (indexPath.row == 2) { //退出
        [[HChatClient sharedClient] logout:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
