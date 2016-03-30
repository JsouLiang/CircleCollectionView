//
//  ImageCollectionViewCell.h
//  CircleCollectionView
//
//  Created by X-Liang on 16/3/29.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, copy) NSString *imageName;
@end
