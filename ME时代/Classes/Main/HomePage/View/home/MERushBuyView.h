//
//  MERushBuyView.h
//  ME时代
//
//  Created by hank on 2018/11/6.
//  Copyright © 2018年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 [MERushBuyView ShowWithModel:model tapBlock:^{
 MEProductDetailsVC *dvc = [[MEProductDetailsVC alloc]initWithId:model.product_id];
 [strongSelf.navigationController pushViewController:dvc animated:YES];
 } cancelBlock:^{
 
 }];
 */

@class MEAdModel;
@interface MERushBuyView : UIView

+ (void)ShowWithModel:(MEAdModel *)model tapBlock:(kMeBasicBlock)tapBlock cancelBlock:(kMeBasicBlock)cancelBlock superView:(UIView*)superView;
- (instancetype)initWithModel:(MEAdModel *)model superView:(UIView*)superView;

@end
