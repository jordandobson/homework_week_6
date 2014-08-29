//
//  JRDJSONRequest.h
//  Movie Manager
//
//  Created by Jordan Dobson on 8/24/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRDJSONRequest : NSObject <NSURLConnectionDataDelegate>
    +(instancetype)JSONDataWithQueryString:(NSString *)string;
    -(void)updateSearchTerm:(NSString *)term;
    -(id)sendRequest;
    -(id)apiURL;
@end
