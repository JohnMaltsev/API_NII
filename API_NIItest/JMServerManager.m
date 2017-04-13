//
//  JMServerManager.m
//  API_NIItest
//
//  Created by John Maltsev on 08.04.17.
//  Copyright © 2017 JMCorp. All rights reserved.
//

#import "JMServerManager.h"
#import "AFNetworking.h"
#import "JMResponseObject.h"

@interface JMServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager *requestOperationManager;
@property (strong, nonatomic) NSURL *url;

@end

@implementation JMServerManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
       self.url = [NSURL URLWithString:@"http://private-db05-jsontest111.apiary-mock.com/androids"];
        
        self.requestOperationManager = [[AFHTTPSessionManager alloc]initWithBaseURL:self.url];
    }
    return self;
}

//создал сингл тон
+ (JMServerManager*) sharedManager {
    
    static JMServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [JMServerManager new];
    });
    
    return manager;
}

- (void) getDataFromServerOnSuccess:(void(^)(NSArray *data)) success
                         onFailure:(void(^)(NSError *error)) failure {
    
    [self.requestOperationManager
     GET:@"http://private-db05-jsontest111.apiary-mock.com/androids"
     parameters:nil
     progress:nil
     success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
//         self.data = [NSMutableArray array];
         
         NSArray *dictArray = (NSArray*) responseObject;
         
         NSMutableArray *objectsArray = [NSMutableArray array];
         
         for (NSDictionary *dict in dictArray) {
             
             JMResponseObject *resObj = [[JMResponseObject alloc]initWithSerwerResponse:dict];
             
             [objectsArray addObject:resObj]; 
         }
         
         [self.data addObjectsFromArray:objectsArray];
         if (success) {
             success(objectsArray);
         }
         
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
      
     }];
   
}


//lazy initialization
- (NSMutableArray *)data {
    
    if (!_data) {
        _data = [NSMutableArray new];
    }
    return _data;
}






@end
