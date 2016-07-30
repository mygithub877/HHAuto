//
//  HHBaseWebViewController.m
//  HHKit
//
//  Created by LWJ on 16/7/29.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHBaseWebViewController.h"

static NSString *completeRPCURL = @"webviewprogressproxy:///complete";

static const float initialProgressValue = 0.1;
static const float beforeInteractiveMaxProgressValue = 0.5;
static const float afterInteractiveMaxProgressValue = 0.9;

@interface HHBaseWebViewController ()<UIWebViewDelegate>{
    
    UIProgressView *_progressView;

    NSUInteger _loadingCount;
    NSUInteger _maxLoadCount;
    NSURL *_currentURL;
    BOOL _interactive;

}
@property (nonatomic, assign) float progress; // 0.0..1.0

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation HHBaseWebViewController
-(instancetype)initWithURL:(NSURL *)url{
    if (self=[super init]) {
        _url=url;
    }
    return self;
}
-(UIWebView *)webView{
    if (_webView==nil) {
        _webView=[[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.delegate=self;
        _webView.scalesPageToFit =YES;
        _progressView=[[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        _progressView.frame=CGRectMake(0, 0, self.view.width, 0);
        [self.view addSubview:_progressView];
        
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    NSURLRequest *request =[NSURLRequest requestWithURL:_url];
    [self.webView loadRequest:request];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back{
    [_webView goBack];
}
-(void)forward{
    [_webView goForward];
}
-(void)refresh{
    [_webView reload];
}
-(void)cancleLoad{
    [_webView stopLoading];
    [self setProgress:0];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
#pragma mark - webview delegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    _loadingCount++;
    _maxLoadCount = fmax(_maxLoadCount, _loadingCount);
    [self startProgress];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    _loadingCount--;
    [self incrementProgress];
    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    BOOL interactive = [readyState isEqualToString:@"interactive"];
    if (interactive) {
        _interactive = YES;
        NSString *waitForCompleteJS = [NSString stringWithFormat:@"window.addEventListener('load',function() { var iframe = document.createElement('iframe'); iframe.style.display = 'none'; iframe.src = '%@'; document.body.appendChild(iframe);  }, false);", completeRPCURL];
        [webView stringByEvaluatingJavaScriptFromString:waitForCompleteJS];
    }
    
    BOOL isNotRedirect = _currentURL && [_currentURL isEqual:webView.request.mainDocumentURL];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if (complete && isNotRedirect) {
    }
    [self setProgress:1.0];
    

}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if ([request.URL.absoluteString isEqualToString:completeRPCURL]) {
        [self setProgress:1.0];
        return NO;
    }
    
    BOOL ret = YES;
    
    BOOL isFragmentJump = NO;
    if (request.URL.fragment) {
        NSString *nonFragmentURL = [request.URL.absoluteString stringByReplacingOccurrencesOfString:[@"#" stringByAppendingString:request.URL.fragment] withString:@""];
        isFragmentJump = [nonFragmentURL isEqualToString:webView.request.URL.absoluteString];
    }
    
    BOOL isTopLevelNavigation = [request.mainDocumentURL isEqual:request.URL];
    
    BOOL isHTTP = [request.URL.scheme isEqualToString:@"http"] || [request.URL.scheme isEqualToString:@"https"];
    if (ret && !isFragmentJump && isHTTP && isTopLevelNavigation && navigationType != UIWebViewNavigationTypeBackForward) {
        _currentURL = request.URL;
        [self reset];
    }
    return ret;
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    _loadingCount--;
    [self incrementProgress];
    
    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    
    BOOL interactive = [readyState isEqualToString:@"interactive"];
    if (interactive) {
        _interactive = YES;
        NSString *waitForCompleteJS = [NSString stringWithFormat:@"window.addEventListener('load',function() { var iframe = document.createElement('iframe'); iframe.style.display = 'none'; iframe.src = '%@'; document.body.appendChild(iframe);  }, false);", completeRPCURL];
        [webView stringByEvaluatingJavaScriptFromString:waitForCompleteJS];
    }
    
    BOOL isNotRedirect = _currentURL && [_currentURL isEqual:webView.request.mainDocumentURL];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if (complete && isNotRedirect) {
    }
    [self setProgress:1.0];
    
}
#pragma mark 进度
- (void)startProgress
{
    if (_progress < initialProgressValue) {
        [self setProgress:initialProgressValue];
    }
}

- (void)incrementProgress
{
    float progress = self.progress;
    float maxProgress = _interactive ? afterInteractiveMaxProgressValue : beforeInteractiveMaxProgressValue;
    float remainPercent = (float)_loadingCount / (float)_maxLoadCount;
    float increment = (maxProgress - progress) * remainPercent;
    progress += increment;
    progress = fmin(progress, maxProgress);
    [self setProgress:progress];
}

- (void)setProgress:(float)progress
{
    
    if (progress > _progress || progress == 0) {
        _progress = progress;
        if (progress == 0.0) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            _progressView.progress = 0;
            [UIView animateWithDuration:0.27 animations:^{
                _progressView.alpha = 1.0;
            }];
        }
        if (progress == 1.0) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [UIView animateWithDuration:0.27 delay:progress - _progressView.progress options:0 animations:^{
                _progressView.alpha = 0.0;
            } completion:nil];
        }
        
        [_progressView setProgress:progress animated:NO];
        
    }
}
- (void)reset
{
    _maxLoadCount = _loadingCount = 0;
    _interactive = NO;
    [self setProgress:0.0];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
