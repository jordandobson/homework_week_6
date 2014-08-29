//
//  JRDMovieParser.h
//  Movie Manager
//
//  Created by Jordan Dobson on 8/24/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRDMovieParser : NSObject
+(NSString *)stringFromResponse:    (NSJSONSerialization *)response;
+(NSArray  *)movieArrayFromResponse:(NSJSONSerialization *)response;
@end
