//
//  ViewController.m
//  Happiness
//
//  Created by 翟永胜 on 2018/4/8.
//  Copyright © 2018年 翟永胜. All rights reserved.
//

#import "ViewController.h"
#import "FaceView.h"

@interface ViewController ()

@property (nonatomic,weak) IBOutlet FaceView *faceView;

@end

@implementation ViewController

@synthesize happiness = _happiness;
@synthesize faceView = _faceView;

- (void) setHappiness:(int) happiness {
    _happiness = happiness;
    [self.faceView setNeedsDisplay]; // draw rect
}

- (void) setFaceView:(FaceView *)faceView {
    _faceView = faceView;
    // 注册缩放大小回调函数
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)]];
}

// 是否允许屏幕翻转，已经废掉的函数。手机可以直接翻转
//- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
//    return YES;
//}

@end
