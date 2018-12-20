//
//  MEProductDetailsBottomView.h
//  ME时代
//
//  Created by hank on 2018/9/7.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kMEProductDetailsBottomViewHeight  = 50;

@interface MEProductDetailsBottomView : UIView

@property (nonatomic, copy) kMeBasicBlock addShopcartBlock;
@property (nonatomic, copy) kMeBasicBlock buyBlock;
@property (nonatomic, copy) kMeBasicBlock customBlock;
@property (nonatomic, copy) NSString *productId;
//用户B clerk 分享
@property (nonatomic, assign) NSInteger is_clerk_share;
//@property (nonatomic, assign) BOOL isGift;
@property (weak, nonatomic) IBOutlet UIButton *btnGift;

@end
