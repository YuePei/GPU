//
//  ViewController.m
//  GPUImage
//
//  Created by Peyton on 2018/7/2.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *middleImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *filterButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.filterButton.enabled = NO;
    self.saveButton.enabled = NO;
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
#pragma mark 拖进来的方法
//从相册选取
- (IBAction)selectImageFromAlbum:(UIBarButtonItem *)sender {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    pickerController.allowsEditing = YES;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.delegate = self;
    [self.navigationController presentViewController:pickerController animated:YES completion:^{
        //TODO
    }];
}

//拍照
- (IBAction)takePhoto:(UIBarButtonItem *)sender {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    pickerController.allowsEditing = YES;
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickerController.delegate = self;
    [self.navigationController presentViewController:pickerController animated:YES completion:^{
        //TODO
    }];
}

//添加滤镜
- (IBAction)addFilter:(UIBarButtonItem *)sender {
    
}

//将图片保存到相册
- (IBAction)saveToAlbum:(UIBarButtonItem *)sender {
    UIImageWriteToSavedPhotosAlbum(self.middleImage.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

#pragma mark UIImagePickerControllerDelegate
//选择了图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    self.filterButton.enabled = YES;
    self.saveButton.enabled = YES;
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.middleImage.image = selectedImage;
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        //TODO返回图片处理页
    }];
}

//点击了取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        //TODO
    }];
}

#pragma mark toolMethods
//图片保存到相册, 调用本方法以判断是否保存成功
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *alertTitle;
    NSString *alertMessage;
    if (error) {
        alertTitle = @"Error";
        alertMessage = @"Unable to save to album";
    }else {
        alertTitle = @"Image saved";
        alertMessage = @"Image saved to album successfully";
        //        self.middleImage.image = nil;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
