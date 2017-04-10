//
//  JMResponseObject.h
//  API_NIItest
//
//  Created by John Maltsev on 08.04.17.
//  Copyright © 2017 JMCorp. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JMResponseObject : NSObject

@property (strong, nonatomic) NSString *idObj;
@property (strong, nonatomic) NSURL *imageUrl;
@property (strong, nonatomic) NSString *titleObj;

- (instancetype)initWithSerwerResponse:(NSDictionary*) responseObj;

@end
