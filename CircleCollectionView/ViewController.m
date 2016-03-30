//
//  ViewController.m
//  CircleCollectionView
//
//  Created by X-Liang on 16/3/29.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *images;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.imageName = self.images[indexPath.row];
    cell.titleLabel.text = [NSString stringWithFormat:@"%d",indexPath.item];
    return cell;
}

- (NSArray *)images {
    if (!_images) {
        NSLog(@"%@",[NSBundle mainBundle]);
        _images = [[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"Images"];
    }
    return _images;
}

@end
