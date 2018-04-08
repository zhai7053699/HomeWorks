//
//  FaceView.m
//  Happiness
//
//  Created by 翟永胜 on 2018/4/8.
//  Copyright © 2018年 翟永胜. All rights reserved.
//

#import "FaceView.h"

@implementation FaceView
@synthesize scale = _scale;

#define DEFAULT_SCALE 0.9

- (CGFloat) scale {
    if (!_scale) {
        return DEFAULT_SCALE;
    } else
        return _scale;
}

- (void) setScale:(CGFloat)scale {
    if (scale != _scale) {
        _scale = scale;
        [self setNeedsDisplay];
    }
}

- (void) pinch:(UIPinchGestureRecognizer*) gesture {
    if (gesture.state == UIGestureRecognizerStateChanged || gesture.state == UIGestureRecognizerStateEnded)
    {
        self.scale *= gesture.scale;
        gesture.scale = 1;
    }
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup {
    self.contentMode = UIViewContentModeRedraw;
}

- (void) awakeFromNib {
    [self setup];
    [super awakeFromNib];
}

- (void) drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef)context{
    
    UIGraphicsPushContext(context);
    // 在这里进行绘图操作
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, 2*M_PI, YES);
    CGContextStrokePath(context);
    
    UIGraphicsPopContext();
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 代码示例：将逻辑先列出来，防止忘记步骤
    /// draw face (circle)
    // face的中心点
    CGPoint midPoint;
    midPoint.x = self.bounds.origin.x + self.bounds.size.width/2;
    midPoint.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    CGFloat size = self.bounds.size.width / 2.5;
    if (self.bounds.size.height < self.bounds.size.width) size = self.bounds.size.height/2;
    size *= self.scale;
    
    // 设置线条宽度和颜色
    CGContextSetLineWidth(context, 5.0);
    [[UIColor blueColor] setStroke];
    
    [self drawCircleAtPoint:midPoint withRadius:size inContext:context];
    
    /// draw eyes [2 circle]
#define EYE_H 0.35
#define EYE_V 0.35
#define EYE_RADIUS 0.1
    
    CGPoint eyePoint;
    eyePoint.x = midPoint.x - size*EYE_H;
    eyePoint.y = midPoint.y - size*EYE_V;
    
    [self drawCircleAtPoint:eyePoint withRadius:size*EYE_RADIUS inContext:context];
    eyePoint.x += size * EYE_H * 2;
    [self drawCircleAtPoint:eyePoint withRadius:size*EYE_RADIUS inContext:context];
    
    /// no nose
    /// draw mouse
#define MOUTH_H 0.45
#define MOUTH_V 0.40
#define MOUTH_SMILE 0.25
    // 贝塞尔曲线画嘴，两点之间选择控制点，改变曲线大小
    CGPoint mouthStart;
    mouthStart.x = midPoint.x - MOUTH_H*size;
    mouthStart.y = midPoint.y + MOUTH_V*size;
    CGPoint mouthEnd = mouthStart;
    mouthEnd.x  += MOUTH_H * size * 2;
    CGPoint mouthCP1 = mouthStart;
    mouthCP1.x += MOUTH_H * size * 2/3;
    CGPoint mouthCP2 = mouthEnd;
    mouthCP2.x -= MOUTH_H * size * 2/3;
    
    float smile = 1; // 介于1.0-- -1.0
    
    CGFloat smileOffset = MOUTH_SMILE *size * smile;
    mouthCP1.y += smileOffset;
    mouthCP2.y += smileOffset;
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, mouthStart.x, mouthStart.y);
    CGContextAddCurveToPoint(context, mouthCP1.x, mouthCP1.y, mouthCP2.x, mouthCP2.y, mouthEnd.x, mouthEnd.y);
    CGContextStrokePath(context);
}

@end






















