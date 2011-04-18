//
//  HTMLExport.m
//  DiaryApp
//
//  Created by David Evans on Sat Sep 20 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "HTMLExport.h"


@implementation HTMLExport
- (IBAction) showWindow:(id)sender
{
    [exportPanel makeKeyAndOrderFront:self];

}


- (IBAction) exportIt:(id)sender
{
  NSMutableString * outputString;
  NSMutableString * outputFile;
  
  int i = 0;
  
NSString * styleString = @"<style type=\"text/css\" media=\"screen\">\n<!--\nbody\n{\npadding: 0;\nmargin: 0;\nbackground-color: #666;\ncolor: #000;\n}\n\n#contents\n{\nmargin-top: 10px;\nmargin-bottom: 10px;\nmargin-left: 15%;\nmargin-right: 15%;\npadding: 10px;\nbackground-color: #FFF;\ncolor: #000;\n}\n\nh1\n{\ncolor: #333;\nbackground-color: transparent;\nfont-family: Arial, Helvetica, sans-serif;\nfont-size: 20px;\n}\n\np\n{\ncolor: #333;\nbackground-color: transparent;\nfont-family: Arial, Helvetica, sans-serif;\nfont-size: 0.8em;\n}\n\n.code\n{\ncolor: #339;\nbackground-color: transparent;\nfont-family: times, serif;\nfont-size: 0.9em;\npadding-left: 40px;\n}\n -->\n</style></head><body>";

  NSString * beginTitle = @"<h1>";
  NSString * endTitle = @"</h1>";
  NSString * beginEntries = @"<div id=\"contents\">";
  
  NSString * setupString = @"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\n<html lang=\"en\">\n<head>\n<meta http-equiv=\"content-type\" content=\"text/html; charset=iso-8859-1\">\n<title>Diary App</title>";
  NSString * endPage = @"</div></body></html>";
  NSString * endLine = @"<br>";

    NSMutableArray * journalEntries = [NSMutableArray arrayWithContentsOfFile:[@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath]];                  
  outputString = [[NSMutableString alloc] initWithCapacity:[setupString length]];
  [outputString setString:setupString];
  [outputString appendString:styleString];  
  [outputString appendString:beginEntries];
  
   for(i = 0; i < [journalEntries count]; i++)
   {
    NSCalendarDate * entryDate = [NSCalendarDate dateWithString:[[journalEntries objectAtIndex:i] objectForKey:@"Entered"] calendarFormat:@"%m/%d/%y"];
    int len = [[[journalEntries objectAtIndex:i] objectForKey:@"Entry"] length];
    NSMutableString * modEntry = [[NSMutableString alloc] initWithCapacity:len];
    
    [modEntry setString:[[journalEntries objectAtIndex:i] objectForKey:@"Entry"]];
    
    [modEntry replaceOccurrencesOfString:@"\n" withString:@"<br>" options:nil range:NSMakeRange(0, [modEntry length])];
    
    
    [outputString appendString:beginTitle];
    [outputString appendString:[entryDate descriptionWithCalendarFormat:@"%Y/%m/%d"]];
    [outputString appendString:@" - "];
    [outputString appendString:[[journalEntries objectAtIndex:i] objectForKey:@"Chapter"]];
    [outputString appendString:endTitle];
    [outputString appendString:@"<p>"];
    [outputString appendString:modEntry];
    [outputString appendString:@"</p>"];
    } 
    [outputString appendString:endPage];
    outputFile = [[NSMutableString alloc] initWithCapacity:5];
    [outputFile setString:@"~/Desktop/"];
    [outputFile appendString:[fileName stringValue]];
    [outputString writeToFile:[outputFile stringByExpandingTildeInPath] atomically:YES];
    [exportPanel close];

}


- (void) export
{

}

@end
