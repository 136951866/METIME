//
//  MEStoreApplyStatusVC.m
//  ME时代
//
//  Created by hank on 2019/3/21.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEStoreApplyStatusVC.h"
#import "MEStoreApplyModel.h"
#import "MEEnlargeTouchButton.h"
#import "MEStoreApplyVC.h"

@interface MEStoreApplyStatusVC ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblFailWhy;
@property (weak, nonatomic) IBOutlet UIButton *btnReApply;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTopMargin;

@property (strong, nonatomic) MEEnlargeTouchButton *btnRight;
@end

@implementation MEStoreApplyStatusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"审核状态";
    _consTopMargin.constant = kMeNavBarHeight +50;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self btnRight]];
    switch (_model.state) {
        case 1:{
            _imgPic.image = [UIImage imageNamed:@"icon_applyIng"];
            _lblStatus.text = @"提交成功，请等待管理员审核！";
            _lblFailWhy.text = kMeUnNilStr(_model.message);
        }
            break;
        case 2:{
            _imgPic.image = [UIImage imageNamed:@"icon_applySuc"];
            _lblStatus.text = @"恭喜，您的店铺审核通过了！";
            _lblFailWhy.text = kMeUnNilStr(_model.message);
        }
            break;
        case 3:
        {
            _imgPic.image = [UIImage imageNamed:@"icon_applyFail"];
            _lblStatus.text = @"抱歉，您的店铺审核未通过!";
            _lblFailWhy.text = kMeUnNilStr(_model.errot_desc);
        }
            break;
        case 4:
        {
            _imgPic.image = [UIImage imageNamed:@"icon_applyFail"];
            _lblStatus.text = @"抱歉，您的店铺已被禁用!";
            _lblFailWhy.text = kMeUnNilStr(_model.errot_desc);
        }
            break;
        default:
            break;
    }
    _btnReApply.hidden =  _model.state != 3;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)reApplyAction:(UIButton *)sender {
    MEStoreApplyVC *vc = [[MEStoreApplyVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)popBackAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (MEEnlargeTouchButton *)btnRight{
    MEEnlargeTouchButton *btnRight= [MEEnlargeTouchButton buttonWithType:UIButtonTypeCustom];
    btnRight.frame = CGRectMake(0, 0, 70, 25);
    [btnRight setImage:[UIImage imageNamed:@"inc-xz"] forState:UIControlStateNormal];
    [btnRight setTitle:@"返回" forState:UIControlStateNormal];
    btnRight.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 26);
    btnRight.titleEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 0);
    [btnRight setTitleColor:[UIColor colorWithHexString:@"e3e3e3"] forState:UIControlStateNormal];
    btnRight.titleLabel.font = kMeFont(15);
    [btnRight setTitleColor:kMEblack forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(popBackAction) forControlEvents:UIControlEventTouchUpInside];
    return btnRight;
}

//- (void)setModel:(MEStoreApplyModel *)model{
//    _model = model;
//    //状态： 0初始状态 1待审核 2审核通过 3审核不通过 4禁用
//    switch (_model.state) {
//        case 1:{
//            _imgPic.image = [UIImage imageNamed:@"icon_applyIng"];
//            _lblStatus.text = @"提交成功，请等待管理员审核！";
//        }
//            break;
//        case 2:{
//            _imgPic.image = [UIImage imageNamed:@"icon_applySuc"];
//            _lblStatus.text = @"恭喜，您的店铺审核通过了！";
//        }
//            break;
//        case 3:
//        {
//            _imgPic.image = [UIImage imageNamed:@"icon_applyFail"];
//            _lblStatus.text = @"抱歉，您的店铺审核未通过!";
//
//        }
//            break;
//        default:
//            break;
//    }
//    _lblPhone.hidden =  _model.state != 3;
//    _btnReApply.hidden =  _model.state != 3;
//}

@end
