//
//  JRDListViewController.m
//  Movie Manager
//
//  Created by Jordan Dobson on 8/23/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDListViewController.h"
#import "JRDJSONRequest.h"
#import "JRDMovieParser.h"
#import "JRDMovie.h"

@interface JRDListViewController () <NSTableViewDataSource, NSTableViewDelegate>
    @property (strong) IBOutlet   NSProgressIndicator *theSpinner;
    @property (strong) IBOutlet   NSTableView         *movieTable;
    @property (strong, nonatomic) JRDJSONRequest      *jsonRequest;
    @property (strong, nonatomic) NSArray             *movieList;
    @property (strong, nonatomic) NSOperationQueue    *viewQueue;
@end

@implementation JRDListViewController

- (id)init
{
    self = [super initWithNibName:NSStringFromClass(self.class) bundle:nil];
    if (self) {
        NSLog(@"List View Initialized");
        self.jsonRequest = [JRDJSONRequest JSONDataWithQueryString:@""];
        self.movieList = nil;
        self.viewQueue = [NSOperationQueue new];
        self.viewQueue.maxConcurrentOperationCount = 1;
    }

    return self;
}

-(void) workOnMovieSearchTerm:(NSString *)term {

    [self clearTable];

    if([term isEqual: @""]){ return; }

    [self.viewQueue addOperationWithBlock:^{

        [self startSpinner];
        [self.jsonRequest updateSearchTerm: term];

        NSArray *movies = [JRDMovieParser movieArrayFromResponse: [self.jsonRequest sendRequest]];

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self reloadTableWithArray: movies];
            [self stopSpinner];
        }];
    }];
}

-(void)reloadTableWithArray:(NSArray *)movies
{
    self.movieList = movies.copy;
    [self.movieTable reloadData];
}

-(void)clearTable{
    self.movieList = nil;
    [self.movieTable reloadData];
}

-(void)startSpinner{
    self.theSpinner.hidden = NO;
    [self.theSpinner startAnimation:self];
}
-(void)stopSpinner{
    [self.theSpinner stopAnimation:self];
    self.theSpinner.hidden = YES;
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.movieList.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *cell = [tableView makeViewWithIdentifier:@"movieCell" owner:self];
    JRDMovie *movie = self.movieList[row];
    NSLog(@"%@", movie.movTitle);
    cell.textField.stringValue = movie.movTitle;
    cell.imageView.image = [[NSImage alloc] initWithContentsOfURL:movie.movImage];
    return cell;
}

@end
