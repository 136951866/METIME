//
//  MEGetCaseCell.h
//  ME时代
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEGetCaseCell : UITableViewCell

+ (CGFloat)getCellHeightWithModel:(id)model;
- (void)setUIDataDealWIthModel:(id)model;
- (void)setUIWithModel:(id)model;

@end
