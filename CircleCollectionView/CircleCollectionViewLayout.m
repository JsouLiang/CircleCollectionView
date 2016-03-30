//
//  CircleCollectionViewLayout.m
//  CircleCollectionView
//
//  Created by X-Liang on 16/3/29.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "CircleCollectionViewLayout.h"
#import "CircleCollectionViewLayoutAttributes.h"

#define ItemWidth 55
#define ItemHieght ItemWidth
#define RightMargin 5

@interface CircleCollectionViewLayout ()
/**
 *  单位夹角
 */
@property (nonatomic, assign) CGFloat anglePerItem;
/**
 *  布局属性数组
 */
@property (nonatomic, copy) NSArray <CircleCollectionViewLayoutAttributes *> *attributesList;
/**
 *  单位偏移角度
 */
@property (nonatomic, assign) CGFloat angle;
/**
 *  总偏移角度
 */
@property (nonatomic, assign) CGFloat angleAtExtreme;
@property (nonatomic, assign) NSInteger startIndex;
@property (nonatomic, assign) NSInteger endIndex;
@end

@implementation CircleCollectionViewLayout

- (instancetype)init {
    if (self = [super init]) {
        [self initial];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initial];
    }
    return self;
}

- (void)initial {
    self.itemSize = CGSizeMake(ItemWidth, ItemHieght);
    self.radius = (CGRectGetWidth([UIScreen mainScreen].bounds))* 0.5f - ItemWidth - RightMargin;
    self.anglePerItem = M_PI_2 / 2;
    self.startIndex = 0;
    self.endIndex = 8;
}

+ (Class)layoutAttributesClass {
    return [CircleCollectionViewLayoutAttributes class];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)collectionViewContentSize {
    NSInteger numberOfItem = [self.collectionView numberOfItemsInSection:0];
//    CGFloat delta = numberOfItem * .5 * sqrt(self.radius) + CGRectGetWidth(self.collectionView.bounds);
//    NSLog(@"%f",delta);
    return CGSizeMake(numberOfItem * ItemWidth , self.collectionView.bounds.size.height);
}

- (void)prepareLayout {
    [super prepareLayout];
    CGFloat centerX = self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.bounds) * .5f;
    NSInteger numberOfItem = [self.collectionView numberOfItemsInSection:0];
    CGFloat anchorPointY =  -(self.radius) / self.itemSize.height;
    
    self.startIndex = 0, self.endIndex = [self.collectionView numberOfItemsInSection:0] - 1;
    
    NSMutableArray *mAttributesList = [NSMutableArray arrayWithCapacity:numberOfItem];
    self.endIndex = self.startIndex + 7;
    for (NSInteger index = self.startIndex; index < self.endIndex; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        CircleCollectionViewLayoutAttributes *attributes = [CircleCollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.size = self.itemSize;
        attributes.center = CGPointMake(centerX, CGRectGetMidY(self.collectionView.bounds) + self.radius);
        attributes.anchorPoint = CGPointMake(0.5, anchorPointY);
        attributes.angle = self.anglePerItem * index + self.angle;
        if (attributes.angle <= -(M_PI * 2) / 3) {
            self.endIndex++;
            CGFloat alpha = (((M_PI * 2) / 3 + M_PI / 8.0) + attributes.angle)/(M_PI/8.0);
            attributes.alpha = alpha;
            
            if (self.endIndex >= numberOfItem) {
                self.endIndex = numberOfItem;
                
            }
        } else if (attributes.angle > (M_PI_2) + M_PI_2 * .5) {
            CGFloat alpha = (M_PI - attributes.angle) / M_PI_4;
            attributes.alpha = alpha;
        }
        [mAttributesList addObject:attributes];
    }
    self.attributesList = [mAttributesList copy];
}

//- (void)prepareLayout {
//    // 调用父类的
//    [super prepareLayout];
//    // x 始终确保在屏幕中间
//    CGFloat centerX = self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.bounds) * .5f;
//    NSInteger numberOfItem = [self.collectionView numberOfItemsInSection:0];
//    CGFloat anchorPointY =  -(self.radius) / self.itemSize.height;
//    
//    NSMutableArray *mAttributesList = [NSMutableArray arrayWithCapacity:numberOfItem];
//    for (NSInteger index = 0; index < numberOfItem; index++) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
//        CircleCollectionViewLayoutAttributes *attributes = [CircleCollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//        attributes.size = self.itemSize;
//        attributes.anchorPoint = CGPointMake(0.5, anchorPointY);
//
//        attributes.center = CGPointMake(centerX, CGRectGetMidY(self.collectionView.bounds) + self.radius);
//        attributes.angle = self.anglePerItem * index +  self.angle;;
//        
//        
//        [mAttributesList addObject:attributes];
//    }
//    self.attributesList = [mAttributesList copy];
//}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesList;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.attributesList[indexPath.row];
}

// // -M_PI_2的原因是使每个 Item向右偏移 90 度角
- (CGFloat)angle {
    return self.angleAtExtreme * self.collectionView.contentOffset.x / ([self collectionViewContentSize].width - CGRectGetWidth(self.collectionView.bounds)) - M_PI_2;
}

- (CGFloat)angleAtExtreme {
    return [self.collectionView numberOfItemsInSection:0] > 0 ?
    -([self.collectionView numberOfItemsInSection:0] - 5) * self.anglePerItem : 0;
}

@end
