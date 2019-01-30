//
//  MEBynamicHomeVC.m
//  ME时代
//
//  Created by hank on 2019/1/23.
//  Copyright © 2019 hank. All rights reserved.
//

#import "MEBynamicHomeVC.h"
#import "MEBynamicMainCell.h"
#import "CLInputToolbar.h"
#import "MEBynamicHomeModel.h"
#import "METhridProductDetailsVC.h"
#import "IQKeyboardManager.h"
@interface MEBynamicHomeVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>{
    NSInteger _comentIndex;}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CLInputToolbar *inputToolbar;
@property (nonatomic, strong) ZLRefreshTool         *refresh;
@property (nonatomic, strong) UIView *maskView;
@end

@implementation MEBynamicHomeVC

- (void)dealloc{
    kNSNotificationCenterDealloc
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动态";
    if(![MEUserInfoModel isLogin]){
        
    }else{
        [self.view addSubview:self.tableView];
        [self.refresh addRefreshView];
        [self setTextViewToolbar];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogout) name:kUserLogout object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogin) name:kUserLogin object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide:)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
}
//- (void)keyboardWillHide:(NSNotification *)notification{
//    if(self.maskView && self.inputToolbar){
//        [self.inputToolbar bounceToolbar];
//        self.maskView.hidden = YES;
//    }
//}

- (void)userLogout{
    [self.navigationController popToViewController:self animated:NO];
    [self.refresh.arrData removeAllObjects];
    self.refresh = nil;
    [self.tableView removeFromSuperview];
    self.tableView = nil;
    self.maskView.hidden = YES;
    [self.inputToolbar bounceToolbar];
    [self.inputToolbar removeFromSuperview];
    self.inputToolbar = nil;
    [self.maskView removeFromSuperview];
    self.maskView = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)userLogin{
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
    [self setTextViewToolbar];
}
#pragma mark - RefreshToolDelegate

- (NSDictionary *)requestParameter{
    return @{@"token":kMeUnNilStr(kCurrentUser.token),@"tool":@"1"};
}

- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[MEBynamicHomeModel mj_objectArrayWithKeyValuesArray:data]];
}


#pragma mark - tableView deleagte and sourcedata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.refresh.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MEBynamicHomeModel *model = self.refresh.arrData[indexPath.row];
    MEBynamicMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MEBynamicMainCell class]) forIndexPath:indexPath];
    [cell setUIWithModel:model];
    kMeWEAKSELF
    cell.shareBlock = ^{
        kMeSTRONGSELF
        [strongSelf shareAction];
    };
    cell.LikeBlock = ^{
        kMeSTRONGSELF
        [strongSelf likeAction:indexPath.row];
    };
    cell.CommentBlock = ^{
        kMeSTRONGSELF
        [strongSelf commentAction:indexPath.row];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MEBynamicHomeModel *model = self.refresh.arrData[indexPath.row];
    return [MEBynamicMainCell getCellHeightithModel:model];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MEBynamicHomeModel *model = self.refresh.arrData[indexPath.row];
    if(model.product_id){
        METhridProductDetailsVC *dvc = [[METhridProductDetailsVC alloc]initWithId:model.product_id];
        [self.navigationController pushViewController:dvc animated:YES];
    }
}

- (void)shareAction{
    MEShareTool *shareTool = [MEShareTool me_instanceForTarget:self];
    shareTool.sharWebpageUrl = MEIPShare;
    NSLog(@"%@",MEIPShare);
    shareTool.shareTitle = @"睁着眼洗的洁面慕斯,你见过吗?";
    shareTool.shareDescriptionBody = @"你敢买我就敢送,ME时代氨基酸洁面慕斯(邮费10元)";
    shareTool.shareImage = kMeGetAssetImage(@"icon-wgvilogo");
    
    [shareTool shareWebPageToPlatformType:UMSocialPlatformType_WechatSession success:^(id data) {
        NSLog(@"分享成功%@",data);
        [MEPublicNetWorkTool postAddShareWithSuccessBlock:nil failure:nil];
        [MEShowViewTool showMessage:@"分享成功" view:kMeCurrentWindow];
    } failure:^(NSError *error) {
        NSLog(@"分享失败%@",error);
        [MEShowViewTool showMessage:@"分享失败" view:kMeCurrentWindow];
    }];
}

