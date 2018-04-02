//
//  ViewController.m
//  JuCycleScrollView
//
//  Created by Juvid on 2018/4/2.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "ViewController.h"
#import "JuCycleScrollView.h"

@interface ViewController (){

    __weak IBOutlet JuCycleScrollView *ju_cycleScrollView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [ju_cycleScrollView juSetScrollItem:@[@"1.jpg",@"2.jpeg",@"3.jpg"]];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
