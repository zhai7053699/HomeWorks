//
//  ViewController.m
//  Happiness
//
//  Created by 翟永胜 on 2018/4/8.
//  Copyright © 2018年 翟永胜. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"

@interface HappinessViewController () <FaceViewDataSource>

@property (nonatomic,weak) IBOutlet FaceView *faceView;

@end

@implementation HappinessViewController

@synthesize happiness = _happiness;
@synthesize faceView = _faceView;

- (float) smileForFaceView:(FaceView*) sender {
    
    return (self.happiness - 50.0) / 50.0; // 50 和 50.0 区别很大，直接影响到显示效果
    
}

- (void) setHappiness:(int) happiness {
    _happiness = happiness;
    [self.faceView setNeedsDisplay]; // draw rect
}

// property faceView的set方法
- (void) setFaceView:(FaceView *)faceView {
    _faceView = faceView;
    // 注册缩放大小回调函数
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)]];
    // 注册手势识别 滑动
    [self.faceView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHappinessGesture:)]];

    // 定义自己的协议
    self.faceView.dataSource = self;
}

- (void) handleHappinessGesture:(UIPanGestureRecognizer*) gesture {
    if (gesture.state == UIGestureRecognizerStateChanged ||
        gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint translation = [gesture translationInView:self.faceView];
        self.happiness -= translation.y ;
        [gesture setTranslation:CGPointZero inView:self.faceView];
    }
}

// 是否允许屏幕翻转，已经废掉的函数。手机可以直接翻转
//- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
//    return YES;
//}

@end





