- (void)commentAction:(NSInteger)index{
    if(index>self.refresh.arrData.count){
        return;
    }
    _comentIndex = index;
    [self didTouchBtn];
}

- (void)likeAction:(NSInteger)index{
    if(index>self.refresh.arrData.count){
        return;
    }
    MEBynamicHomeModel *model = self.refresh.arrData[index];
    kMeWEAKSELF
    [MEPublicNetWorkTool postdynamicPraiselWithdynamicId:kMeUnNilStr(model.idField) successBlock:^(ZLRequestResponse *responseObject) {
        kMeSTRONGSELF
        dispatch_async(dispatch_get_main_queue(), ^{
            model.praise_over = YES;
            NSMutableArray *arrPar = [NSMutableArray array];
            MEBynamicHomepraiseModel *modelp = [[MEBynamicHomepraiseModel alloc]init];
            modelp.nick_name = kMeUnNilStr(kCurrentUser.name);
            [arrPar addObjectsFromArray:kMeUnArr(model.praise)];
            [arrPar addObject:modelp];
            model.praise = [NSArray arrayWithArray:arrPar];
            [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        });
    } failure:^(id object) {
        
    }];
}

-(void)didTouchBtn {
    self.maskView.hidden = NO;
    [self.inputToolbar popToolbar];
}
-(void)tapActions:(UITapGestureRecognizer *)tap {
    [self.inputToolbar bounceToolbar];
    self.maskView.hidden = YES;
}

-(void)setTextViewToolbar {
    self.maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActions:)];
    [self.maskView addGestureRecognizer:tap];
    [self.view addSubview:self.maskView];
    self.maskView.hidden = YES;
    self.inputToolbar = [[CLInputToolbar alloc] init];
    self.inputToolbar.textViewMaxLine = 3;
    self.inputToolbar.fontSize = 15;
    self.inputToolbar.placeholder = @"请输入...";
    kMeWEAKSELF
    [self.inputToolbar inputToolbarSendText:^(NSString *text) {
        kMeSTRONGSELF
        NSLog(@"%@",text);
        MEBynamicHomeModel *model = strongSelf.refresh.arrData[strongSelf->_comentIndex];
        [MEPublicNetWorkTool postdynamicCommentdynamicId:kMeUnNilStr(model.idField) content:kMeUnNilStr(text) successBlock:^(ZLRequestResponse *responseObject) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                MEBynamicHomecommentModel *modelc = [MEBynamicHomecommentModel new];
                modelc.nick_name = kMeUnNilStr(kCurrentUser.name);
                modelc.content = kMeUnNilStr(text);
                NSMutableArray *arrPar = [NSMutableArray array];
                [arrPar addObjectsFromArray:kMeUnArr(model.comment)];
                [arrPar addObject:modelc];
                model.comment = [NSArray arrayWithArray:arrPar];
                [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:strongSelf->_comentIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                [strongSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:strongSelf->_comentIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
                [strongSelf.inputToolbar bounceToolbar];
                strongSelf.maskView.hidden = YES;
            });
            
        } failure:^(id object) {
            
        }];
    }];
    [self.maskView addSubview:self.inputToolbar];
}

#pragma MARK - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kMeNavBarHeight-kMeTabBarHeight) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MEBynamicMainCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MEBynamicMainCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        view.backgroundColor = kMEededed;
        _tableView.tableFooterView = [UIView new];//view;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:kGetApiWithUrl(MEIPcommongetDynamicList)];
        _refresh.delegate = self;
        _refresh.isDataInside = YES;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor whiteColor];
            failView.lblOfNodata.text = @"没有动态";
        }];
    }
    return _refresh;
}

@end
