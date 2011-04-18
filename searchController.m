#import "searchController.h"

@implementation searchController

- (void) awakeFromNib
{
    NSNotificationCenter *notify;
    int i = 0;
    notify =[NSNotificationCenter defaultCenter];
    [notify addObserver:self selector:@selector(handleNotify:) name:@"AddedNewEntry" object:nil];

    journalEntries = [NSMutableArray arrayWithContentsOfFile:[@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath]];
    [journalEntries retain];
    [beginDate removeAllItems];
    [endDate removeAllItems];

    for( i = 0; i < [journalEntries count]; i++)
    {
        NSMutableDictionary * tempDict = [journalEntries objectAtIndex:i];
        [beginDate addItemWithTitle: [tempDict objectForKey:@"Entered"]];
        [endDate addItemWithTitle: [tempDict objectForKey:@"Entered"]];
    }

}

- (void)dealloc
{
    NSNotificationCenter *notify;
    notify =[NSNotificationCenter defaultCenter];
    [notify removeObserver:self];

    [super dealloc];
}


- (void)handleNotify:(NSNotification *)n
{
    journalEntries = [NSMutableArray arrayWithContentsOfFile:[@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath]];
    [journalEntries retain];
}


- (IBAction)performSearch:(id)sender
{
    NSMutableDictionary * tempDict;
    NSRange starter = NSMakeRange(0,0);
    NSString * entryToSearch;
    NSMutableArray * resultStorage = [NSMutableArray array];
    NSString * findString = [searchStringInput stringValue];
    int i=0, a = 0;
    double increment_value = 100;
    journalEntries = [NSMutableArray arrayWithContentsOfFile:[@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath]];
    increment_value = 100/[journalEntries count];
    [searchProgress setIndeterminate:FALSE];
    [searchProgress incrementBy:increment_value];

    for(i = 0; i < [journalEntries count]; i++)
    {
        tempDict = [journalEntries objectAtIndex:i];
        entryToSearch = [tempDict objectForKey:@"Entry"];
        starter = [entryToSearch rangeOfString:findString options:NSCaseInsensitiveSearch];//NSBackwardsSearch
            [searchProgress incrementBy:increment_value];
            for(a = 0; a < 10000; a++);
            if(starter.length > 0)
            {
                [resultStorage insertObject:tempDict atIndex:0];
            }
    }

    if([resultStorage count] > 0)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchComplete" object:resultStorage];
}

- (IBAction)setTypeOfSearch:(id)sender
{
    if(sender == allEntriesRadio) search_all = TRUE;
    else
    {
        int i;
        journalEntries = [NSMutableArray arrayWithContentsOfFile:[@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath]];
        [journalEntries retain];
        [beginDate removeAllItems];
        [endDate removeAllItems];

        for( i = 0; i < [journalEntries count]; i++)
        {
            NSMutableDictionary * tempDict = [journalEntries objectAtIndex:i];
            [beginDate addItemWithTitle: [tempDict objectForKey:@"Entered"]];
            [endDate addItemWithTitle: [tempDict objectForKey:@"Entered"]];
        }
        
        search_all = FALSE;

    }
}
@end
