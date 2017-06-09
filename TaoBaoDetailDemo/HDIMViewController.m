//
//  HDIMViewController.m
//  IMHelpDeskDemo
//
//  Created by afanda on 6/2/17.
//  Copyright © 2017 easemob. All rights reserved.
//

#import "HDIMViewController.h"
#import "ChatroomListViewController.h"

@interface HDIMViewController ()

@end

@implementation HDIMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = @[@"好友列表",@"聊天室"];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        EaseUsersListViewController *list = [[EaseUsersListViewController alloc] init];
        [self.navigationController pushViewController:list animated:YES];
    }
    if (indexPath.row == 1) {
        ChatroomListViewController *rooms = [[ChatroomListViewController alloc] init];
        [self.navigationController pushViewController:rooms animated:YES];
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
