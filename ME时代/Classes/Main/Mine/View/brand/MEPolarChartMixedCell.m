//
//  MEPolarChartMixedCell.m
//  ME时代
//
//  Created by hank on 2019/3/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEPolarChartMixedCell.h"
#import "AAChartKit.h"
#import "AAChartModel.h"

@interface MEPolarChartMixedCell ()<AAChartViewDidFinishLoadDelegate>

@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (weak, nonatomic) IBOutlet AAChartView *aaChartView;


@end

@implementation MEPolarChartMixedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    self.aaChartView.backgroundColor = [UIColor whiteColor];
    self.aaChartView.delegate = self;
    self.aaChartView.scrollEnabled = NO;//禁用 AAChartView 滚动效果
    [self.aaChartView aa_drawChartWithChartModel:self.aaChartModel];
    // Initialization code
}

- (void)setUiWithModel:(id)model{
    self.aaChartModel.categories = @[@"销售能力", @"客户互动力", @"产品推广力", @"活动推广力", @"客户跟进力", @"获客能力"];//设置 X 轴坐标文字内容
    self.aaChartModel.series =
    @[
      AASeriesElement.new
      .nameSet(@"能力")
      .typeSet(AAChartTypeArea)
      .dataSet(@[@1, @8, @2, @7, @3, @6, ])
      ];
    [self.aaChartView aa_refreshChartWithChartModel:self.aaChartModel];
}

- (AAChartModel *)aaChartModel{
    if(!_aaChartModel){
        _aaChartModel = AAChartModel.new
        .chartTypeSet(AAChartTypeColumn)
        .polarSet(true)
        .titleSet(@"");
    }
    return _aaChartModel;
}


#pragma mark -- AAChartView delegate
- (void)AAChartViewDidFinishLoad {
    NSLog(@"🔥🔥🔥🔥🔥 AAChartView content did finish load!!!");
}


@end
