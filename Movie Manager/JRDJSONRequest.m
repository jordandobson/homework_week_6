//
//  JRDJSONRequest.m
//  Movie Manager
//
//  Created by Jordan Dobson on 8/24/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDJSONRequest.h"

@interface JRDJSONRequest ()
    @property (strong, nonatomic) NSURL           *jsonUrl;
    @property (strong, nonatomic) NSMutableData   *receivedData;
    @property (strong, nonatomic) NSMutableString *searchTerm;
    @property (strong, nonatomic) NSURLRequest    *theRequest;
@end

@implementation JRDJSONRequest

static NSString *requestUrl = @"http://api.rottentomatoes.com/api/public/v1.0/movies.json?";
static NSString *requestKey = @"";

+(instancetype)JSONDataWithQueryString:(NSString *)string {
    JRDJSONRequest *rq = [JRDJSONRequest new];
    rq.searchTerm = string.copy;
    return rq;
}

-(id)sendRequest {
    NSLog(@"send Request");
    return [self startSynchronousDownload: self];
}

-(NSString *)getSearchTerm
{

    NSString *unescaped = [self.searchTerm stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
    return unescaped;
}

-(void)updateSearchTerm:(NSString *)term {
    // Do some URL Escaping
    self.searchTerm = term.copy;
}

-(id)apiURL
{
    NSString *urlForJson = [[NSString new] stringByAppendingFormat:(@"%@q=%@&apikey=%@"), requestUrl, self.searchTerm, requestKey];

    NSLog(@"Requesting JSON @ %@", urlForJson);

    self.jsonUrl    = [NSURL URLWithString:urlForJson];
    self.theRequest = [NSURLRequest requestWithURL: self.jsonUrl];

    return self.theRequest;
}

-(id)startSynchronousDownload:(id)sender {
    
    NSString *urlForJson = [[NSString new] stringByAppendingFormat:(@"%@q=%@&apikey=%@"), requestUrl, self.searchTerm, requestKey];

    NSLog(@"Requesting JSON @ %@", urlForJson);

    self.jsonUrl      = [NSURL URLWithString:urlForJson];
    self.theRequest   = [NSURLRequest requestWithURL: self.jsonUrl];

    NSURLResponse *theResponse = nil;
    NSError       *theError    = nil;

    // should make this asynchronous if want a responsive table

    NSData * jsonData = [NSURLConnection sendSynchronousRequest: self.theRequest
                                              returningResponse: &theResponse
                                                          error: &theError];
    if (!jsonData){ NSLog(@"Error: %@", theError); }
    NSLog(@"!!! Response Successful !!!");

    id theJson = [NSJSONSerialization JSONObjectWithData: jsonData options: 0 error: nil];

    return theJson;
}



@end