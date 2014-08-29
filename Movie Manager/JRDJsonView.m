//
//  JRDJsonView.m
//  Movie Manager
//
//  Created by Jordan Dobson on 8/23/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDJsonView.h"

@implementation JRDJsonView

- (void)drawRect:(NSRect)dirtyRect
{
        NSLog(@"JSONView");
    [super drawRect:dirtyRect];
    [[NSColor whiteColor] set];
    [NSBezierPath fillRect: dirtyRect];
    
    // Drawing code here.
}

@end
