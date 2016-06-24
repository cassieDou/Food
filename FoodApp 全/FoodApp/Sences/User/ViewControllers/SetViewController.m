//
//  SetViewController.m
//  FoodApp
//


#import "SetViewController.h"

@interface SetViewController ()
// 记录日/夜间模式
@property (nonatomic, assign) BOOL isNight;
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isNight = NO;
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.tableView.scrollEnabled = NO;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    //cell.textLabel.text = @"吃货锦囊";
    if (indexPath.row == 0) {
        cell.textLabel.text = @"清除缓存";
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
         cell.detailTextLabel.text = [NSString stringWithFormat:@"(%.2fM)", [self folderSizeAtPath:cachePath]];
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"夜间模式";
        UISwitch *time_switch = [[UISwitch alloc]init];
        
        time_switch.frame = CGRectMake(350, 10, 50, 50);
        time_switch.thumbTintColor = [UIColor lightGrayColor];
        time_switch.on = NO;
        
        [time_switch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:time_switch];
    }else if(indexPath.row == 2){
    cell.textLabel.text = @"检查更新";
    }else if (indexPath.row == 3){
    cell.textLabel.text = @"服务及隐私条款";
    }else{
    cell.textLabel.text = @"关于美食锦囊";
    }
    return cell;
}
-(void)switchAction:(UISwitch *)sender{
    if ([sender isOn]) {
        [UIApplication sharedApplication].delegate.window.alpha = 0.7;
    }else{
        [UIApplication sharedApplication].delegate.window.alpha = 1;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
//        [self clearCache:cachePath];
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"(%.2fM)",[self  folderSizeAtPath:cachePath]];
//        [self showAlertViewWithMessage:@"缓存成功清除!"];
//
        //提示清理完成的弹窗
        //1
        UIAlertController *finishAlert = [UIAlertController alertControllerWithTitle:@"清理完成" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        //2
        UIAlertAction *finishAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:nil];
        //3
        [finishAlert addAction:finishAction];
        
        __weak typeof(self) weakSelf = self;
        //询问是否清理的弹窗
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否清理缓存" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction  * action1 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            //要清除的文件路径
            NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
            NSLog(@"%@",filePath);
            //清除 SDWebIMage 的缓存图片
            [[SDImageCache sharedImageCache] cleanDisk];
            //清除文件夹里的缓存
            //创建文件管理对象
            NSFileManager *fileManager = [NSFileManager defaultManager];
            //清理活动及电影页面的缓存图片
            [fileManager removeItemAtPath:filePath error:nil];
            //清理完成后弹出提示
            [weakSelf presentViewController:finishAlert animated:YES completion:nil];
        }];
        
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil];
        [alert addAction:action1];
        [alert addAction:action2];
        //添加询问弹窗
        [self presentViewController:alert animated:YES completion:nil];
        
        
    
    }
    if (indexPath.row == 1) {
        /*
//        _isNight = !_isNight;
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        if (_isNight) {
//            cell.detailTextLabel.text = @"开启";
//            //[self showAlertViewWithMessage:@"夜间模式开启"];
//            [UIApplication sharedApplication].delegate.window.alpha = 0.7;
//        } else {
//            cell.detailTextLabel.text = @"关闭";
//            //[self showAlertViewWithMessage:@"夜间模式关闭"];
//            [UIApplication sharedApplication].delegate.window.alpha = 1;
//        }
        */
    }
    if (indexPath.row == 2) {
        //
        [self showAlertViewWithMessage:@"最新版本"];
    }
    if (indexPath.row == 3) {
        //
        [self showAlertViewWithMessage:@"请关注相关法律信息"];
        
    }if (indexPath.row == 4) {
        //
        [self showAlertViewWithMessage:@"美食锦囊挑逗你的味蕾"];
    }
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - 计算文件夹大小
- (float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize += [[SDImageCache sharedImageCache] getSize] /1024.0/1024.0;
        return folderSize;
    }
    return 0;
}
// 计算单个文件
- (float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

// 清理缓存文件
- (void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}

#pragma mark - alertView
-(void)showAlertViewWithMessage:(NSString *)message{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self performSelector:@selector(dismissAlertView:) withObject:alertView afterDelay:1];
    [self presentViewController:alertView animated:YES completion:nil];
    
}
-(void)dismissAlertView:(UIAlertController *)alertView{
    [alertView dismissViewControllerAnimated:YES completion:nil];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
