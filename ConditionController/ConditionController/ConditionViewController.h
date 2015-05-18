//
//  ConditionViewController.h
//  ConditionController
//
//  Created by 陈松林 on 14-9-3.
//  Copyright (c) 2014年 陈松林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConditionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic) IBOutlet UITableView*myTabView;
@property(strong,nonatomic) IBOutlet UIScrollView*btnScrollView;
@end
