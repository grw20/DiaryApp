/* searchContoller */

#import <Cocoa/Cocoa.h>

@interface searchController : NSObject
{
    IBOutlet id allEntriesRadio;
    IBOutlet id beginDate;
    IBOutlet id dateRangeRadio;
    IBOutlet id endDate;
    IBOutlet id searchButton;
    IBOutlet id searchProgress;
    IBOutlet id searchStringInput;
    NSMutableArray *journalEntries;
    BOOL search_all;
}
- (IBAction)performSearch:(id)sender;
- (IBAction)setTypeOfSearch:(id)sender;

@end
