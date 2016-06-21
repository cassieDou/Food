//
//  ShareTableViewController.h
//  FoodApp
//
//  Created by 三千世界 on 16/6/17.
//  Copyright © 2016年 me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareTableViewController : UITableViewController

@property (nonatomic, strong)NSMutableArray *collectionArray;
@property (nonatomic, assign)NSInteger keyWordNumber;
@property (nonatomic, assign)BOOL isChange;


@end
