//
//  MEGiftFooterView.h
//  ME时代
//
//  Created by hank on 2018/12/19.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMEGiftFooterViewHeight 275

@interface MEGiftFooterView : UITableViewHeaderFooterView

- (void)setUIWithModel:(id)model contentBlock:(kMeTextBlock)contentBlock;

@end
