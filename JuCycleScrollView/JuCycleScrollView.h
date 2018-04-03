//
//  JuCycleScrollView.h
//  SHPatient
//
//  Created by Juvid on 15/10/22.
//  Copyright © 2015年 Juvid(zhutianwei). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JuPageViewControl.h"
#import "NSTimer+Addition.h"
#import "UIView+Frame.h"
@protocol JuCycleScrollViewDelegate;
@interface JuCycleScrollView : UIView<UIScrollViewDelegate>{
    UIScrollView *ju_ScrollView;
    JuPageViewControl *ju_Page;
    NSMutableArray *ju_ArrList;
    int ju_CurrentNum,ju_TotalNum;
    NSTimer *ju_Timer;
    NSTimeInterval ju_Animation;

}
@property (nonatomic ,assign)JUPageAlignment juPageAlignment;
@property (nonatomic ,assign) id<JuCycleScrollViewDelegate> shDelegate;
@property (nonatomic,assign) CGFloat juItemW;

-(void)juSetScrollItem:(NSArray*)arrItem;

/**
 *  @author Juvid, 16-05-10 16:05
 *  设置轮播图是否滚动
 */
- (void)juSetTimer:(BOOL)animated;

- (void)juDealloc;


@end
@protocol JuCycleScrollViewDelegate <NSObject>

-(void)juTouchImageIndex:(id)indexs;
@end
