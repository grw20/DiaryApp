/* MyDocument */

#import <Cocoa/Cocoa.h>

@interface MyDocument : NSDocument
{
    NSMutableArray * entryArray;
    IBOutlet id actionTab;
    IBOutlet id newEntryButton;
    IBOutlet id lockButton;
    IBOutlet id oldentries;
    IBOutlet id oldEntriesButton;
    IBOutlet id searcher;
    IBOutlet id diaryentry;
    IBOutlet id passEntryPanel;
    IBOutlet id passEntryInput;
    IBOutlet id passEntryReInput;
    IBOutlet id lock_unlock;
    IBOutlet id mainWin;
    IBOutlet id listWin;
    IBOutlet id entWin;
    IBOutlet id authInput;
    IBOutlet id passInputCheck;
    IBOutlet id vCalExport;
    IBOutlet id htmlExport;
    BOOL diary_locked;
    BOOL pass_entered;
}

- (IBAction)feedPassword:(id)sender;
- (IBAction)checkPassword:(id)sender;
- (IBAction)openEntriesWindow:(id)sender;
- (IBAction)openInputWindow:(id)sender;
- (IBAction)doLock:(id)sender;
- (IBAction)doQuit:(id)sender;
- (void)sheetDidEndShouldClose: (NSWindow *)sheet returnCode: (int)returnCode contextInfo: (void *)contextInfo;
//- (void)applicationDidFinishLaunching:(NSNotification *)notification;
- (BOOL)tabView:(NSTabView *)tabView shouldSelectTabViewItem:(NSTabViewItem *)tabViewItem;
- (void)tabView:(NSTabView *)tabView willSelectTabViewItem:(NSTabViewItem *)tabViewItem;
- (void)tabViewDidChangeNumberOfTabViewItems:(NSTabView *)tabView;

@end
