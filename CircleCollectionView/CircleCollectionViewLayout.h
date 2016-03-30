//
//  CircleCollectionViewLayout.h
//  CircleCollectionView
//
//  Created by X-Liang on 16/3/29.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleCollectionViewLayout : UICollectionViewLayout
/**
 *   半径
 */
@property (nonatomic, assign) CGFloat radius;
/**
 *  大小
 */
@property (nonatomic, assign) CGSize itemSize;
@end
