/* oldEntryContoller */

#import <Cocoa/Cocoa.h>

@interface oldEntryContoller : NSObject
{
    BOOL isPopulated;
    NSMutableArray *journalEntries;
    IBOutlet id entryList;
    IBOutlet id entryWindow;
    IBOutlet id oldEntriesButton;

}

- (void)showEntryWindow;
- (IBAction)displayResults:(id)sender;

@end
