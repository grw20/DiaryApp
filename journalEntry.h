/* jouralEntry */

#import <Cocoa/Cocoa.h>

@interface journalEntry : NSObject
{
    NSMutableArray * journalEntries;
    IBOutlet id clearButton;
    IBOutlet id entryField;
    IBOutlet id inputWindow;
    IBOutlet id newEntryButton;
    IBOutlet id deleteButton;
    IBOutlet id saveButton;
    IBOutlet id titleInput;
    IBOutlet id entryWindow;
    BOOL today_entry;
}
- (IBAction)clearEntry:(id)sender;
- (void)openEntry;
- (IBAction)saveEntry:(id)sender;
- (IBAction)deleteEntry:(id)sender;
- (void)showInputWindow;
@end
