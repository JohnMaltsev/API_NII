//
//  JMResponseObject.m
//  API_NIItest
//
//  Created by John Maltsev on 08.04.17.
//  Copyright © 2017 JMCorp. All rights reserved.
//

#import "JMResponseObject.h"

@implementation JMResponseObject

- (instancetype)initWithSerwerResponse:(NSDictionary*) responseObj {
    
    self = [super init];
    if (self) {
        
        self.idObj = [responseObj objectForKey:@"id"];
        self.titleObj = [responseObj objectForKey:@"title"];
        
        NSString *urlString = [responseObj objectForKey:@"img"];
        
        if (urlString) {
            self.imageUrl = [NSURL URLWithString:urlString];
        }
        
        
    }
    return self;
}

@end
