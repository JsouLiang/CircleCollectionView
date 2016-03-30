//
//  ImageCollectionViewCell.m
//  CircleCollectionView
//
//  Created by X-Liang on 16/3/29.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import "CircleCollectionViewLayoutAttributes.h"

@interface ImageCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageCollectionViewCell

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.imageView.image = [UIImage imageNamed:_imageName];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    CircleCollectionViewLayoutAttributes *circleCollectionViewLayoutAttributes = (CircleCollectionViewLayoutAttributes *)layoutAttributes;
    self.layer.anchorPoint = circleCollectionViewLayoutAttributes.anchorPoint;
    CGPoint center = self.center;
    center.y += (circleCollectionViewLayoutAttributes.anchorPoint.y - 0.5) * CGRectGetHeight(self.bounds);
    self.center = center;
}

@end
