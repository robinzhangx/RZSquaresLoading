//
//  RZSquaresLoading.m
//  SquaresLoading
//
//  Created by robin on 1/29/14.
//  Copyright (c) 2014 SquaresLoading. All rights reserved.
//

#import "RZSquaresLoading.h"

@implementation RZSquaresLoading {
        float _squareSize;
        float _gapSize;
        float _moveTime;
        float _squareStartX;
        float _squareStartY;
        float _squareStartOpacity;
        float _squareEndX;
        float _squareEndY;
        float _squareEndOpacity;
        float _squareOffsetX[9];
        float _squareOffsetY[9];
        float _squareOpacity[9];
        NSMutableArray *_squares;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonSetup:MIN(frame.size.width, frame.size.height)];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonSetup:MIN(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    }
    return self;
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    for (CALayer *layer in _squares) {
        layer.backgroundColor = color.CGColor;
    }
}

- (void)commonSetup:(float)size
{
    float gap = 0.04;
    _gapSize = size * gap;
    _squareSize = size * (1.0 - 2 * gap) / 3;
    _moveTime = 0.15;
    _squares = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            float offsetX, offsetY;
            int idx = 3 * i + j;
            if (i == 1) {
                offsetX = _squareSize * (2 - j) + _gapSize * (2 - j);
                offsetY = _squareSize * i + _gapSize * i;
            } else {
                offsetX = _squareSize * j + _gapSize * j;
                offsetY = _squareSize * i + _gapSize * i;
            }
            _squareOffsetX[idx] = offsetX;
            _squareOffsetY[idx] = offsetY;
            _squareOpacity[idx] = 0.1 * (idx + 1);
        }
    }
    _squareStartX = _squareOffsetX[0];
    _squareStartY = _squareOffsetY[0] -  2 * _squareSize - 2 * _gapSize;
    _squareStartOpacity = 0.0;
    _squareEndX = _squareOffsetX[8];
    _squareEndY = _squareOffsetY[8] + 2 * _squareSize + 2 * _gapSize;
    _squareEndOpacity = 0.0;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
        _color = [UIColor blackColor];
    else
        _color = self.tintColor;
    
    for (int i = -1; i < 9; i++) {
        [self addSquareAnimation:i];
    }
}

- (void)addSquareAnimation:(int)position
{
    
    CALayer *square = [CALayer layer];
    if (position == -1) {
        square.frame = CGRectMake(_squareStartX, _squareStartY, _squareSize, _squareSize);
        square.opacity = _squareStartOpacity;
    } else {
        square.frame = CGRectMake(_squareOffsetX[position], _squareOffsetY[position], _squareSize, _squareSize);
        square.opacity = _squareOpacity[position];
    }
    square.backgroundColor = self.color.CGColor;
    [_squares addObject:square];
    [self.layer addSublayer:square];
    
    NSMutableArray *keyTimes = [[NSMutableArray alloc] init];
    NSMutableArray *alphas = [[NSMutableArray alloc] init];
    [keyTimes addObject:@(0.0)];
    if (position == -1) {
        [alphas addObject:@(0.0)];
    } else {
        [alphas addObject:@(_squareOpacity[position])];
    }
    if (position == 0)
        square.opacity = 0.0;
    
    CGPoint sp = square.position;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, sp.x, sp.y);
    
    float x, y, a;
    if (position == -1) {
        x = _squareOffsetX[0] - _squareStartX;
        y = _squareOffsetY[0] - _squareStartY;
        a = _squareOpacity[0];
    } else if (position == 8) {
        x = _squareEndX - _squareOffsetX[position];
        y = _squareEndY - _squareOffsetY[position];
        a = _squareEndOpacity;
    } else {
        x = _squareOffsetX[position + 1] - _squareOffsetX[position];
        y = _squareOffsetY[position + 1] - _squareOffsetY[position];
        a = _squareOpacity[position + 1];
    }
    CGPathAddLineToPoint(path, NULL, sp.x + x, sp.y + y);
    [keyTimes addObject:@(1.0 / 8.0)];
    [alphas addObject:@(a)];
    
    CGPathAddLineToPoint(path, NULL, sp.x + x, sp.y + y);
    [keyTimes addObject:@(1.0)];
    [alphas addObject:@(a)];
    
    CAKeyframeAnimation *posAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    posAnim.removedOnCompletion = NO;
    posAnim.duration = _moveTime * 8;
    posAnim.path = path;
    posAnim.keyTimes = keyTimes;
    
    CAKeyframeAnimation *alphaAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    alphaAnim.removedOnCompletion = NO;
    alphaAnim.duration = _moveTime * 8;
    alphaAnim.values = alphas;
    alphaAnim.keyTimes = keyTimes;
    
    CAKeyframeAnimation *blankAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    blankAnim.removedOnCompletion = NO;
    blankAnim.beginTime = _moveTime * 8;
    blankAnim.duration = _moveTime;
    blankAnim.values = @[@(0.0), @(0.0)];
    blankAnim.keyTimes = @[@(0.0), @(1.0)];
    
    float beginTime;
    if (position == -1)
        beginTime = 0;
    else
        beginTime = _moveTime * (8 - position);
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[posAnim, alphaAnim, blankAnim];
    group.beginTime = CACurrentMediaTime() + beginTime;
    group.repeatCount = HUGE_VALF;
    group.removedOnCompletion = NO;
    group.delegate = self;
    group.duration = 9 * _moveTime;
    
    [square addAnimation:group forKey:[NSString stringWithFormat:@"square-%d", position]];
}

@end
