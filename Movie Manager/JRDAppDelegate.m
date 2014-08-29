//
//  JRDAppDelegate.m
//  Movie Manager
//
//  Created by Jordan Dobson on 8/23/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDAppDelegate.h"
#import "JRDMainWindowController.h"

@interface JRDAppDelegate ()
@property (strong, nonatomic) JRDMainWindowController *mainWindowController;
@end

@implementation JRDAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"YOU NEED A ROTTEN TOMATOES API KEY in JRDJSONRequest.m file");
    self.mainWindowController = [JRDMainWindowController new];
    [self.mainWindowController showWindow:self];
}
- (IBAction)searchJurrasicPark:(id)sender {
    [self.mainWindowController populateSearch:@"Jurrasic Park"];
}

- (IBAction)searchTempleOfDoom:(id)sender {
    [self.mainWindowController populateSearch:@"Temple Of Doom"];
}
- (IBAction)searchInception:(id)sender {
    [self.mainWindowController populateSearch:@"Goon"];
}

@end
