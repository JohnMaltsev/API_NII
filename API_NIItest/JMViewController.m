//
//  JMViewController.m
//  API_NIItest
//
//  Created by John Maltsev on 07.04.17.
//  Copyright © 2017 JMCorp. All rights reserved.
//

#import "JMViewController.h"
#import "JMServerManager.h"
#import "JMResponseObject.h"
#import "UIImageView+AFNetWorking.h"
#import "JMScroolViewImageViewController.h"

@interface JMViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *myDataArray;

@end

@implementation JMViewController

- (void) loadView {
    [super loadView];
  
    [self initTableView];
  
}

#pragma mark - Initialized TableView

- (void) initTableView {
    
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    
    UITableView *tv = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    tv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tv.delegate = self;
    tv.dataSource = self;
    [self.view addSubview:tv];
    self.tableView = tv;
    
    [[self navigationController] setNavigationBarHidden:NO];
    self.navigationItem.title = @"Настройки";
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                             target:self
                             action:@selector(actionRefresh:)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    
    
    
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc]
             initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                  target:self
                                  action:@selector(actionFilter:)];
    self.navigationItem.leftBarButtonItem = filterButton;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myDataArray = [NSMutableArray array];
    
    [self getInfoFromServer];
    
}

#pragma mark - Actions

- (void) actionRefresh:(UIBarButtonItem *) sender {
    NSLog(@"refresh");
    
    //отсортировал
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"id" ascending:YES];
//    
//    [self.myDataArray sortUsingDescriptors:@[sortDescriptor]];
    
    
    [self.tableView reloadData];

}
- (void) actionFilter:(UIBarButtonItem *) sender {
    
    NSLog(@"filter");
    
}

#pragma mark - API

- (void) getInfoFromServer {
    
    [[JMServerManager sharedManager]
     
     getDataFromServerOnSuccess:^(NSArray *data) {
         
         [self.myDataArray addObjectsFromArray:data];
         
         [self.tableView reloadData];
     }
     onFailure:^(NSError *error) {
         
         NSLog(@"error = %@", [error localizedDescription]);
         
     }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.myDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
     cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
     
    }
    
    JMResponseObject *dataDict = [self.myDataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", dataDict.idObj,dataDict.titleObj];
    
    //[cell.imageView setImageWithURL:dataDict.imageUrl]; можно и так было загрузить картинки
    
    NSURLRequest *request = [NSURLRequest requestWithURL:dataDict.imageUrl];
    
    __weak UITableViewCell *weakCell = cell;
    
    
    [cell.imageView setImageWithURLRequest:request
                          placeholderImage:nil
                                   success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                       
                                       weakCell.imageView.image = image;
                                       [weakCell layoutSubviews];//перерисовывает subView
                                       
                                   }
                                   failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                       
                                   }];
    
    return cell;
}

#pragma mark - ShowNewVC 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JMScroolViewImageViewController *newVC = [[JMScroolViewImageViewController alloc]init];
    
    NSString* text = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    
    UIImage* image = [[[tableView cellForRowAtIndexPath:indexPath] imageView] image];
    
    [newVC updateImage:image];
    
    [newVC setTitle:text];
    
    [self.navigationController pushViewController:newVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
