//
//  JRDJsonViewController.m
//  Movie Manager
//
//  Created by Jordan Dobson on 8/23/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDJsonViewController.h"
#import "JRDJSONRequest.h"
#import "JRDMovieParser.h"



@interface JRDJsonViewController ()
    @property (strong, nonatomic) JRDJSONRequest          *jsonRequest;
    @property (strong, nonatomic) NSJSONSerialization     *jsonData;
    @property (strong, nonatomic) NSMutableParagraphStyle *paragraphStyle;
    @property (strong, nonatomic) NSDictionary            *typeAttributes;
    @property (strong) IBOutlet   NSProgressIndicator     *theSpinner;

    @property (unsafe_unretained) IBOutlet NSTextView     *jsonOutput;

@end

@implementation JRDJsonViewController

NSString * const defaultTextOutput = @"\n\nEnter a movie title above for a JSON response.";

- (id)init
{
    self = [super initWithNibName:NSStringFromClass(self.class) bundle:nil];
    if (self) {
        // Initialization code here.
        self.jsonRequest = [JRDJSONRequest JSONDataWithQueryString:@""];
        self.paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    }
    return self;
}

-(void)awakeFromNib{

    self.paragraphStyle.HeadIndent = 20;
    self.paragraphStyle.firstLineHeadIndent = 20;
    self.paragraphStyle.TailIndent = -20;
    self.paragraphStyle.lineSpacing = 0;

    [self setTextColorToGray];

    self.jsonOutput.typingAttributes = self.typeAttributes;
    self.jsonOutput.string = defaultTextOutput;
}

-(void)clearTextView {
    [self setTextColorToGray];
    self.jsonOutput.string = defaultTextOutput;
}

-(void)setTextColorToBlack
{
    self.paragraphStyle.alignment = NSLeftTextAlignment;
    self.typeAttributes = @{
      NSForegroundColorAttributeName: [NSColor blackColor],
      NSFontAttributeName: [NSFont fontWithName:@"Avenir Light" size:14.0],
      NSParagraphStyleAttributeName: self.paragraphStyle,
    };
    self.jsonOutput.typingAttributes = self.typeAttributes;
}

-(void)setTextColorToGray
{
    self.paragraphStyle.alignment = NSCenterTextAlignment;
    self.typeAttributes = @{
      NSForegroundColorAttributeName: [NSColor grayColor],
      NSFontAttributeName: [NSFont fontWithName:@"Avenir Next Medium" size:11.0],
      NSParagraphStyleAttributeName: self.paragraphStyle,
    };
    self.jsonOutput.typingAttributes = self.typeAttributes;
}

-(void) workOnMovieSearchTerm:(NSString*)term {

    self.jsonOutput.string = @"";
    [self setTextColorToBlack];

    if([term  isEqual: @""]){ return [self clearTextView]; }

    // Start Spinner
    self.theSpinner.hidden = NO;
    [self.theSpinner startAnimation:self];

    // Update Term on Request
    [self.jsonRequest updateSearchTerm: term];

    [NSURLConnection sendAsynchronousRequest: self.jsonRequest.apiURL queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *resp, NSData *dat, NSError *err) {
        if(err){ NSLog(@"%@", err.localizedDescription); }
        NSLog(@"Asynchronous Request Complete");

        id Json = [NSJSONSerialization JSONObjectWithData: dat options: 0 error: nil];
        // NSLog(@"%@", Json);

        NSString *response = [@"\nJSON Results for: " stringByAppendingFormat:@"%@\n\n%@\n", [self.jsonRequest getSearchTerm],[JRDMovieParser stringFromResponse: Json]];
        self.jsonOutput.string = response;

        // Stop Spinner
        [self.theSpinner stopAnimation:self];
        self.theSpinner.hidden = YES;
    }];
}

@end