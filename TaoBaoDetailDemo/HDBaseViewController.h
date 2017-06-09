//
//  HDBaseViewController.h
//  IMHelpDeskDemo
//
//  Created by afanda on 6/2/17.
//  Copyright © 2017 easemob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDBaseViewController : UIViewController

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSArray *dataSource;

@end
