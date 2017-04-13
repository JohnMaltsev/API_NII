//
//  JMScroolViewImageViewController.m
//  API_NIItest
//
//  Created by Denis on 09/04/2017.
//  Copyright © 2017 JMCorp. All rights reserved.
//

#import "JMScroolViewImageViewController.h"
#import "JMServerManager.h"
#import "JMResponseObject.h"

@interface JMScroolViewImageViewController () <UICollectionViewDataSource, UICollectionViewDelegate >

@property (strong, nonatomic) NSMutableArray *myDataArray;
@property (strong, nonatomic) UIImageView* myImage;
@property (strong , nonatomic) UICollectionView *collectionView;

@end

@implementation JMScroolViewImageViewController

- (void) loadView {
    [super loadView];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [self setupScroolViewWithImgeView];
    
    [self initCollectionView];
    
}
// image title
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"Did scroll");
   
    NSInteger currentIndex = (NSInteger)ceil(scrollView.contentOffset.x / scrollView.frame.size.width);
    
    JMResponseObject* currentData = [JMServerManager sharedManager].data[currentIndex];
    
    self.title = currentData.titleObj;
    
    scrollView.pagingEnabled = YES;
    
}


#pragma mark - initCollectionView

- (void) initCollectionView {
 
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    self.collectionView = [[UICollectionView alloc]
                           initWithFrame:self.view.frame
                           collectionViewLayout:layout];

     layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.dataSource = self;
    [self.collectionView setDelegate:self];
    
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"cellIdentifier"];
    
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"%lu", (unsigned long)[JMServerManager sharedManager].data.count);
    return [JMServerManager sharedManager].data.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    JMResponseObject *currentObject = [JMServerManager sharedManager].data[indexPath.row];
    NSData *data = [[NSData alloc] initWithContentsOfURL:currentObject.imageUrl];
    UIImage *loadedImage = [[UIImage alloc] initWithData:data];
    cell.backgroundView = [[UIImageView alloc] initWithImage:loadedImage];
        
    return cell;
}


/*
#pragma mark - Scroll Methods

- (void) setupScroolViewWithImgeView {
    
   
    
    NSInteger pageCount = 4;
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, 400, 400)];
    scroll.backgroundColor = [UIColor clearColor];
    scroll.pagingEnabled = YES;
    scroll.alwaysBounceVertical = YES;
    scroll.alwaysBounceHorizontal = YES;
    
    scroll.contentSize = CGSizeMake(pageCount * scroll.bounds.size.width, scroll.bounds.size.height);
    
    CGRect viewSize = scroll.bounds;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:viewSize];
    [imageView setImage:[UIImage imageNamed:@"snowflake"]];
    [scroll addSubview:imageView];
    
    //отступ
    viewSize = CGRectOffset(viewSize, scroll.bounds.size.width, 0);
    
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:viewSize];
    [imageView2 setImage:[UIImage imageNamed:@"holly"]];
    [scroll addSubview:imageView2 ];
    
    viewSize = CGRectOffset(viewSize, scroll.bounds.size.width, 0);
    
    UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:viewSize];
    [imageView3 setImage:[UIImage imageNamed:@"snowman"]];
    [scroll addSubview:imageView3 ];
    
    
    viewSize = CGRectOffset(viewSize, scroll.bounds.size.width, 0);
    
    UIImageView *imageView4 = [[UIImageView alloc]initWithFrame:viewSize];
    [imageView4 setImage:[UIImage imageNamed:@"present"]];
    [scroll addSubview:imageView4 ];
    
    [self.view addSubview:scroll];
    
}
*/
-(void) updateTitle: (NSString*) title {
    
    self.title = title;
}


-(void) updateImage: (UIImage*) image {
    
//    self.myImage = [[UIImageView alloc] initWithFrame:frame];
//    self.myImage =  [[UIImageView alloc] initWithImage:image];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
