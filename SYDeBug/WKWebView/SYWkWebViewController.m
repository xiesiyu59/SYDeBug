//
//  SYWkWebViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/3/4.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "SYWkWebViewController.h"
#import <WebKit/WebKit.h>

@interface SYWkWebViewController () <WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,UIScrollViewDelegate>

@property (nonatomic, strong)UIProgressView *progressView;
@property (nonatomic, strong)WKWebViewConfiguration *wkWebViewConfig;
@property (nonatomic, strong)WKUserContentController *userContentController;
@property (nonatomic, strong)WKWebView *wkwebView;
@property (nonatomic, strong)NSURL *url;

@end

@implementation SYWkWebViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if (self.wkwebView) {
        self.wkwebView.navigationDelegate = self;
        self.wkwebView.UIDelegate = self;
        self.wkwebView.scrollView.delegate = self;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.wkwebView.navigationDelegate = nil;
    self.wkwebView.UIDelegate = nil;
    self.wkwebView.scrollView.delegate = nil;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.wkwebView.configuration.userContentController removeScriptMessageHandlerForName:@"WXPay"];
}

- (void)setUrlString:(NSString *)urlString{
    _urlString = urlString;
    [self configUrl:urlString];
}

- (void)configUrl:(NSString *)url{
    
    if (url.length == 0) {
        url = @"https://www.baidu.com";
    }
    
    if ([url containsString:@"https"]) {
        
        self.url = [NSURL URLWithString:url];
        
    }else if([url containsString:@"http"]){
        
        self.url = [NSURL URLWithString:[url stringByReplacingOccurrencesOfString:@"http" withString:@"https"]];
    }else{
        self.url = [NSURL URLWithString:[NSString stringWithFormat:@"https://%@",url]];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self wkWebViewUsercontent];
    [self wkWebViewConfiguration];
    [self initWithInitialization];
}

//web配置方法
- (void)wkWebViewUsercontent{
    
    // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
    [self.userContentController addScriptMessageHandler:self name:@"WXPay"];
    
    NSString *jScript = @"var script = document.createElement('meta');"
    "script.name = 'viewport';"
    "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    self.userContentController = [[WKUserContentController alloc] init];
    [self.userContentController addUserScript:wkUScript];
}


- (void)wkWebViewConfiguration{
    
    //创建网页配置对象
    self.wkWebViewConfig = [[WKWebViewConfiguration alloc] init];
    // 创建设置对象
    WKPreferences *preference = [[WKPreferences alloc]init];
    //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
    preference.minimumFontSize = 0;
    //设置是否支持javaScript 默认是支持的
    preference.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
    preference.javaScriptCanOpenWindowsAutomatically = YES;
    self.wkWebViewConfig.preferences = preference;
    
    // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
    self.wkWebViewConfig.allowsInlineMediaPlayback = YES;
    // 允许可以与网页交互，选择视图
    self.wkWebViewConfig.selectionGranularity = YES;
    // web内容处理池
    self.wkWebViewConfig.processPool = [[WKProcessPool alloc]init];
    // 是否支持记忆读取
    self.wkWebViewConfig.suppressesIncrementalRendering = YES;
    
    //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
    self.wkWebViewConfig.requiresUserActionForMediaPlayback = YES;
    //设置是否允许画中画技术 在特定设备上有效
    self.wkWebViewConfig.allowsPictureInPictureMediaPlayback = YES;
    //设置请求的User-Agent信息中应用程序名称 iOS9后可用
    self.wkWebViewConfig.applicationNameForUserAgent = @"SYDeBug";
    
    self.wkWebViewConfig.userContentController = self.userContentController;
     
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    NSString *htmls = self.contentString;
    htmls = [htmls stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    htmls = [htmls stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    htmls = [htmls stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    
    
    
    NSString *content = [NSString stringWithFormat:@"<html> \n"
                         "<head> \n"
                         "<style type=\"text/css\"> \n"
                         "img {margin-left:3px;margin-right:3px;width:100%%!important;height:auto;}\n"
                         "video {margin-left:3px;width:100%%!important;height:auto;!important;}\n"
                         "body {background-color:#ffffff;margin-left:10px;margin-top:10px;margin-right:10px;color:#161823}\n"
                         "font {color:#161823}\n"
                         "</style> \n"
                         "</head> \n"
                         "<body>%@</body> \n"
                         "</html>",htmls];
    
    //初始化
    self.wkwebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kScreenTopIsX) configuration:self.wkWebViewConfig];
    // UI代理
    self.wkwebView.UIDelegate = self;
    // 导航代理
    self.wkwebView.navigationDelegate = self;
    // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
    self.wkwebView.allowsBackForwardNavigationGestures = YES;
    [self.wkwebView sizeToFit];
    [self.view addSubview:self.wkwebView];
    
    if (self.contentString) {
        [self.wkwebView loadHTMLString:content baseURL:nil];
    }else{
        [self.wkwebView loadRequest:[NSURLRequest requestWithURL:self.url]];
    }
    //进度
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame),1)];
    self.progressView.trackTintColor = [UIColor clearColor];
    self.progressView.progressTintColor = [UIColor blackColor];
    [self.progressView setProgress:0.02 animated:YES];
    [self.view addSubview:self.progressView];
    
    
    //添加监测网页加载进度的观察者
    [self.wkwebView addObserver:self
                     forKeyPath:@"estimatedProgress"
                        options:0
                        context:nil];
    //添加监测网页标题title的观察者
    [self.wkwebView addObserver:self
                     forKeyPath:@"title"
                        options:NSKeyValueObservingOptionNew
                        context:nil];
    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.chinadaily.com.cn"]];
