//
//  JuCycleScrollView.m
//  SHPatient
//
//  Created by Juvid on 15/10/22.
//  Copyright © 2015年 Juvid(zhutianwei). All rights reserved.
//

#import "JuCycleScrollView.h"
#import "NSTimer+Addition.h"
#import "UIView+JuLayout.h"
#import "UIView+Frame.h"
#define Screen_Width [[UIScreen mainScreen] bounds].size.width

@implementation JuCycleScrollView

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
         [self juInitView];
    }
    return self;
}
- (void)juSetTimer:(BOOL)animated{
    if (animated) {
        if (ju_ArrList.count>1) {
            [ju_Timer resumeTimerAfterTimeInterval:ju_Animation];
        }
    }else{
        [ju_Timer pauseTimer];
    }
}

-(void)juStartTimer{
    ju_Timer= [NSTimer scheduledTimerWithTimeInterval:ju_Animation target: self selector: @selector(juHandleTimer:)  userInfo:nil  repeats: YES];
    [ju_Timer pauseTimer];
}
//轮播图片
#pragma mark - 5秒换图片
- (void) juHandleTimer: (NSTimer *) timer
{
    if(ju_CurrentNum==0)[ju_ScrollView setContentOffset:CGPointMake(0,0)];

    ju_CurrentNum++;

    [UIView animateWithDuration:1 animations:^{
        [self->ju_ScrollView setContentOffset:CGPointMake(self->ju_CurrentNum*Screen_Width,0) ];
    } completion:^(BOOL finished) {
        if(self->ju_CurrentNum==self->ju_TotalNum-1){//先移动到最后一页////在移动到第一页//最后一页时
            self->ju_CurrentNum=0;
            [self->ju_ScrollView setContentOffset:CGPointMake(0,0)];
            self->ju_Page.currentPage=self->ju_CurrentNum;
        }
    }];
    ju_Page.currentPage=ju_CurrentNum;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self juInitView];
}
-(void)juInitView{
    self.backgroundColor=[UIColor colorWithWhite:0.96 alpha:1];
    ju_Animation=5;
    [self juStartTimer];
    [self juSetScrollView];
}
//初始化控件
-(void)juSetScrollView{

  
    ju_ScrollView=[[UIScrollView alloc]init];
    [self addSubview:ju_ScrollView];
    ju_ScrollView.juEdge(UIEdgeInsetsMake(0, 0, 0, 0));


    ju_Page=[[JuPageViewControl alloc]init];

    ju_Page.hidesForSinglePage=YES;
    [self addSubview:ju_Page];

    ju_Page.juBottom.equal(0);
    ju_ScrollView.showsHorizontalScrollIndicator=NO;
    ju_ScrollView.showsVerticalScrollIndicator=NO;
    ju_ScrollView.pagingEnabled=YES;
    ju_ScrollView.delegate=self;

}

//初始化轮播图片
-(void)juSetScrollItem:(NSArray *)arrItem{
    if (!arrItem&&arrItem.count==0) return;
    ju_ArrList=[NSMutableArray arrayWithArray:arrItem];
    if (ju_ArrList.count<=1) {
        [ju_Timer pauseTimer];
    }
    else{
        [ju_Timer resumeTimerAfterTimeInterval:ju_Animation];
        [ju_ArrList addObject:arrItem.firstObject];
    }
    ju_TotalNum=(int)ju_ArrList.count;
    [self juPageStyle:ju_TotalNum-1];
    [ju_ScrollView removeAllSubviews];
    UIImageView *currentItem=nil;
      for (int i=0; i<ju_TotalNum; i++) {

           UIImageView *imgItem =[[UIImageView alloc]initWithFrame:CGRectMake(i*CGRectGetWidth(ju_ScrollView.frame), 0, CGRectGetWidth(ju_ScrollView.frame), CGRectGetHeight(ju_ScrollView.frame))];
          imgItem.tag=i;
          imgItem.userInteractionEnabled=YES;
          imgItem.contentMode = UIViewContentModeScaleAspectFill;
          [ju_ScrollView addSubview:imgItem];
          imgItem.juSizeEqual(ju_ScrollView);
          imgItem.juCenterY.equal(0);
          if (currentItem) {
              imgItem.juLeftSpace.toView(currentItem).equal(0);
          }else{
              imgItem.juLead.equal(0);
          }

          [imgItem setClipsToBounds:YES];
          UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(juTapAction:)];
          [imgItem addGestureRecognizer:tap];
          [self juSetItem:imgItem withData:ju_ArrList[i]];
          currentItem=imgItem;
    }
    ju_ScrollView.contentSize=CGSizeMake(ju_TotalNum*Screen_Width, 0);
}
-(void)juPageStyle:(NSInteger)pageNum{
    pageNum=pageNum==0?1:pageNum;
    ju_Page.numberOfPages=pageNum;
}
-(void)setJuPageAlignment:(JUPageAlignment)juPageAlignment{
    ju_Page.juPageAlignment=juPageAlignment;
}
//设置数据
-(void)juSetItem:(UIImageView *)imgItem withData:(id)imageData{
    if ([imageData isKindOfClass:[NSString class]]) {
        imgItem.image=[UIImage imageNamed:imageData];
    }

}
-(void)juSetItemlable:(UIView *)viewImg withData:(id)sh_M{
    ju_Page.currentPageIndicatorTintColor=[UIColor lightGrayColor];
    ju_Page.pageIndicatorTintColor=[UIColor whiteColor];
}

#pragma mark 拖动时赋值
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat scrollViewX=scrollView.contentOffset.x;
    ju_CurrentNum=scrollViewX/CGRectGetWidth(scrollView.frame);
   
    if (scrollViewX==(ju_TotalNum-1)*Screen_Width){
        ju_CurrentNum=0;
    }
    if (ju_Timer) {
        [ju_Timer resumeTimerAfterTimeInterval:ju_Animation];
    }
    ju_Page.currentPage=ju_CurrentNum;
}
//暂停定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (ju_Timer) {
        [ju_Timer pauseTimer];
    }
}
//开始定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [ju_Timer resumeTimerAfterTimeInterval:ju_Animation];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollViewX=scrollView.contentOffset.x;
    if (scrollViewX>(ju_TotalNum-1)*Screen_Width) {//最后一张
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    else if (scrollViewX<0){//第一张
        [scrollView setContentOffset:CGPointMake((ju_TotalNum-1)*Screen_Width, 0) animated:NO];
    }
}

-(void)juTapAction:(UITapGestureRecognizer *)sender{
    if ([self.shDelegate respondsToSelector:@selector(juTouchImageIndex:)]) {
        [self.shDelegate juTouchImageIndex:sender];
    }
}

-(void)dealloc{
    [self juDealloc];
}
-(void)juDealloc{
    [ju_Timer invalidate];
    ju_Timer=nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
