//
//  MEBrandAiCell.h
//  ME时代
//
//  Created by hank on 2019/3/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kMEBrandAiCellHeight = 65;

@interface MEBrandAiCell : UITableViewCell

- (void)setUIWithModel:(id)model sortNum:(NSInteger)sortNum;
- (void)setSortUIWithModel:(id)model sortNum:(NSInteger)sortNum;

@end

NS_ASSUME_NONNULL_END
