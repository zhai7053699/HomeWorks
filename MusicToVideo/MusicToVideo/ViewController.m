//
//  ViewController.m
//  MusicToVideo
//
//  Created by 翟永胜 on 2018/4/1.
//  Copyright © 2018年 翟永胜. All rights reserved.
//

#import "ViewController.h"
#import "AddVideo.h"
#import "CommonHeader.h"

@interface ViewController ()
{
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    // Do any additional setup after loading the view, typically from a nib.
    // 申请麦克风权限
//    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
//    }];
    ///申请拍照权限
//    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
//    }];
    ///申请相册权限
//    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//    }];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"选取视频" forState:UIControlStateNormal];
//    [button.titleLabel sizeToFit];
//    [button addTarget:self action:@selector(addWater) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    button.frame = CGRectMake(SCREEN_WIDTH*0.5-50, 100, 100, 50);
//    [button setBackgroundColor:[UIColor orangeColor]];
    
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button2 setTitle:@"添加音乐" forState:UIControlStateNormal];
//    [button2 sizeToFit];
//    [button2 addTarget:self action:@selector(cropWater) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button2];
//    button2.frame = CGRectMake(SCREEN_WIDTH*0.5-50, 200, 100, 50);
//    [button2 setBackgroundColor:[UIColor orangeColor]];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"视频添加背景音乐" forState:UIControlStateNormal];
    [button3 sizeToFit];
    [button3 addTarget:self action:@selector(addVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    button3.frame = CGRectMake(SCREEN_WIDTH*0.5-100, 300, 200, 50);
    [button3 setBackgroundColor:[UIColor orangeColor]];
    
}

- (void) addWater {
//    [SVProgressHUD showInfoWithStatus:@"你好啊，什么情况"];

}

- (void) cropWater {
    [SVProgressHUD showInfoWithStatus:@"不能选取音乐"];
}

- (void) addVideo {
    AddVideo *addVideo = [[AddVideo alloc] init];
    [self presentViewController:addVideo animated:NO completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
