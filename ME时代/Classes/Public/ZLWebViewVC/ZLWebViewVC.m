//
//  ZLWebViewVC.m
//  我要留学
//
//  Created by Hank on 10/20/16.
//  Copyright © 2016 深圳市智联天下国际教育有限公司. All rights reserved.
//

#import "ZLWebViewVC.h"
#import "UIWebView+FLUIWebView.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ZLWebViewVC ()

@property (nonatomic, strong) NSTimer *fakeProgressTimer;
@property (nonatomic, assign) BOOL uiWebViewIsLoading;
@property (nonatomic, strong) NSURL *uiWebViewCurrentURL;
@property (nonatomic, strong) UIWebView *uiWebView;


@end

@implementation ZLWebViewVC

#pragma mark - Dealloc

- (void)dealloc {
    [self.webView setDelegateViews:nil];
    [self.progressView removeFromSuperview];
    [self.webView removeFromSuperview];
}

#pragma mark - Static Initializers

+ (ZLWebViewVC *)webBrowser {
    ZLWebViewVC *webBrowserVC = [ZLWebViewVC webBrowserWithConfiguration:nil];
    return webBrowserVC;
}

+ (ZLWebViewVC *)webBrowserWithConfiguration:(WKWebViewConfiguration *)configuration {
    ZLWebViewVC *webBrowserVC = [[ZLWebViewVC alloc] initWithConfiguration:configuration];
    return webBrowserVC;
}

#pragma mark - Initializers

- (id)init {
    return [self initWithConfiguration:nil];
}

- (id)initWithConfiguration:(WKWebViewConfiguration *)configuration {
    self = [super init];
    if(self) {
        self.uiWebView = [[UIWebView alloc] init];
        self.showProgress = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = self.uiWebView;
    [self.uiWebView setFrame: CGRectMake(0, kMeNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kMeNavBarHeight)];
    [self.uiWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.uiWebView setMultipleTouchEnabled:YES];
    [self.uiWebView setAutoresizesSubviews:YES];
    [self.uiWebView setScalesPageToFit:YES];
    [self.uiWebView.scrollView setAlwaysBounceVertical:YES];
    [self.view addSubview:self.uiWebView];

    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [self.progressView setTrackTintColor:[UIColor colorWithWhite:1.0f alpha:0.0f]];
    [self.progressView setFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height-self.progressView.frame.size.height, self.view.frame.size.width, self.progressView.frame.size.height)];
    [self.progressView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [[self webView] setDelegateViews: self];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.showProgress && !self.progressView.superview) {
        [self.navigationController.navigationBar addSubview:self.progressView];
    }
    self.progressView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.progressView.hidden = YES;
}

#pragma mark - Public Interface

- (void)loadURL:(NSURL *)URL {
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self loadRequest:request];
}

- (void)loadURLString:(NSString *)URLString {
    NSURL *URL = [NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self loadURL:URL];
}

-(void)loadRequest:(NSURLRequest *)request{
    [self.uiWebView loadRequest:request];
}

- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler: (void (^)(id, NSError *))completionHandler{
    if (self.webView) {
        [self.webView evaluateJavaScript:javaScriptString completionHandler:completionHandler];
    }
}


#pragma mark - Fake Progress Bar Control (UIWebView)

- (void)fakeProgressViewStartLoading {
    [self.progressView setProgress:0.0f animated:NO];
    [self.progressView setAlpha:1.0f];
    
    if(!self.fakeProgressTimer) {
        self.fakeProgressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/60.0f target:self selector:@selector(fakeProgressTimerDidFire:) userInfo:nil repeats:YES];
    }
}

- (void)fakeProgressBarStopLoading {
    if(self.fakeProgressTimer) {
        [self.fakeProgressTimer invalidate];
    }
    if(self.progressView) {
        [self.progressView setProgress:1.0f animated:YES];
        [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.progressView setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [self.progressView setProgress:0.0f animated:NO];
        }];
    }
}

- (void)fakeProgressTimerDidFire:(id)sender {
    CGFloat increment = 0.005/(self.progressView.progress + 0.2);
    if([self.uiWebView isLoading]) {
        CGFloat progress = (self.progressView.progress < 0.75f) ? self.progressView.progress + increment : self.progressView.progress + 0.0005;
        if(self.progressView.progress < 0.95) {
            [self.progressView setProgress:progress animated:YES];
        }
    }
}
#pragma mark - UIWebView Delegate Methods

- (BOOL) webView: (UIWebView *) webView shouldStartLoadWithRequest: (NSURLRequest *) request navigationType: (UIWebViewNavigationType) navigationType{
    if(webView == self.uiWebView) {
        self.uiWebViewCurrentURL = request.URL;
        self.uiWebViewIsLoading = YES;
        [self fakeProgressViewStartLoading];
    }
    return YES;
}
- (void) webViewDidStartLoad: (UIWebView *) webView{

}
- (void) webView: (UIWebView *) webView didFailLoadWithError: (NSError *) error{
    if(!self.uiWebView.isLoading) {
        self.uiWebViewIsLoading = NO;
        [self fakeProgressBarStopLoading];
    }
}
- (void) webViewDidFinishLoad: (UIWebView *) webView{
    //注意：加弱引用是防止网络很差时，webview未加载结束，pop当前控制器崩溃，具体原因还不知道。
    kMeWEAKSELF
    if(webView == weakSelf.uiWebView) {
        if(!weakSelf.uiWebView.isLoading) {
            weakSelf.uiWebViewIsLoading = NO;
            [weakSelf fakeProgressBarStopLoading];
        }
    }
}

@end
