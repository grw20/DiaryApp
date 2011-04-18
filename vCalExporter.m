//
//  vCalExporter.m
//  DiaryApp
//
//  Created by David Evans on Sat Sep 21 2002.
//  Copyright (c) 2002 __MyCompanyName__. All rights reserved.
//

#import "vCalExporter.h"


@implementation vCalExporter

- (IBAction) showWindow:(id)sender
{
    [exportPanel makeKeyAndOrderFront:self];
}


- (IBAction) exportIt:(id)sender
{
  NSMutableString * outputString;
  int i = 0;
  NSString * beginEvent = @"BEGIN:VEVENT\n";
  NSString * endEvent = @"END:VEVENT\n";
  NSString * endCalendar = @"END:VCALENDAR\n";
  NSString * durationTag = @"DURATION:PT1\n";
  NSString * dateStamp = @"DTSTAMP:";
  NSString * summaryTag = @"SUMMARY:";
  NSString * descTag = @"DESCRIPTION:";
  NSString * startTag = @"DTSTART;TZID=US/Eastern:";
  NSString * endTag = @"DTEND;TZID=US/Eastern:";
  NSString * times = @"T080000\n";
  NSString *setupString = @"BEGIN:VCALENDAR\nCALSCALE:GREGORIAN\nX-WR-TIMEZONE;VALUE=TEXT:US/Eastern\nPRODID:DIARYAPP-DAVIDEVANS\nX-WR-CALNAME;VALUE=TEXT:DiaryOutput\nX-WR-RELCALID;VALUE=TEXT:D7FAB192-C769-11D6-B95C-0003934EBE7C\nVERSION:2.0\n";
   NSMutableArray * journalEntries = [NSMutableArray arrayWithContentsOfFile:[@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath]];                  
  outputString = [[NSMutableString alloc] initWithCapacity:[setupString length]];
  [outputString setString:setupString];
  
   for(i = 0; i < [journalEntries count]; i++)
   {
    NSCalendarDate * entryDate = [NSCalendarDate dateWithString:[[journalEntries objectAtIndex:i] objectForKey:@"Entered"] calendarFormat:@"%m/%d/%y"];
    int len = [[[journalEntries objectAtIndex:i] objectForKey:@"Entry"] length];
    NSMutableString * modEntry = [[NSMutableString alloc] initWithCapacity:len];
    [modEntry setString:[[journalEntries objectAtIndex:i] objectForKey:@"Entry"]];
    [modEntry replaceOccurrencesOfString:@"\n" withString:@"\\n" options:nil range:NSMakeRange(0, [modEntry length])];
    
    
    [outputString appendString:beginEvent];
    [outputString appendString:dateStamp];
    [outputString appendString:[entryDate descriptionWithCalendarFormat:@"%Y%m%d"]];
    [outputString appendString:times];
    [outputString appendString:summaryTag];
    [outputString appendString:[[journalEntries objectAtIndex:i] objectForKey:@"Chapter"]];
    [outputString appendString:@"\n"];
    [outputString appendString:startTag];
    [outputString appendString:[entryDate descriptionWithCalendarFormat:@"%Y%m%d"]];
    [outputString appendString:times];
    [outputString appendString:endTag];
    [outputString appendString:[entryDate descriptionWithCalendarFormat:@"%Y%m%d"]];
    [outputString appendString:times];
    [outputString appendString:descTag];
    [outputString appendString:modEntry];
    [outputString appendString:@"\n"];
    [outputString appendString:endEvent];
    } 
    [outputString appendString:endCalendar];
    [outputString writeToFile:[@"~/Desktop/DiaryApp.ics" stringByExpandingTildeInPath] atomically:YES];
    [exportPanel close];

}


- (void) export
{

}

@end
