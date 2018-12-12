//
//  MEClerkCell.h
//  ME时代
//
//  Created by hank on 2018/12/12.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kMEClerkCellHeight = 84;

@interface MEClerkCell : UITableViewCell

- (void)setUIWIthModel:(id)model;
- (void)setUIWithModel:(id )model withKey:(NSString *)key;

@end
