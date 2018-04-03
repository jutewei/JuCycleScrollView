//
//  JuCycleEdgeScrollView.m
//  JuCycleScrollView
//
//  Created by Juvid on 2018/4/2.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuCycleEdgeScrollView.h"
#import "UIView+JuLayout.h"

@interface JuCycleEdgeScrollView (){
    CGFloat lastSetOffset;
}

@end

@implementation JuCycleEdgeScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)juSetTimer{
//    ju_Timer= [NSTimer scheduledTimerWithTimeInterval:ju_Animation target: self selector: @selector(juHandleTimer:)  userInfo:nil  repeats: YES];
//    [ju_Timer pauseTimer];
}
-(void)juSetScrollItem:(NSArray *)arrItem{
    if (!arrItem&&arrItem.count==0) return;
    ju_ArrList=[NSMutableArray arrayWithArray:arrItem];
    if (ju_ArrList.count<=1) {
        [ju_Timer pauseTimer];
    }
    else{
        [ju_Timer resumeTimerAfterTimeInterval:ju_Animation];
        [ju_ArrList insertObject:arrItem.lastObject atIndex:0];
        [ju_ArrList addObject:arrItem.firstObject];
    }
    ju_TotalNum=(int)ju_ArrList.count;
    [self juPageStyle:ju_TotalNum-2];
    [ju_ScrollView removeAllSubviews];
    UIImageView *currentItem=nil;
    for (int i=0; i<ju_TotalNum; i++) {
        UIImageView *imgItem =[[UIImageView alloc]init];
        imgItem.tag=i;
        imgItem.userInteractionEnabled=YES;
        imgItem.contentMode = UIViewContentModeScaleAspectFill;
        [ju_ScrollView addSubview:imgItem];
        imgItem.juSizeEqual(ju_ScrollView);
        imgItem.juCenterY.equal(0);
        imgItem.juLead.equal(i*self.juItemW);

        [imgItem setClipsToBounds:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(juTapAction:)];
        [imgItem addGestureRecognizer:tap];
        [self juSetItemImage:imgItem withData:ju_ArrList[i]];
        currentItem=imgItem;
    }
    [ju_ScrollView setContentOffset:CGPointMake(self.juItemW, 0) animated:NO];
    ju_ScrollView.contentSize=CGSizeMake(ju_TotalNum*self.juItemW, 0);
}
//设置数据
-(void)juSetItemImage:(UIImageView *)imgItem withData:(id)imageData{
    if ([imageData isKindOfClass:[NSString class]]) {
        imgItem.image=[UIImage imageNamed:imageData];
    }

}
-(void)juPageStyle:(NSInteger)pageNum{
    pageNum=pageNum==0?1:pageNum;
    ju_Page.numberOfPages=pageNum;
}
-(void)juSetItemlable:(UIView *)viewImg withData:(id)sh_M{
    ju_Page.currentPageIndicatorTintColor=[UIColor lightGrayColor];
    ju_Page.pageIndicatorTintColor=[UIColor whiteColor];
}

#pragma mark 拖动时赋值
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat scrollViewX=scrollView.contentOffset.x;
    ju_CurrentNum=scrollViewX/CGRectGetWidth(scrollView.frame)-1;

    if (scrollViewX==(ju_TotalNum-1)*self.juItemW){
        ju_CurrentNum=0;
    }
    if (ju_Timer) {
        [ju_Timer resumeTimerAfterTimeInterval:ju_Animation];
    }
    ju_Page.currentPage=ju_CurrentNum;
}
#pragma mark - 5秒换图片
- (void) juHandleTimer: (NSTimer *) timer
{
    if(ju_CurrentNum==3){
        [ju_ScrollView setContentOffset:CGPointMake(self.juItemW,0)];
    }

    ju_CurrentNum++;

    [UIView animateWithDuration:1 animations:^{
        [self->ju_ScrollView setContentOffset:CGPointMake((self->ju_CurrentNum+1)*self.juItemW,0) ];
    } completion:^(BOOL finished) {
        if(self->ju_CurrentNum==self->ju_TotalNum-1){//先移动到最后一页////在移动到第一页//最后一页时
            self->ju_CurrentNum=0;
            [self->ju_ScrollView setContentOffset:CGPointMake(self.juItemW,0)];
            self->ju_Page.currentPage=self->ju_CurrentNum;
        }
    }];
    ju_Page.currentPage=ju_CurrentNum;
}

//暂停定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (ju_Timer) {
        [ju_Timer pauseTimer];
    }
}
//开始定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [ju_Timer resumeTimerAfterTimeInterval:ju_Animation];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollViewX=scrollView.contentOffset.x;
    CGFloat scrollW=CGRectGetWidth(self.frame);
    if (scrollViewX>lastSetOffset&&scrollViewX>(ju_TotalNum-2)*scrollW) {//往右拖动 最后一张（实质倒数第二张）
        lastSetOffset=0;
        [scrollView setContentOffset:CGPointMake(lastSetOffset, 0) animated:NO];
    }
    else if (scrollViewX<lastSetOffset&&scrollViewX<scrollW){//往左拖动 第一张（实质第二张）
        lastSetOffset=(ju_TotalNum-1)*CGRectGetWidth(self.frame);
        [scrollView setContentOffset:CGPointMake(lastSetOffset, 0) animated:NO];
    }else{
        lastSetOffset=scrollViewX;
    }
}

@end
