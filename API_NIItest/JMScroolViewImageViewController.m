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

@interface JMScroolViewImageViewController ()

@property (strong, nonatomic) NSMutableArray *myDataArray;
@property (strong, nonatomic) UIImageView* myImage;

@end

@implementation JMScroolViewImageViewController

- (void) loadView {
    [super loadView];
    
    /*
    
    NSURLRequest *request = [NSURLRequest requestWithURL:myDataArray[0].imageUrl];
    
    UIImageView* imageView = [[UIImageView alloc] init];
    
    [imageView setImageWithURLRequest:request
                     placeholderImage:nil
                              success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                  
                                  weakCell.imageView.image = image;
                                  
                              }
                              failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                  
                              }];
    */
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScroolViewWithImgeView];
}


#pragma mark - Scroll Methods

- (void) setupScroolViewWithImgeView {
    
    /*
     [self.myDataArray addObjectsFromArray:[[JMServerManager sharedManager] data]];
     
     self.view.backgroundColor = [UIColor clearColor];
     CGRect frame = UIScreen.mainScreen.bounds;
     self.myImage = [[UIImageView alloc] initWithFrame:frame];
     
     NSURL* url = ((JMResponseObject*)self.myDataArray[0]).imageUrl;
     NSData *data = [[NSData alloc] initWithContentsOfURL:url];
     UIImage* image = [[UIImage alloc] initWithData:data];
     self.myImage = [[UIImageView alloc] initWithImage:image];
     
     
     [self.view addSubview:self.myImage];
     */
    
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
