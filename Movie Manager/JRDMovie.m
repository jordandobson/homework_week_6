//
//  JRDMovie.m
//  Movie Manager
//
//  Created by Jordan Dobson on 8/25/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDMovie.h"

@implementation JRDMovie
-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ (%@)", self.movTitle, self.movImage];
}

-(NSString *)debugDescription
{
    return [NSString stringWithFormat:@"<Movie %@ #%@>", self.movTitle, self.movImage];
}

@end
