//
//  JMServerManager.h
//  API_NIItest
//
//  Created by John Maltsev on 08.04.17.
//  Copyright © 2017 JMCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMServerManager : NSObject

@property (strong, nonatomic)  NSMutableArray *data;

+ (JMServerManager*) sharedManager;

- (void)getDataFromServerOnSuccess:(void(^)(NSArray *data)) success
                         onFailure:(void(^)(NSError *error)) failure;

@end
