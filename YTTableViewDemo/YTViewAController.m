//
//  YTViewAController.m
//  YTTableViewDemo
//
//  Created by TonyAng on 16/4/1.
//  Copyright © 2016年 TonyAng. All rights reserved.
//

#import "YTViewAController.h"
#import "SquareCashStyleBar.h"
#import "SquareCashStyleBehaviorDefiner.h"
#import "BLKDelegateSplitter.h"
@interface YTViewAController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *ytTableView;

@property (nonatomic) SquareCashStyleBar *myCustomBar;
@property (nonatomic) BLKDelegateSplitter *delegateSplitter;
@end

@implementation YTViewAController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createTableView];
    [self createBar];
    
}

-(void)createBar{
    self.myCustomBar = [[SquareCashStyleBar alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 100.0)];
    SquareCashStyleBehaviorDefiner *behaviorDefiner = [[SquareCashStyleBehaviorDefiner alloc] init];
    [behaviorDefiner addSnappingPositionProgress:0.0 forProgressRangeStart:0.0 end:0.5];
    [behaviorDefiner addSnappingPositionProgress:1.0 forProgressRangeStart:0.5 end:1.0];
    behaviorDefiner.snappingEnabled = YES;
    behaviorDefiner.elasticMaximumHeightAtTop = YES;
    self.myCustomBar.behaviorDefiner = behaviorDefiner;
    self.delegateSplitter = [[BLKDelegateSplitter alloc] initWithFirstDelegate:behaviorDefiner secondDelegate:self];
    self.ytTableView.delegate = (id<UITableViewDelegate>)self.delegateSplitter;
    [self.view addSubview:self.myCustomBar];
    [self.ytTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.ytTableView.contentInset = UIEdgeInsetsMake(self.myCustomBar.maximumBarHeight, 0.0, 0.0, 0.0);
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(self.myCustomBar.frame.size.width-40.0, 25.0, 30.0, 30.0);
    closeButton.tintColor = [UIColor whiteColor];
    [closeButton setImage:[UIImage imageNamed:@"Close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.myCustomBar addSubview:closeButton];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)closeViewController:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createTableView{
    _ytTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    _ytTableView.delegate = self;
    _ytTableView.dataSource = self;
    [self.view addSubview:_ytTableView];
}

#pragma mark -
#pragma mark 返回某个分区的单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

#pragma mark -
#pragma mark 返回有多少分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark -
#pragma mark 返回一个分区有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

#pragma mark -
#pragma mark 返回表的单元格对象
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"identifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        // 设置单元格附件样式
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //        // 自定义右边附件视图
        //        UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        //        aView.backgroundColor = [UIColor redColor];
        //        cell.accessoryView = aView;
    }
    cell.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"你点击了第%ld分区第%ld行", indexPath.section ,indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
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
