//
//  SlidingViewController.m
//  ContinueFate
//
//  Created by 刘金发 on 16/4/17.
//  Copyright © 2016年 XuYuan. All rights reserved.
//

#import "SlidingViewController.h"


@interface SlidingViewController ()

@end

@implementation SlidingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    return cell;
}
@end
