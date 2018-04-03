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

}

@end

@implementation JuCycleEdgeScrollView
-(void)juSetScrollItem:(NSArray*)arrItem{
    [super juSetScrollItem:arrItem];
    for (int i=0; i<2; i++) {
        UIImageView *imgItem =[[UIImageView alloc]init];
        imgItem.contentMode = UIViewContentModeScaleAspectFill;
        [ju_ScrollView addSubview:imgItem];
        imgItem.juSizeEqual(ju_ScrollView);
        imgItem.juCenterY.equal(0);
        if (i==0) {
            imgItem.juLeftSpace.equal(-self.juItemW);
            [self juSetItemImage:imgItem withData:arrItem.lastObject];
        }else{
            imgItem.juLead.equal(self.juItemW*(arrItem.count+1));
            [self juSetItemImage:imgItem withData:arrItem.count>1?arrItem[1]:arrItem[0]];
        }
        [imgItem setClipsToBounds:YES];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
