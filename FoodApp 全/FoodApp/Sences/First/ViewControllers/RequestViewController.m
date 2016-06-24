//
//  RequestViewController.m
//  HGY
//


#import "RequestViewController.h"


@interface RequestViewController ()<UIWebViewDelegate, UMSocialUIDelegate>

@property (nonatomic, retain)UIActivityIndicatorView *actiView;
@property (nonatomic, strong) NSString *html;

@property (nonatomic, retain)UIView *view1;
@property (nonatomic, assign)BOOL isBool;

@property (nonatomic, retain)UIWebView *webView;

@end

typedef enum : NSUInteger {
    Fade = 1, // 淡入淡出
    CameraIrisHollowOpen,   // 推挤
   
} AnimationType;

@implementation RequestViewController

- (void)viewWillAppear:(BOOL)animated
{
    // 隐藏tabBar
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44 * kHeight)];
    label.backgroundColor = [UIColor whiteColor];
    label.text = self.model.title;
    label.textAlignment = NSTextAlignmentCenter;
    [self.webView addSubview:label];
    
    

    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
   self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate = self;
    // 禁止下拉
    self.webView.scrollView.bounces = NO;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.requestUrl]];
    
     [self.webView loadRequest:request];
    
    

    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(((kScreenWidth - 100) / 2) , 100 * kHeight, 150 * kWidth, 100 * kHeight)];
    self.view1.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
    [self.webView  addSubview:self.view1];
    // 将view1的透明度变为0
    self.view1.alpha = 0;
    [self.view addSubview:self.webView];
    self.actiView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 50 * kWidth, kScreenHeight / 2 - 50 * kHeight, 100 * kWidth, 100 * kHeight)];
    [_actiView setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyleGray)];
    _actiView.hidesWhenStopped = YES;
    [self.view addSubview:_actiView];
 
    [self setBackAction];
}
//设置返回按钮
-(void)setBackAction{
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStylePlain target:self action:@selector(actionLeftButton)];
    [leftButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    
}
- (void)actionLeftButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadHtML:(UIWebView *)webView
{
     [webView loadHTMLString:self.html baseURL:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_actiView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_actiView stopAnimating];
}





@end
