//
//  VideoViewController.h
//  FoodApp
//
//  Created by lanou3g on 16/6/14.
//  Copyright © 2016年 me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondModel.h"
#import <Masonry.h>

typedef void(^frameOfPlayerView) (MASConstraintMaker *make);


@interface VideoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UIButton *playController;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;//音量
@property (weak, nonatomic) IBOutlet UISlider *processSlider;//播放进度
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property(nonatomic, strong)SecondModel *model;//model传值
@end