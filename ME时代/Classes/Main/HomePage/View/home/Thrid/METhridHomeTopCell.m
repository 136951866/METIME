//
//  METhridHomeTopCell.m
//  ME时代
//
//  Created by hank on 2019/4/29.
//  Copyright © 2019 hank. All rights reserved.
//

#import "METhridHomeTopCell.h"

@interface METhridHomeTopCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblFtitle;
@property (weak, nonatomic) IBOutlet UILabel *lblFDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblFPrice;
@property (weak, nonatomic) IBOutlet UIImageView *imgfPic;

@property (weak, nonatomic) IBOutlet UILabel *lblStitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblSPrice;
@property (weak, nonatomic) IBOutlet UIImageView *imgSPic;
@property (weak, nonatomic) IBOutlet UIView *viewForF;
@property (weak, nonatomic) IBOutlet UIView *viewForS;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consFw;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cosnSw;

@end

@implementation METhridHomeTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    _lblFtitle.adjustsFontSizeToFitWidth = YES;
//    _lblStitle.adjustsFontSizeToFitWidth = YES;
    
    _lblFPrice.adjustsFontSizeToFitWidth = YES;
    _lblSPrice.adjustsFontSizeToFitWidth = YES;
    
    _viewForF.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapF)];
    [_viewForF addGestureRecognizer:ges];
    
    
    _viewForS.userInteractionEnabled = YES;
    UITapGestureRecognizer *gess = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapS)];
    [_viewForS addGestureRecognizer:gess];
    
}

- (void)tapF{
    
}

- (void)tapS{
    
}

- (void)setUiWithModel:(NSObject *)model{
    kSDLoadImg(_imgfPic, kMeUnNilStr(@"1"));
    
    
    NSString *ftitle = kMeUnNilStr(@"哈就是带");
    CGFloat w = (SCREEN_WIDTH/2)-74-15-13-1;
    CGFloat h = 14;
    
    CGRect rect = [ftitle boundingRectWithSize:CGSizeMake(w, h) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:kMeFont(10)} context:nil];
    
    CGFloat LabelFW = rect.size.width+12;
    LabelFW = LabelFW>w?w:LabelFW;
    _consFw.constant = LabelFW;
    _lblFtitle.text = ftitle;
    _lblFDesc.text = kMeUnNilStr(@"哈就是带");
    
    NSString *fstr = [NSString stringWithFormat:@"¥%@ ¥%@",@(kMeUnNilStr(@"111").floatValue),@(kMeUnNilStr(@"11").floatValue)];
    NSMutableAttributedString *faString = [[NSMutableAttributedString alloc]initWithString:fstr];

    NSUInteger firstLoc = 0;
    NSUInteger secondLoc = [[faString string] rangeOfString:@" "].location;

    NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
    [faString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"848484"] range:range];
    [faString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];

    _lblFPrice.attributedText = faString;
    
    
    
    
    
    kSDLoadImg(_imgSPic, kMeUnNilStr(@"2"));
    NSString *Stitle = kMeUnNilStr(@"哈就就就就就就就就就就就就就就就就就就就就就就就就就就就就就就就就就就就是带");
    CGRect srect = [Stitle boundingRectWithSize:CGSizeMake(w, h) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:kMeFont(10)} context:nil];
    
    CGFloat LabelSW = srect.size.width+12;
    LabelSW = LabelSW>w?w:LabelSW;
    _cosnSw.constant = LabelSW;
    
    
    _lblStitle.text = Stitle;
    _lblSDesc.text = kMeUnNilStr(@"哈就就就就是带");
    NSString *sstr = [NSString stringWithFormat:@"¥%@ ¥%@",@(kMeUnNilStr(@"222").floatValue),@(kMeUnNilStr(@"22").floatValue)];
    NSMutableAttributedString *saString = [[NSMutableAttributedString alloc]initWithString:sstr];
    
    NSUInteger sfirstLoc = 0;
    NSUInteger ssecondLoc = [[saString string] rangeOfString:@" "].location;
    
    NSRange srange = NSMakeRange(sfirstLoc, ssecondLoc - sfirstLoc);
    [saString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"848484"] range:srange];
    [saString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:srange];
    
    _lblSPrice.attributedText = saString;
}

@end
