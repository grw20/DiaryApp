#import "oldEntryContoller.h"

@implementation oldEntryContoller

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotify:) name:@"SearchComplete" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doDouble:) name:@"TableViewReceivedDoubleClick" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unlockedDiary:) name:@"DiaryUnlocked" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lockedDiary:) name:@"DiaryLocked" object:nil];

    [entryList setDoubleAction:@selector(openEnt:)];
}

- (void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void)unlockedDiary:(NSNotification *)n
{
    [entryList reloadData];
}


- (void)lockedDiary:(NSNotification *)n
{
    [entryList reloadData];
}


- (void)handleNotify:(NSNotification *)n
{
    isPopulated = TRUE;
    journalEntries = [n object];
    [journalEntries retain];
    [entryList reloadData];
    [entryList setDoubleAction:@selector(openEnt:)];
    [entryWindow makeKeyAndOrderFront:self];
}

- (void)doDouble:(NSNotification *)n
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EntrySelected" object:[journalEntries objectAtIndex:[entryList selectedRow]]];
}


- (void)showEntryWindow
{

    if(!isPopulated)
    {
        journalEntries = [NSMutableArray arrayWithContentsOfFile:[@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath]];
        [journalEntries retain];
        isPopulated = TRUE;
    }
    [entryWindow makeKeyAndOrderFront:self];
}

- (IBAction)displayResults:(id)sender
{
    journalEntries = [NSMutableArray arrayWithContentsOfFile:[@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath]];
    [journalEntries retain];
    isPopulated = TRUE;
    [entryList reloadData];
}


- (id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)aTableColumn
            row:(int)rowIndex
{
    id theRecord, theValue;
    NSParameterAssert(rowIndex >= 0 && rowIndex < [journalEntries count]);
    theRecord = [journalEntries objectAtIndex:rowIndex];
    theValue = [theRecord objectForKey:[aTableColumn identifier]];
    return theValue;
}

- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{

    return [journalEntries count];
}



@end
