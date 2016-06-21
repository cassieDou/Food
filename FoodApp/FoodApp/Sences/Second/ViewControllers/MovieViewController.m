//
//  MovieViewController.m
//  FoodApp
//
//  Created by lanou3g on 16/6/20.
//  Copyright © 2016年 me. All rights reserved.
//

#import "MovieViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Masonry.h>

#import "UMSocial.h"
#import "UMSocialSnsService.h"

#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT [UIScreen mainScreen].bounds.size.height

@interface MovieViewController ()<AVPlayerViewControllerDelegate>
@property(nonatomic, strong)AVPlayer *player;
@property(nonatomic, strong)AVPlayerViewController *playerControl;
@property(nonatomic, strong)AVAudioSession *session;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = [NSString stringWithFormat:@"%@",self.model.src];
    self.player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:str]];
    self.playerControl = [[AVPlayerViewController alloc]init];
    self.playerControl.player = self.player;
    //self.playerControl.view.frame = CGRectMake(0, 0, KWIDTH, (KHEIGHT / 3) * 2);
   // self.playerControl.view.center = self.view.center;
    self.playerControl.showsPlaybackControls = YES;
    [self presentViewController:self.playerControl animated:YES completion:nil];
    
//    //收藏   分享按钮
//    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:(UIBarButtonItemStylePlain) target:self action:@selector(shareAction:)];
//    UIBarButtonItem *collectionBtn = [[UIBarButtonItem alloc]initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(collectionAction)];
//    self.navigationItem.rightBarButtonItems = @[shareBtn,collectionBtn];
    
//    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIButton *collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:shareBtn];
//    [self.view addSubview:collectionBtn];
//    shareBtn.backgroundColor = [UIColor whiteColor];
//    collectionBtn.backgroundColor = [UIColor whiteColor];
//    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(CGPointMake(KWIDTH / 3, KHEIGHT / 4));
//    }];
//    [collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(CGPointMake(KHEIGHT / 3 + 30, KHEIGHT /4));
//    }];
//    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
//    [collectionBtn setTitle:@"收藏" forState:UIControlStateNormal];
//
//    [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
//    [collectionBtn addTarget:self action:@selector(collection) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.view bringSubviewToFront:shareBtn];
//    [self.view bringSubviewToFront:collectionBtn];
}

//收藏
-(void)collectionAction{
    
}


//分享
-(void)shareAction:(UIBarButtonItem *)share{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"570dc12767e58e7025001c2f" shareText:self.model.foodtitle shareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.model.titlepic]]]] shareToSnsNames:@[UMShareToQQ,UMShareToSina] delegate:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
