//
//  MEGiftMainCell.h
//  ME时代
//
//  Created by hank on 2018/12/20.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEGiftMainCell : UITableViewCell

- (void)setUIWithModel:(id)model block:(kMeBasicBlock)block;
+ (CGFloat)getCellHeightWithModel:(id )model;

@end
