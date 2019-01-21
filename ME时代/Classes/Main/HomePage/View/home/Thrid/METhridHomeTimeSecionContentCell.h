//
//  METhridHomeTimeSecionContentCell.h
//  ME时代
//
//  Created by hank on 2019/1/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kMEThridHomeTimeSecionContentCellHeight = 55;
const static CGFloat kMEThridHomeTimeSecionContentCellWdith = 60;

@interface METhridHomeTimeSecionContentCell : UICollectionViewCell

- (void)setUIWIthModel:(id)model isSelect:(BOOL)isSelect;

@end

NS_ASSUME_NONNULL_END
