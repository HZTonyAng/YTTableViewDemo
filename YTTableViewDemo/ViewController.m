//
//  ViewController.m
//  YTTableViewDemo
//
//  Created by TonyAng on 16/4/1.
//  Copyright © 2016年 TonyAng. All rights reserved.
//

#import "ViewController.h"
#import "YTViewAController.h"
@interface ViewController ()

@property (nonatomic,strong)UIButton *ytBtnA;
@property (nonatomic,strong)UIButton *ytBtnB;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createBtnA];
    [self createBtnB];
}
/**
 *  BtnA
 */
-(void)createBtnA{
    _ytBtnA = [UIButton buttonWithType:UIButtonTypeCustom];
    _ytBtnA.backgroundColor = [UIColor lightGrayColor];
    _ytBtnA.frame = CGRectMake(self.view.frame.size.width/2 - 100, 100, 200, 50);
    [_ytBtnA addTarget:self action:@selector(OnClickA:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_ytBtnA];
}
/**
 *  BtnA Action
 *
 */
-(void)OnClickA:(UIButton *)button{
    YTViewAController *_ytView = [YTViewAController new];

    _ytView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:_ytView animated:YES completion:nil];
}

/**
 *  BtnB
 */
-(void)createBtnB{
    _ytBtnB = [UIButton buttonWithType:UIButtonTypeCustom];
    _ytBtnB.backgroundColor = [UIColor lightGrayColor];
    _ytBtnB.frame = CGRectMake(self.view.frame.size.width/2 - 100, 200, 200, 50);
    [_ytBtnB addTarget:self action:@selector(OnClickB:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_ytBtnB];
}
/**
 *  BtnB Action
 *
 */
-(void)OnClickB:(UIButton *)button{
    YTViewAController *_ytView = [YTViewAController new];
    
    _ytView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:_ytView animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
