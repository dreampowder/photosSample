//
//  MainViewController.m
//  SOTO8
//
//  Created by Serdar coskun on 10/10/14.
//  Copyright (c) 2014 Kod.Era. All rights reserved.
//

#import "MainViewController.h"


@interface MainViewController ()

@property (strong) PHFetchResult *assetsFetchResults;
@property (strong) PHAssetCollection *assetCollection;
@property (strong) PHCachingImageManager* imageManager;

@end

@implementation MainViewController

static NSString * const reuseIdentifier = @"Cell";
static CGSize AssetGridThumbnailSize;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageManager = [[PHCachingImageManager alloc] init];
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cellSize = ((UICollectionViewFlowLayout *)self.collectionViewLayout).itemSize;
    AssetGridThumbnailSize = CGSizeMake(cellSize.width * scale, cellSize.height * scale);
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"dateCreated" ascending:YES]];
    self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetsFetchResults.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [self.imageManager requestImageForAsset:self.assetsFetchResults[indexPath.item] 
                                 targetSize:CGSizeMake(20, 20) 
                                contentMode:PHImageContentModeAspectFill 
                                    options:nil resultHandler:^(UIImage *result, NSDictionary* info){
                                        
                                        UIImageView* imgView = (UIImageView*)[cell.contentView viewWithTag:999];
                                        if(!imgView) {
                                            imgView = [[UIImageView alloc] initWithFrame:[cell.contentView bounds]];
                                            imgView.tag = 999;
                                            [cell.contentView addSubview:imgView];
                                        }
                                        imgView.image = result;
                                    }];
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
