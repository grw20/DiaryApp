/* searchContoller */

#import <Cocoa/Cocoa.h>

@interface searchContoller : NSObject
{
    IBOutlet id allEntriesRadio;
    IBOutlet id beginDate;
    IBOutlet id dateRangeRadio;
    IBOutlet id endDate;
    IBOutlet id endDateProgress;
    IBOutlet id searchButton;
    IBOutlet id searchProgress;
    IBOutlet id searchStringInput;
    IBOutlet id startDateProgress;
}
- (IBAction)performSearch:(id)sender;
@end
