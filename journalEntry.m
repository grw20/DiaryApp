#import "journalEntry.h"

@implementation journalEntry
- (void)awakeFromNib
{
    NSNotificationCenter *notify;
    notify =[NSNotificationCenter defaultCenter];
    [notify addObserver:self selector:@selector(showEntry:) name:@"EntrySelected" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearEntry:) name:@"DiaryUnlocked" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearEntry:) name:@"DiaryLocked" object:nil];
    today_entry = FALSE;
}

- (void)dealloc
{
    NSNotificationCenter *notify;
    notify =[NSNotificationCenter defaultCenter];
    [notify removeObserver:self];
    [super dealloc];
}

- (void)showEntry:(NSNotification *)n
{
    NSCalendarDate *now = [NSCalendarDate calendarDate];
    NSMutableDictionary * entry = [n object];
    NSString *datestr = [now descriptionWithCalendarFormat:@"%m/%d/%y"];
    if([[entry objectForKey:@"Entered"] isEqualTo:datestr])
    {
        [saveButton setEnabled:TRUE];
        [entryField setEditable:TRUE];
        today_entry = true;
    }
    else
    {
        [saveButton setEnabled:FALSE];
        [entryField setEditable:FALSE];
        today_entry = false;
    }

    [entry retain];
    [titleInput setStringValue:[entry objectForKey:@"Chapter"]];
    [entryField setString:[entry objectForKey:@"Entry"]];
    [inputWindow makeKeyAndOrderFront:self];

}

- (void)showInputWindow
{
    journalEntries = [NSMutableArray arrayWithContentsOfFile:[@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath]];
    [journalEntries retain];
    [inputWindow makeKeyAndOrderFront:self];
    [saveButton setEnabled:TRUE];
    [entryField setEditable:TRUE];
    [titleInput setStringValue:@""];
    [entryField selectAll:self];
    [entryField delete:self];
    [self openEntry];
}

- (IBAction)clearEntry:(id)sender
{
    if(!today_entry)
    {
        [titleInput setStringValue:@""];
        [entryField selectAll:self];
        [entryField delete:self];
    }
}


- (void)openEntry{
    int i = 0;
    NSCalendarDate *now = [NSCalendarDate calendarDate];
    NSString *datestr = [now descriptionWithCalendarFormat:@"%m/%d/%y"];

    for(i = 0; i < [journalEntries count]; i++)
    {
        if([[[journalEntries objectAtIndex:i] objectForKey:@"Entered"] isEqualTo:datestr])
        {
            [titleInput setStringValue:@""];
            [entryField selectAll:self];
            [entryField delete:self];
            [titleInput setStringValue:[[journalEntries objectAtIndex:i] objectForKey:@"Chapter"]];
            [entryField setString:[[journalEntries objectAtIndex:i] objectForKey:@"Entry"]];
            today_entry = TRUE;
            return;
        }
    }
    [saveButton setEnabled:TRUE];
    [titleInput setStringValue:@""];
    [entryField selectAll:self];
    [entryField delete:self];
    today_entry = FALSE;
}

- (IBAction)saveEntry:(id)sender{
    if(today_entry)
    {
        int i = 0;
        NSCalendarDate *now = [NSCalendarDate calendarDate];
        NSString *datestr = [now descriptionWithCalendarFormat:@"%m/%d/%y"];

        for(i = 0; i < [journalEntries count]; i++)
        {
            if([[[journalEntries objectAtIndex:i] objectForKey:@"Entered"] isEqualTo:datestr])
            {
                NSString * title = [titleInput stringValue];
                NSString * entry = [entryField string];

                [[journalEntries objectAtIndex:i] setDictionary:[NSDictionary dictionaryWithObjectsAndKeys:datestr ,@"Entered", title, @"Chapter", entry, @"Entry",nil]];
                today_entry = TRUE;
                [journalEntries writeToFile:[@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath] atomically:YES];
                //return;
            }
        }

    }
    else
    {
        NSCalendarDate *now = [NSCalendarDate calendarDate];
        NSString *datestr = [now descriptionWithCalendarFormat:@"%m/%d/%y"];

        NSString * title = [titleInput stringValue];
        NSString * entry = [entryField string];

        NSDictionary * temp = [NSDictionary dictionaryWithObjectsAndKeys:datestr ,@"Entered", title, @"Chapter", entry, @"Entry",nil];

        [journalEntries insertObject:temp atIndex:0];
        [journalEntries retain];
        [journalEntries writeToFile:[@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath] atomically:YES];
        [titleInput setStringValue:@""];
        [entryField selectAll:self];
        [entryField delete:self];
        //journalEntries = [NSMutableArray arrayWithContentsOfFile:[@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath]];
    }
    journalEntries = [NSMutableArray arrayWithContentsOfFile:[@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchComplete" object:journalEntries];
    [entryWindow close];
}

- (IBAction)deleteEntry:(id)sender
{
    NSString * title = [titleInput stringValue];
    NSString * entry = [entryField string];
    int i = 0;
    //search for entry we want to kill
    NSLog(@"Count: %d", [journalEntries count]);
    journalEntries = [NSMutableArray arrayWithContentsOfFile:[@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath]];
    for(i = 0; i < [journalEntries count]; i++)
    {
            NSLog(@"HERE");

        if([[[journalEntries objectAtIndex:i] objectForKey:@"Chapter"] isEqualTo:title]){

            if([[[journalEntries objectAtIndex:i] objectForKey:@"Entry"] isEqualTo:entry])
            {
                [journalEntries removeObjectAtIndex:i];
                [journalEntries writeToFile:[@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath] atomically:YES];
                journalEntries = [NSMutableArray arrayWithContentsOfFile:[@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchComplete" object:journalEntries];
                [titleInput setStringValue:@""];
                [entryField selectAll:self];
                [entryField delete:self];
                [entryWindow close];
                return;
            }
        }
    }
}


@end
