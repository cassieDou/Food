//
//  AppDelegate.m
//  FoodApp
//
//  Created by lanou3g on 16/6/13.
//  Copyright © 2016年 me. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UMSocial.h"
#import "UMSocialSnsService.h"
#import "UMSocialSinaSSOHandler.h"


// 服务器的AppID和Key
#define kAVOSCloudAppID @"JfPVyt8IdkXJiVWD0GeLsmtu-gzGzoHsz"
#define kAVOSCloudKey @"nMyweoTBoGf8KdmCe54z0ksd"
//master key v0A5KSB8bPh7ddncDyoAxpEUf3naXY4ja82pUhI05QI6d00F-gzGzoHsz

@interface AppDelegate ()

@property (nonatomic ,strong)UIButton* button;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    RootViewController *RootVC = [[RootViewController alloc]init];
    self.window.rootViewController = RootVC;
    [self.window makeKeyAndVisible];
    
    // 服务器
    [AVOSCloud setApplicationId:kAVOSCloudAppID clientKey:kAVOSCloudKey];
    // 跟踪统计应用的打开情况
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    //友盟设置
    [self setUM];
    

    AVUser *currentUser = [AVUser currentUser];
    //判断用户登录
    if (currentUser != nil) {
        //直接显示首页了
    }else{
        //添加引导页
        [self helpScroll];//一直显示引导页
    }

    return YES;
}

-(void)setUM{
    //设置友盟的APPKey
    [UMSocialData setAppKey:@"570dc12767e58e7025001c2f"];
    //设置新浪微博相关内容
    //把在新浪微博注册的应用的APPKey redirectURl 替换为下面的参数,并在 info中添加对应的 wb+APPKey
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"570dc12767e58e7025001c2f" secret:@"04b48b094faeb16683c32669824ebdad" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    
}

//系统回调方法
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //做其他操作或者调用其他SDK
    }
    return result;
}

-(UIImageView*)addSubviewImage:(NSString*)imageName  rect:(CGRect)rect{
    UIImageView*view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    view.frame=rect;
    return view;
}
-(void)helpScroll{
    //添加轮播图
    _scrVl=[[UIScrollView alloc] init];
    _scrVl.pagingEnabled = YES;
    _scrVl.delegate=self;
    _scrVl.frame=CGRectMake(0, 0,kScreenWidth, kScreenHeight);
    _scrVl.bounces = NO;
    _scrVl.contentSize=CGSizeMake(kScreenWidth * 4, kScreenHeight);
    [self.window addSubview:_scrVl];
    
    //添加图片
    for (int i=0; i<4; i++) {
        [_scrVl addSubview:[self addSubviewImage:[NSString stringWithFormat:@"help%d.jpg",i+1] rect:CGRectMake(kScreenWidth*i, 0, kScreenWidth , kScreenHeight)]];
    }
    
    //添加点击进入主页面的button
     _button=[UIButton buttonWithType:UIButtonTypeCustom];
    [_scrVl addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scrVl).with.offset(kScreenWidth *3);
        make.centerY.equalTo(_scrVl).with.offset(kScreenHeight/2 - 55);
        make.size.mas_equalTo(CGSizeMake(150, 35));
    }];
    [_button setBackgroundImage:[UIImage imageNamed:@"helpBtn.png"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(hiddenScroller:) forControlEvents:UIControlEventTouchUpInside];
    [_button setTitle:@"开始学习烹饪" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    
    //添加PageControl
    _thePGLeft=[[PageControl alloc] initWithFrame:CGRectMake(kScreenWidth /2 - 45, kScreenHeight - 32, 90, 30)];
    _thePGLeft.dotColorCurrentPage=[UIColor redColor];
    _thePGLeft.numberOfPages=4;
    [self.window addSubview:_thePGLeft];
    
}
-(void)hiddenScroller:(id)sender
{
    [UIView animateWithDuration:2.0
                     animations:^{
                         _scrVl.alpha = 0.0;
                         _thePGLeft.alpha=0.0;
                         
                     }
                     completion:^(BOOL finished){
              
                     }
     ];
}

#pragma UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [_thePGLeft setCurrentPage:offset.x / bounds.size.width];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
