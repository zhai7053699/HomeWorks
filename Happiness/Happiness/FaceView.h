//
//  FaceView.h
//  Happiness
//
//  Created by 翟永胜 on 2018/4/8.
//  Copyright © 2018年 翟永胜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaceView : UIView

@property (nonatomic) CGFloat scale; // 公有属性，改变脸的大小

- (void) pinch:(UIPinchGestureRecognizer*) gesture;

@end
