//
//  accountUserName.m
//  健康骑行
//
//  Created by qingyun on 16/9/6.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "NCAccountUserName.h"
#import <AVOSCloud/AVOSCloud.h>
#import "NCPersonager.h"
#import "NCHeightVC.h"
#import "NCWeightVC.h"
#import "NCSexVC.h"
#import "NCAgeVC.h"
#import "NCLogin.h"

@interface NCAccountUserName ()
@property (strong, nonatomic) IBOutlet UIButton *imageHead;


@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *lalheight;
@property (strong, nonatomic) IBOutlet UILabel *lalWeight;
@property (strong, nonatomic) IBOutlet UILabel *sex;
@property (strong, nonatomic) IBOutlet UILabel *lalAge;
/*提示信息**/
@property(nonatomic,strong)UIAlertController *alertCtr;
@property (nonatomic, strong) NSMutableDictionary *dict;
@end

@implementation NCAccountUserName

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人";
    [self.navigationItem setHidesBackButton:YES];
    [self loadDefuiSetting];
    self.tableView.separatorStyle = NO;
    //将头像设置为圆形
    self.imageHead.layer.masksToBounds = YES;
    self.imageHead.layer.cornerRadius = 36;
    
    
    //separatorStyle
}
-(void)loadDefuiSetting{
    //从本地获取姓名
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.userName.text = [defaults objectForKey:@"txtUserName"];
    //从本地获取身高
    self.lalheight.text = [defaults objectForKey:@"heightVC"];
    //从本地获取体重
    self.lalWeight.text = [defaults objectForKey:@"weightVC"];
    //将性别保存到本地
    self.sex.text = [defaults objectForKey:@"sexVC"];
    //将年纪保存到本地
    self.lalAge.text = [defaults objectForKey:@"ageVC"];
//    [_dict setObject:self.userName.text forKey:@"username"];
//    [_dict setObject:self.lalheight.text forKey:@"height"];
//    [_dict setObject:self.lalWeight.text forKey:@"weight"];
//    [_dict setObject:self.sex.text forKey:@"sex"];
//    [_dict setObject:self.lalAge.text forKey:@"age"];
//    //从服务器获取头像
    NSString *imageId = [defaults objectForKey:@"imageId"];
    AVQuery *query = [AVQuery queryWithClassName:@"userInfo"];
    [query getObjectInBackgroundWithId:imageId block:^(AVObject *object, NSError *error) {
        if (!error) {
            
            NSData *data = [object objectForKey:@"imageHeader"];
            UIImage *image = [UIImage imageWithData:data];
            
             [self.imageHead setImage:image forState:UIControlStateNormal];
        }else{
        
        }
    }];
    
   

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    __weak NCAccountUserName *Vc  =self;
    NCHeightVC *heightVC = segue.destinationViewController;
    NCWeightVC *weigthVC = segue.destinationViewController;
    NCSexVC *sexvc = segue.destinationViewController;
    NCAgeVC *agevc = segue.destinationViewController;
    if ([[segue identifier] isEqualToString:@"heightVC"])  {
        [heightVC setHeightblock:^(NSString *heightNumber) {
            Vc.lalheight.text = heightNumber;
        }];
    }
    if ([[segue identifier]isEqualToString:@"weightVC"]) {
    
        [weigthVC setWeightblock:^(NSString *weightNumber) {
            Vc.lalWeight.text = weightNumber;
        }];
    }
    if ([[segue identifier]isEqualToString:@"sexVC"]) {
        [sexvc setSexblock:^(NSString *sexStr) {
            Vc.sex.text = sexStr;
        }];
        
    }
    if ([[segue identifier]isEqualToString:@"ageVC"])  {
        [agevc setAgeblock:^(NSString *ageNmuber) {
            Vc.lalAge.text = ageNmuber;
        }];
        
    }
}
//调用相册

- (IBAction)phontFormCamera:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc]init];
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerImage.delegate = self;
        pickerImage.allowsEditing = YES;
        [self presentViewController:pickerImage animated:YES completion:^{
            
        }];
    }
    
}
#pragma mark 从相册获取图片后操作
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//    self.imageHead.imageView.image = image;
    
    [self.imageHead setImage:image forState:UIControlStateNormal];
    [self saveImage:image withName:@"currentImage.png"];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


#pragma mark - 照片存到本地后的回调
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    
    if (!error) {
        
    }else{
       
    }
}
#pragma mark -- b保存图片
-(void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName{
    //吧imageHeader保存到服务器的userInfo上面
    NSData *iamgeData = UIImageJPEGRepresentation(currentImage, 0.5);
//    NSString *usernsme = [[NSUserDefaults standardUserDefaults] objectForKey:@"textUserName"];
    AVObject *user = [AVObject objectWithClassName:@"userInfo"];
    
    [user setObject:iamgeData forKey:@"imageHeader"];
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [[NSUserDefaults standardUserDefaults] setObject:user.objectId forKey:@"imageId"];[[NSUserDefaults standardUserDefaults]synchronize];
        }
    }];

    
    NSString *filPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"currentImage.png"];
    [iamgeData writeToFile:filPath atomically:NO];
}
#pragma mark - 取消操作时调用
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    
    
}
//退出登录
- (IBAction)btnLogOut:(id)sender {
    [self alertActionWithMessage:@"是否确认退出"];
 //    user.logOut();
    
    
}
/** 提示信息*/
-(void)alertActionWithMessage:(NSString *)message {
    self.alertCtr = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"txtUserName"];
        NCPersonager *personager= [[NCPersonager alloc]init];
        [self.navigationController pushViewController:personager animated:YES];
        
    }];
    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [self.alertCtr addAction:alertAction];
    [self.alertCtr addAction:alertAction1];
    [self presentViewController:self.alertCtr animated:YES completion:nil];
}
@end
