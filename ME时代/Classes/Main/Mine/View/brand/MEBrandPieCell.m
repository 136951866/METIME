//
//  MEBrandPieCell.m
//  ME时代
//
//  Created by hank on 2019/3/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBrandPieCell.h"
#import "AAChartKit.h"
#import "AAChartModel.h"

@interface MEBrandPieCell ()<AAChartViewDidFinishLoadDelegate>

@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (weak, nonatomic) IBOutlet AAChartView *aaChartView;


@end

@implementation MEBrandPieCell

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
    self.aaChartModel.series =
              @[
                AASeriesElement.new
                .nameSet(@"顾客数")
                .innerSizeSet(@"1%")//内部圆环半径大小占比
                .statesSet(@{@"hover": @{@"enabled": @(false)}})
                .sizeSet(@124)//尺寸大小
                .borderWidthSet(@0)//描边的宽度
                .allowPointSelectSet(false)//是否允许在点击数据点标记(扇形图点击选中的块发生位移)
                .dataSet(
                         @[
                           @[@"个人",   @1],
                           @[@"商品",    @1],
                           @[@"拼团",    @1],
                           @[@"砍价",        @1],
                           ]
                         ),
                ];
    [self.aaChartView aa_refreshChartWithChartModel:self.aaChartModel];
}

- (AAChartModel *)aaChartModel{
    if(!_aaChartModel){
        _aaChartModel = AAChartModel.new
        .chartTypeSet(AAChartTypePie)
        .titleFontSizeSet(@15)
        .colorsThemeSet(@[@"#F9553C",@"#207C9E",@"#8C3F63",@"#F9B43B"])
        .titleSet(@"客户兴趣占比")
        .subtitleSet(@"")
        .dataLabelEnabledSet(true)//是否直接显示扇形图数据
        .yAxisTitleSet(@"")
        ;
        _aaChartModel.categories = @[@"",@"",@"",@""];
    }
    return _aaChartModel;
}


#pragma mark -- AAChartView delegate
- (void)AAChartViewDidFinishLoad {
    NSLog(@"🔥🔥🔥🔥🔥 AAChartView content did finish load!!!");
}


@end
