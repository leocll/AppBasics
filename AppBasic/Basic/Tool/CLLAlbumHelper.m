//
//  CLLAlbumHelper.m
//  AppBasic
//
//  Created by leocll on 2017/9/6.
//  Copyright © 2017年 leocll. All rights reserved.
//

#import "CLLAlbumHelper.h"
#import <AssetsLibrary/ALAsset.h>
#import <Photos/Photos.h>
#import <CoreLocation/CoreLocation.h>
#import "CLLSheetView.h"
#import "CLLAlertView.h"
#import "CLLCommonDefinition.h"

@interface CLLAlbumHelper()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/**拍摄*/
@property (nonatomic, copy) NSString *albumTakePhoto;
/**从相册选择*/
@property (nonatomic, copy) NSString *albumChoosePhoto;
/**item数组*/
@property (nonatomic,strong) NSArray *optionArray;
/**单选图片回调*/
@property (nonatomic, copy) ChoseImageBlcok block;
/**最大数量*/
@property (nonatomic, assign) NSInteger maxCount;

@end

@implementation CLLAlbumHelper

#pragma mark - 判断是否有相机功能
+ (BOOL)isCameraAvailable {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [[CLLAlertView alertWithTitle:nil content:@"您当前的设备没有摄像头，不能使用相机拍摄。" leftTitle:@"我知道了" leftAction:nil rightTitle:nil rightAction:nil] show];
        return NO;
    }
    return YES;
}

#pragma mark ----------------------------- 公用方法 ------------------------------
- (instancetype)init {
    self = [super init];
    if (self) {
        _isFrontCamera = NO;
        _allowsEditingForCamera = NO;
        _allowsEditingForPhoto = NO;
        _albumTakePhoto = @"相册";
        _albumChoosePhoto = @"相机";
    }
    return self;
}

- (void)show {
    self.optionArray = @[_albumChoosePhoto,_albumTakePhoto];
    [self showSheet];
}

- (void)showOnlyTakePhoto {
    if (![CLLAlbumHelper isCameraAvailable]) return;
    __weak typeof(self) weakSelf = self;
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                [weakSelf systemCamera];
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[CLLAlertView alertWithTitle:nil content:@"为了使用系统相机拍摄，请开启相机权限" leftTitle:@"取消" leftAction:nil rightTitle:@"去开启" rightAction:^(CLLAlertView * _Nonnull alert) {
                        [weakSelf openAuthority];
                    }] show];
                });
            }
        });
    }];
}

- (void)showOnlyChoosePhoto {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    [weakSelf systemLibary];
                } else {
                    [[CLLAlertView alertWithTitle:nil content:@"为了上传照片，请开启相册权限" leftTitle:@"取消" leftAction:nil rightTitle:@"去开启" rightAction:^(CLLAlertView * _Nonnull alert) {
                        [weakSelf openAuthority];
                    }] show];
                }
            }];
        } else {
            ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
            if (status == ALAuthorizationStatusDenied || status == ALAuthorizationStatusRestricted) {
                [[CLLAlertView alertWithTitle:nil content:@"为了上传照片，请开启相册权限" leftTitle:@"取消" leftAction:nil rightTitle:@"去开启" rightAction:^(CLLAlertView * _Nonnull alert) {                        [weakSelf openAuthority];
                }] show];
                return;
            }
            [weakSelf systemLibary];
        }
    });
}

- (void)openAuthority {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        
    }
}

- (void)bindChoseImageBlcok:(nullable ChoseImageBlcok)block {
    _block = [block copy];
}

#pragma mark ----------------------------- 显示选择框 ------------------------------
- (void)showSheet {
    [[CLLSheetView sheetWithTitle:nil textArray:self.optionArray selectedText:nil selectedBlock:^(CLLSheetView * _Nonnull sheet) {
        [sheet diss];
        [self sheetWithIndex:sheet.selectedIndex];
    }] show];
}

- (void)sheetWithIndex:(NSInteger)index {
    if (index > self.optionArray.count - 1 || index < 0) {
        return;
    }
    NSString *option = [self.optionArray objectAtIndex:index];
    if ([option isEqualToString:self.albumChoosePhoto]) { // 相册
        [self showOnlyChoosePhoto];
    } else if ([option isEqualToString:self.albumTakePhoto]) { // 相机
        [self showOnlyTakePhoto];
    } else {
        // 未用
    }
}

- (UIViewController *)currentController {
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (true) {
        if ([vc isKindOfClass:UITabBarController.class]) {
            vc = [(UITabBarController *)vc selectedViewController];
        } else if ([vc isKindOfClass:UINavigationController.class]) {
            vc = [(UINavigationController *)vc visibleViewController];
        } else if (vc.presentedViewController != nil) {
            vc =  vc.presentedViewController;
        } else {
            return vc;
        }
    }
    return vc;
}

#pragma mark ----------------------------- 照片和拍照 ------------------------------
#pragma mark - 系统相册
- (void)systemLibary {
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    UIImagePickerController *imagepickerController = [[UIImagePickerController alloc] init];
    imagepickerController.delegate = self;
    imagepickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagepickerController.mediaTypes = @[mediaTypes.firstObject];
    imagepickerController.allowsEditing = _allowsEditingForPhoto;
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self currentController] presentViewController:imagepickerController animated:YES completion:nil];
    });
}

#pragma mark - 系统相机
- (void)systemCamera {
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    UIImagePickerController *imagepickerController = [[UIImagePickerController alloc] init];
    imagepickerController.delegate = self;
    imagepickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagepickerController.mediaTypes = @[mediaTypes.firstObject];
    imagepickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    imagepickerController.cameraDevice = _isFrontCamera ? UIImagePickerControllerCameraDeviceFront : UIImagePickerControllerCameraDeviceRear;
    imagepickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
    imagepickerController.allowsEditing = _allowsEditingForCamera;
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self currentController] presentViewController:imagepickerController animated:YES completion:nil];
    });
}


#pragma mark ----------------------------- 协议代理 ------------------------------
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[picker.allowsEditing ? UIImagePickerControllerEditedImage : UIImagePickerControllerOriginalImage];
    EXECUTE_BLOCK(self.block, image?image:nil);
    dispatch_async(dispatch_get_main_queue(), ^{
        [picker dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    dispatch_async(dispatch_get_main_queue(), ^{
        [picker dismissViewControllerAnimated:YES completion:nil];
    });
}

#pragma mark - 获取照片
- (void)getImageFromPHAsset:(PHAsset *)asset Complete:(void(^)(UIImage *))complete {
    __block NSData *data;
    if (asset.mediaType == PHAssetMediaTypeImage) {
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        options.synchronous = YES;
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
            data = [NSData dataWithData:imageData];
        }];
    }
    if (complete) {
        if (data.length <= 0) {
            complete(nil);
        } else {
            UIImage *image = [UIImage imageWithData:data];
            complete(image);
        }
    }
}

@end

