//
//  MEBrandAreasplineCell.h
//  ME时代
//
//  Created by hank on 2019/3/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kMEBrandAreasplineCellHeight = 273;

@interface MEBrandAreasplineCell : UITableViewCell
- (void)setUiWithModel:(id)model  title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
