//
//  vCalExporter.h
//  DiaryApp
//
//  Created by David Evans on Sat Sep 21 2002.
//  Copyright (c) 2002 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>


@interface vCalExporter : NSObject {

    IBOutlet id exportPanel;
    IBOutlet id goButton;
    IBOutlet id cancelButton;

}

- (IBAction) showWindow:(id)sender;
- (IBAction) exportIt:(id)sender;
- (void) export;

@end
