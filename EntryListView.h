//
//  EntryListView.h
//  DiaryApp
//
//  Created by David Evans on Tue Sep 03 2002.
//  Copyright (c) 2002 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface EntryListView : NSTableView {


}


-(IBAction) openEnt:(id)sender;
- (void) drawStripesInRect:(NSRect)clipRect;
@end