//    [request addValue:[self readCurrentCookieWithDomain:@"http://www.chinadaily.com.cn"] forHTTPHeaderField:@"Cookie"];
//    [self.wkwebView loadRequest:request];
    
//    //页面后退
//    [self.wkwebView goBack];
//    //页面前进
//    [self.wkwebView goForward];
//    //刷新当前页面
//    [self.wkwebView reload];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"JStoOC.html" ofType:nil];
//    NSString *htmlString = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    //加载本地html文件
//    [self.wkwebView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
       
}

//kvo 监听进度 必须实现此方法
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == self.wkwebView) {
        NSLog(@"网页加载进度 = %f",self.wkwebView.estimatedProgress);
        self.progressView.progress = self.wkwebView.estimatedProgress;
        if (self.wkwebView.estimatedProgress >= 1.0f) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.progress = 0;
            });
        }
    }else if([keyPath isEqualToString:@"title"]
             && object == self.wkwebView){
        self.navigationItem.title = self.wkwebView.title;
    }else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"开始加载");
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    [self.progressView setProgress:0.0f animated:NO];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"返回内容");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    [self getCookie];
    NSLog(@"加载完成");
    //禁止用户选择
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    [webView evaluateJavaScript:@"document.activeElement.blur();" completionHandler:nil];
    // 适当增大字体大小
    //        [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'" completionHandler:nil];
    //    }
    
    NSString *js = @"function imgAutoFit() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
    var img = imgs[i];   \
    img.style.maxWidth = %f;   \
    } \
    }";
    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width - 20];
    [webView evaluateJavaScript:js completionHandler:nil];
    [webView evaluateJavaScript:@"imgAutoFit()" completionHandler:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        webView.scrollView.contentOffset = CGPointZero;
    });
    
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        //修情高度
//        self.wkwebView.frame = CGRectMake(0, 0, kScreenWidth, [result integerValue]);
    }];
}
//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
    NSLog(@"提交错误");
}
// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
    
}

// 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString * urlStr = navigationAction.request.URL.absoluteString;
    NSLog(@"发送跳转请求：%@",urlStr);
    //自己定义的协议头
    NSString *htmlHeadString = @"github://";
    if([urlStr hasPrefix:htmlHeadString]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"通过截取URL调用OC" message:@"你想前往我的Github主页?" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }])];
        [alertController addAction:([UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL * url = [NSURL URLWithString:[urlStr stringByReplacingOccurrencesOfString:@"github://callName_?" withString:@""]];
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSString * urlStr = navigationResponse.response.URL.absoluteString;
    NSLog(@"当前跳转地址：%@",urlStr);
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    //     获取cookie,并设置到本地
    NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
    for (NSHTTPCookie *cookie in cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}


//需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
    }
}

//进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
    NSLog(@"被终止");
}


/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"HTML的弹出框" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
// 确认框
//JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
// 输入框
//JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
// 页面是弹出窗口 _blank 处理
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

//注意：遵守WKScriptMessageHandler协议，代理是由WKUserContentControl设置
//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);

}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (void)webRefresh{
    
    [self.wkwebView reload];
}

- (void)webPop {
    
    if ([self.wkwebView canGoBack]) {
        [self.wkwebView goBack];
    }else {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)controllerViewBack{
    
    [self webPop];
}


-(void)dealloc{
    
    //移除观察者
    [self.wkwebView removeObserver:self
                  forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [self.wkwebView removeObserver:self
                  forKeyPath:NSStringFromSelector(@selector(title))];
}


@end
