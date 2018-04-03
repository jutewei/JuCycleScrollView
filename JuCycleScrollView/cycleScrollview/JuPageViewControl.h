//
//  JuPageView.h
//  PFBDoctor
//
//  Created by Juvid on 2016/10/21.
//  Copyright © 2016年 Juvid(zhutianwei). All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, JUPageAlignment ) {
    JUPageAlignmentRight = 1,//页数居右
    JUPageAlignmentLeft  = 2,//页数居左
};

@interface JuPageViewControl : UIControl

@property(nonatomic) CGFloat pageSpace;// 两个点之间间距 默认8
@property(nonatomic) CGFloat pageSize; ///< 点的大小 默认4
@property (nonatomic ,assign)JUPageAlignment juPageAlignment; ///< 点的位置 默认居中


@property(nonatomic) NSInteger numberOfPages;          // default is 0
@property(nonatomic) NSInteger currentPage;            // default is 0. value pinned to 0..numberOfPages-1

@property(nonatomic) BOOL hidesForSinglePage;          // hide the the indicator if there is only one page. default is NO

@property(nonatomic) BOOL defersCurrentPageDisplay;    // if set, clicking to a new page won't update the currently displayed page until -updateCurrentPageDisplay is called. default is NO
//- (void)updateCurrentPageDisplay;                      // update page display to match the currentPage. ignored if defersCurrentPageDisplay is NO. setting the page value directly will update immediately


@property(nullable, nonatomic,strong) UIColor *pageIndicatorTintColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
@property(nullable, nonatomic,strong) UIColor *currentPageIndicatorTintColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;

@end
