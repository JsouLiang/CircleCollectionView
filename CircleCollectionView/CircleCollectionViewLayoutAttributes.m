//
//  CircleCollectionViewLayoutAttributes.m
//  CircleCollectionView
//
//  Created by X-Liang on 16/3/29.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "CircleCollectionViewLayoutAttributes.h"

@implementation CircleCollectionViewLayoutAttributes

- (instancetype)init {
    if (self = [super init]) {
        self.anchorPoint = CGPointMake(0.5, 0.5);
        self.angle = 0;
    }
    return self;
}

- (void)setAngle:(CGFloat)angle {
    _angle = angle;
    self.zIndex = angle * 1000000;
    self.transform = CGAffineTransformMakeRotation(angle);
}

- (id)copyWithZone:(NSZone *)zone {
    CircleCollectionViewLayoutAttributes *copyAttributes = (CircleCollectionViewLayoutAttributes *)[super copyWithZone:zone];
    copyAttributes.anchorPoint = self.anchorPoint;
    copyAttributes.angle = self.angle;
    return copyAttributes;
}

@end
