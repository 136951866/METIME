//
//  MEBrandAreasplineCell.m
//  ME时代
//
//  Created by hank on 2019/3/11.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBrandAreasplineCell.h"
#import "AAChartKit.h"
#import "AAChartModel.h"

@interface MEBrandAreasplineCell ()<AAChartViewDidFinishLoadDelegate>

@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (weak, nonatomic) IBOutlet AAChartView *aaChartView;


@end

@implementation MEBrandAreasplineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = 0;
    self.aaChartView.backgroundColor = [UIColor whiteColor];
    self.aaChartView.delegate = self;
    self.aaChartView.scrollEnabled = NO;//禁用 AAChartView 滚动效果
    [self.aaChartView aa_drawChartWithChartModel:self.aaChartModel];
    // Initialization code
}

- (void)setUiWithModel:(id)model title:(NSString *)title{
    self.aaChartModel.categories = @[@"Java", @"Swift", @"Python", @"Ruby", @"PHP", @"Go",@"ssss"];//设置 X 轴坐标文字内容
    self.aaChartModel.title = kMeUnNilStr(title);
    self.aaChartModel.series =@[
                            AASeriesElement.new
                            .nameSet(@"")
                            .dataSet(@[@0.45, @1, @1.5, @2, @2.7, @0.62, @1])
                           
                            ];
    [self.aaChartView aa_refreshChartWithChartModel:self.aaChartModel];
}

- (AAChartModel *)aaChartModel{
    if(!_aaChartModel){
        _aaChartModel= AAChartModel.new
        .chartTypeSet(AAChartTypeAreaspline)//图表类型
        .titleSet(@"近7日客户活跃度")//图表主标题
        .titleFontSizeSet(@15)
        .subtitleSet(@"")//图表副标题
//        .yAxisLineWidthSet(@0)//Y轴轴线线宽为0即是隐藏Y轴轴线
        .colorsThemeSet(@[@"#F9553C"])//设置主体颜色数组
        .yAxisTitleSet(@"")//设置 Y 轴标题
        .tooltipValueSuffixSet(@"℃")//设置浮动提示框单位后缀
        .backgroundColorSet(@"#ffffff")
        .xAxisGridLineWidthSet(@1)
        .yAxisGridLineWidthSet(@1);//y轴横向分割线宽度为0(即是隐藏分割线)

        _aaChartModel.animationType = AAChartAnimationEaseOutQuart;//图形的渲染动画为 EaseOutQuart 动画
//        _aaChartModel.xAxisCrosshairWidth = @0.9;//Zero width to disable crosshair by default
        _aaChartModel.xAxisCrosshairColor = @"#ffffff";//(浓汤)乳脂,番茄色准星线
        _aaChartModel.xAxisCrosshairDashStyleType = AALineDashSyleTypeLongDashDot;
        _aaChartModel.legendEnabled = NO;
        _aaChartModel.tooltipEnabled = NO;
        _aaChartModel.shouldGroupAccessibilityChildren= YES;
        self.aaChartModel.markerRadius = @0;
        
    }
    return _aaChartModel;
}


#pragma mark -- AAChartView delegate
- (void)AAChartViewDidFinishLoad {
    NSLog(@"🔥🔥🔥🔥🔥 AAChartView content did finish load!!!");
}

@end
