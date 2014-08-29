//
//  JRDMovieParser.m
//  Movie Manager
//
//  Created by Jordan Dobson on 8/24/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDMovieParser.h"
#import "JRDMovie.h"

@implementation JRDMovieParser

+(NSString *)stringFromResponse:(NSJSONSerialization *)response{
    // Via: http://stackoverflow.com/a/9020923/3920924
    NSError *error    = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:response
                                                        options:NSJSONWritingPrettyPrinted
                                                          error:&error];
    // * ^ Pass options:0 if you don't care about the readability of the generated string
    return [[NSString alloc] initWithData: jsonData encoding: NSUTF8StringEncoding];
}

+(NSArray *)movieArrayFromResponse:(NSDictionary *)response {
    NSMutableArray *movies = [NSMutableArray new];

    for(NSDictionary *movieData in response[@"movies"]){
        JRDMovie * movie = [self parseMovie: movieData];
        [movies addObject: movie];
    }
    return movies;
}

+(JRDMovie *)parseMovie:(NSDictionary *)movieData
{
    JRDMovie * movie = [JRDMovie new];
    movie.movTitle   = movieData[@"title"];
    NSString *imgUrl = movieData[@"posters"][@"thumbnail"];
    if(imgUrl){
        movie.movImage = [NSURL URLWithString: imgUrl];
    }
    return movie;
}


@end
