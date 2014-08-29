//
//  JRDMainWindowController.m
//  Movie Manager
//
//  Created by Jordan Dobson on 8/23/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDMainWindowController.h"
#import "JRDJsonViewController.h"
#import "JRDListViewController.h"
#import "JRDJSONRequest.h"

@class JRDJsonViewController;
@class JRDListViewController;

@interface JRDMainWindowController () <NSTextFieldDelegate>

    @property (strong, nonatomic) JRDJsonViewController *jsonViewController;
    @property (strong, nonatomic) JRDListViewController *listViewController;

    @property (strong) IBOutlet NSToolbar     *toolbar;
    @property (weak)   IBOutlet NSSearchField *searchFieldInput;

    @property (strong) NSViewController *currentView;

@end

@implementation JRDMainWindowController

- (id)init {
    self = [super initWithWindowNibName:NSStringFromClass(self.class)];
    if (self) { }
    return self;
}

#pragma mark Populate search field and search

-(void)populateSearch:(NSString*)searchString{
    self.searchFieldInput.stringValue = searchString;
    [self performSearchOnEntry];
}

#pragma mark WINDOW CONTROLS & UPDATING

- (void)windowDidLoad {
    NSLog(@"Window Loaded");
    [super windowDidLoad];
    self.searchFieldInput.delegate = self;

    // Set the default view to Show
    [self displayJsonView];
    [self.toolbar setSelectedItemIdentifier: @"json"];
    self.currentView = self.jsonViewController;

    // Put focus on the Search Field
    [self.searchFieldInput selectText: self];
}

-(void)displayViewController:(NSViewController *)vc {
    vc.view.frame            = [self.window.contentView bounds];
    vc.view.autoresizingMask = NSViewHeightSizable | NSViewWidthSizable;

    NSArray *subviews = [self.window.contentView subviews];

    if(subviews.count == 1){
        [self.window.contentView replaceSubview: subviews[0] with: vc.view ];
    }else{
        [self.window.contentView addSubview: vc.view];
    }
    self.currentView = vc;
}

#pragma mark SEARCH ACTIONS

- (IBAction)actionOnSearch:(id)sender { [self performSearchOnEntry]; }

- (void)performSearchOnEntry {
    NSString *term = [self scrub: self.searchFieldInput.stringValue];
    if(term.length >= 2){
        NSString *theTerm = [term stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if(self.currentView == self.jsonViewController){
            [self.jsonViewController workOnMovieSearchTerm:theTerm];
        }else if(self.currentView == self.listViewController){
            [self.listViewController workOnMovieSearchTerm:theTerm];
        }
    }else{
        if(self.currentView == self.jsonViewController){
            [self.jsonViewController workOnMovieSearchTerm:@""];
        }else if(self.currentView == self.listViewController){
            [self.listViewController workOnMovieSearchTerm:@""];
        }
    }
}

#pragma mark TAB ACTIONS

- (IBAction)jsonTabHit:(id)sender { [self displayJsonView]; }

- (IBAction)listTabHit:(id)sender { [self displayListView]; }

#pragma mark DISPLAY VIEW CALL & SETUP

-(void)displayListView {
    if(!self.listViewController){
        self.listViewController = [JRDListViewController new];
    }
    [self displayViewController: self.listViewController];
}

-(void)displayJsonView {
    if(!self.jsonViewController){
        self.jsonViewController = [JRDJsonViewController new];
    }
    [self displayViewController: self.jsonViewController];
}

#pragma mark HELPERS

-(NSString*)scrub:(NSString*)string {
// Remove consecutive whitespaces in the middle of a string
    // http://stackoverflow.com/a/12137128/3920924
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"  +" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *trimmedString = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:@" "];

// Remove whitespace at the beginning and end of a string
    return [trimmedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
