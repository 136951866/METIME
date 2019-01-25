//
//  MEFlowLabelView.m
//  ME时代
//
//  Created by hank on 2019/1/25.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEFlowLabelView.h"

const static CGFloat MEFlowLabelViewLabelHeight = 17;
const static CGFloat MEFlowLabelViewLabelMargin = 5;
const static CGFloat MEFlowLabelViewLabelPadding = 8;

#define kMEFlowLabelViewWdith (SCREEN_WIDTH - 100)

@interface MEFlowLabelView(){
    NSMutableArray *_arrLabel;
}

@end

@implementation MEFlowLabelView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        _arrLabel = [NSMutableArray array];
        
    }
    return self;
}

+ (CGFloat)getMEFlowLabelViewHeightWithArr:(NSArray *)arr{
    CGFloat height = 0;
    if(kMeUnArr(arr).count){
        for (int i = 0; i < arr.count; i ++){
            NSString *name = arr[i];
            static UILabel *recordlabel =nil;
            
            UILabel *lbl = [[UILabel alloc]init];
            lbl.font = [UIFont systemFontOfSize:10];
 
            CGRect rect = [name boundingRectWithSize:CGSizeMake(kMEFlowLabelViewWdith -(MEFlowLabelViewLabelMargin * 2), MEFlowLabelViewLabelHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:lbl.font} context:nil];
            
            CGFloat BtnW = rect.size.width+MEFlowLabelViewLabelPadding;
            BtnW = BtnW>(kMEFlowLabelViewWdith - (MEFlowLabelViewLabelMargin *2))?(kMEFlowLabelViewWdith - (MEFlowLabelViewLabelMargin *2)):BtnW;
            
            CGFloat BtnH = MEFlowLabelViewLabelHeight;
            if (i == 0){
                lbl.frame =CGRectMake(MEFlowLabelViewLabelMargin, 0, BtnW, BtnH);
            }else{
                //算出剩下的宽度
                CGFloat yuWidth = kMEFlowLabelViewWdith - (MEFlowLabelViewLabelMargin*2) -recordlabel.frame.origin.x -recordlabel.frame.size.width;
                if (yuWidth >= BtnW) {
                    //如果大于就放在同一行
                    lbl.frame =CGRectMake(recordlabel.frame.origin.x +recordlabel.frame.size.width + MEFlowLabelViewLabelMargin, recordlabel.frame.origin.y, BtnW, BtnH);
                }else{
                    //如果不够就换行
                    lbl.frame =CGRectMake(MEFlowLabelViewLabelMargin, recordlabel.frame.origin.y+recordlabel.frame.size.height+MEFlowLabelViewLabelMargin, BtnW, BtnH);
                }
            }
            height = CGRectGetMaxY(lbl.frame)+MEFlowLabelViewLabelMargin;
            recordlabel = lbl;
        }
    }
    return height;
}
- (void)reloaWithArr:(NSArray *)arr{
    CGFloat allHeight = 0;
    for (int i = 0; i < arr.count; i ++){
        NSString *name = arr[i];
        static UILabel *recordlabel =nil;
        
        UILabel *lbl = [[UILabel alloc]init];
        lbl.font = [UIFont systemFontOfSize:10];
        lbl.textColor = kME333333;
        lbl.textColor = kME333333;
        lbl.text = name;
        
        CGRect rect = [name boundingRectWithSize:CGSizeMake(kMEFlowLabelViewWdith -(MEFlowLabelViewLabelMargin * 2), MEFlowLabelViewLabelHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:lbl.font} context:nil];
        
        CGFloat BtnW = rect.size.width+MEFlowLabelViewLabelPadding;
        BtnW = BtnW>(kMEFlowLabelViewWdith - (MEFlowLabelViewLabelMargin *2))?(kMEFlowLabelViewWdith - (MEFlowLabelViewLabelMargin *2)):BtnW;
        
        CGFloat BtnH = MEFlowLabelViewLabelHeight;
        if (i == 0){
            lbl.frame =CGRectMake(MEFlowLabelViewLabelMargin, allHeight, BtnW, BtnH);
        }else{
            //算出剩下的宽度
            CGFloat yuWidth = kMEFlowLabelViewWdith - (MEFlowLabelViewLabelMargin*2) -recordlabel.frame.origin.x -recordlabel.frame.size.width;
            if (yuWidth >= BtnW) {
                //如果大于就放在同一行
                lbl.frame =CGRectMake(recordlabel.frame.origin.x +recordlabel.frame.size.width + MEFlowLabelViewLabelMargin, recordlabel.frame.origin.y, BtnW, BtnH);
            }else{
                //如果不够就换行
                lbl.frame =CGRectMake(MEFlowLabelViewLabelMargin, recordlabel.frame.origin.y+recordlabel.frame.size.height+MEFlowLabelViewLabelMargin, BtnW, BtnH);
            }
        }
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.borderWidth = 0.5;
        lbl.borderColor = [UIColor colorWithHexString:@"dddddd"];
        [self addSubview:lbl];
        [_arrLabel addObject:lbl];
        self.frame = CGRectMake(self.x , self.y, kMEFlowLabelViewWdith ,CGRectGetMaxY(lbl.frame)+MEFlowLabelViewLabelMargin);
        recordlabel = lbl;
    }
}

@end
