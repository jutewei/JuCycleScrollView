//
//  ViewController.m
//  JuCycleScrollView
//
//  Created by Juvid on 2018/4/2.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "ViewController.h"
#import "JuCycleEdgeScrollView.h"

@interface ViewController (){

    __weak IBOutlet JuCycleEdgeScrollView *ju_cycleScrollView;
    __weak IBOutlet JuCycleScrollView *ju_cycle2;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ju_cycleScrollView.juItemW=[[UIScreen mainScreen] bounds].size.width-80;
//    ju_cycle2.juItemW=[[UIScreen mainScreen] bounds].size.width-40;
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [ju_cycleScrollView juSetScrollItem:@[@"1.jpg",@"2.jpeg",@"3.jpg",@"4.jpeg"]];
    [ju_cycle2 juSetScrollItem:@[@"1.jpg",@"2.jpeg",@"3.jpg"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
