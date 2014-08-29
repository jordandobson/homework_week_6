//
//  JRDListView.m
//  Movie Manager
//
//  Created by Jordan Dobson on 8/24/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDListView.h"

@implementation JRDListView

- (void)drawRect:(NSRect)dirtyRect
{
    NSLog(@"ListView");
    [super drawRect:dirtyRect];
    [[NSColor greenColor] set];
    [NSBezierPath fillRect: dirtyRect];

    // Drawing code here.
}

@end
