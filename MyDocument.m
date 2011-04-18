#import "MyDocument.h"

@implementation MyDocument
- (void)awakeFromNib 
{ 
	
	NSString * calImPath =  [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"/cal.icns"];
	NSImage * calImage = [[NSImage alloc] initWithContentsOfFile:calImPath];
	[calImage setSize:[vCalExport visibleRect].size] ;
	[calImage setScalesWhenResized:YES];
	[vCalExport setImage:calImage];

	NSString * globeImPath =  [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"/globe.icns"];
	NSImage * globeImage = [[NSImage alloc] initWithContentsOfFile:globeImPath];
	[globeImage setSize:[htmlExport visibleRect].size] ;
	[globeImage setScalesWhenResized:YES];
	[htmlExport setImage:globeImage];
}

- (IBAction)checkPassword:(id)sender
{
    NSString *passPath = [NSString stringWithContentsOfFile:[@"~/Library/Application Support/DiaryApp/dapp.pwf" stringByExpandingTildeInPath]];
    NSString *enteredPass = [passInputCheck stringValue];

    if([enteredPass isEqualToString:passPath])
    {
        pass_entered = TRUE;
        //[authInput stopModal];
        [[NSApplication sharedApplication]  stopModal];

        [authInput close];
    }
    else pass_entered = FALSE;
    
    [passInputCheck setStringValue:@""];
    [self doLock:nil];
}


- (IBAction)feedPassword:(id)sender
{
    NSString * pass1;
    NSString * pass2;
    NSFileManager *manager = [NSFileManager defaultManager];

    pass1 = [passEntryInput stringValue];
    pass2 = [passEntryReInput stringValue];

    if([pass1 isEqualToString:pass2])
    {
        NSString *prefPath = [@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath];
        NSString *passPath = [@"~/Library/Application Support/DiaryApp/dapp.pwf" stringByExpandingTildeInPath];
        NSString *prefDirPath = [@"~/Library/Application Support/DiaryApp" stringByExpandingTildeInPath];
        NSString *defaultFilePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/Contents/Resources/Arraytest"];

        [manager createDirectoryAtPath:prefDirPath attributes:nil];
        if([manager createFileAtPath:prefPath contents:[NSData dataWithContentsOfFile:defaultFilePath] attributes:nil])
        {
            [manager createFileAtPath:passPath contents:[pass1 dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO] attributes:nil];
            [[NSApplication sharedApplication]  stopModal];
            [passEntryPanel close];
            diary_locked = FALSE;
            pass_entered = TRUE;
            [lock_unlock setStringValue:@"Lock"];
            [newEntryButton setEnabled:TRUE];
            [oldEntriesButton setEnabled:TRUE];
            [vCalExport setEnabled:TRUE];
            [htmlExport setEnabled:TRUE];

        }
    }
    else
    {
        [passEntryInput setStringValue:@""];
        [passEntryReInput setStringValue:@""];
        [passEntryPanel makeKeyAndOrderFront:self];
    }

}

- (IBAction)doLock:(id)sender
{

    NSFileManager *manager = [NSFileManager defaultManager];
    if(pass_entered)
    {
        
    if(diary_locked)
    {
        //open and decrypt
        NSFileHandle * input_file;
        NSFileHandle * output_file;
        NSData * crypt_data;

        input_file = [NSFileHandle fileHandleForReadingAtPath: [@"~/Library/Application Support/DiaryApp/crypt_file" stringByExpandingTildeInPath]];

        crypt_data = [input_file readDataToEndOfFile];
        [manager createFileAtPath:[@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath] contents:crypt_data attributes:nil];

        output_file = [NSFileHandle fileHandleForWritingAtPath: [@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath]];
        [output_file writeData:crypt_data];

        [manager removeFileAtPath:[@"~/Library/Application Support/DiaryApp/crypt_file" stringByExpandingTildeInPath] handler:self];
        diary_locked = FALSE;
        [lock_unlock setStringValue:@"Lock"];
        [newEntryButton setEnabled:TRUE];
        [oldEntriesButton setEnabled:TRUE];
        [vCalExport setEnabled:TRUE];
        [htmlExport setEnabled:TRUE];
		NSString * unLockPath =  [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"/lock-open.icns"];
		NSImage * openImage = [[NSImage alloc] initWithContentsOfFile:unLockPath];
		[openImage setSize:[lockButton visibleRect].size] ;
		[openImage setScalesWhenResized:YES];
		[lockButton setImage:openImage];
		
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DiaryUnlocked" object:nil];
    }else
    {
        //encrypt file
        NSFileHandle * input_file;
        NSFileHandle * output_file;
        NSData * clean_data;

        input_file = [NSFileHandle fileHandleForReadingAtPath: [@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath]];

        clean_data = [input_file readDataToEndOfFile];

        [manager createFileAtPath:[@"~/Library/Application Support/DiaryApp/crypt_file" stringByExpandingTildeInPath] contents:clean_data attributes:nil];

        output_file = [NSFileHandle fileHandleForWritingAtPath: [@"~/Library/Application Support/DiaryApp/crypt_file" stringByExpandingTildeInPath]];


        [output_file writeData:clean_data];
        [manager removeFileAtPath:[@"~/Library/Application Support/DiaryApp/Arraytest" stringByExpandingTildeInPath] handler:self];
        diary_locked = TRUE;
        [lock_unlock setStringValue:@"Unlock"];
        [newEntryButton setEnabled:FALSE];
        [oldEntriesButton setEnabled:FALSE];
        [vCalExport setEnabled:FALSE];
        [htmlExport setEnabled:FALSE];
		NSString * lockPath =  [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"/lock-closed.icns"];
		NSImage * closedImage = [[NSImage alloc] initWithContentsOfFile:lockPath];
		[closedImage setSize:[lockButton visibleRect].size] ;
		[closedImage setScalesWhenResized:YES];
		[lockButton setImage:closedImage];
		
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DiaryLocked" object:nil];
        [entWin close];
        [listWin close];

        pass_entered = FALSE;
    }
    }else
    {
        [[NSApplication sharedApplication]  runModalForWindow:authInput];
    }
}


- (IBAction)openEntriesWindow:(id)sender
{
    [oldentries showEntryWindow];
}

- (IBAction)openInputWindow:(id)sender
{
    [diaryentry showInputWindow];
}

- (void)sheetDidEndShouldClose: (NSWindow *)sheet
                    returnCode: (int)returnCode
                   contextInfo: (void *)contextInfo
{
    if (returnCode == NSAlertAlternateReturn)
    {
        [sheet close];
        [[NSApplication sharedApplication] terminate:nil];
    }

    if (returnCode == NSAlertDefaultReturn)
    {
        [passEntryPanel setFloatingPanel:NO];
        //[passEntryPanel makeKeyAndOrderFront:self];
        [[NSApplication sharedApplication]  runModalForWindow:passEntryPanel];
    }
}

/*start standard document stuff*/
- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    BOOL isDir;
    NSString *prefPath = [@"~/Library/Application Support/DiaryApp" stringByExpandingTildeInPath];
    NSFileManager *manager = [NSFileManager defaultManager];
    diary_locked = TRUE;
    pass_entered = FALSE;
    [super windowControllerDidLoadNib:aController];
    [actionTab selectFirstTabViewItem:nil];
    if (![manager fileExistsAtPath:prefPath isDirectory:&isDir] /*&& isDir*/)
    {
        NSBeginAlertSheet(
                          @"You must set a password!",
                          // sheet message
                          @"Setup",               // default button label
                          @"Cancel",              // alternate button label
                          nil,                    // no third button
                          mainWin,//[aController window],   // window sheet is attached to
                          self,                   // we'll be our own delegate
                          @selector(sheetDidEndShouldClose:returnCode:contextInfo:), // did-end selector
                          NULL,                   // no need for did-dismiss selector
                          NULL,                   // context info
                          @"Program will quit if you don't!", // additional text
                          nil);                   // no parameters in message
    }
    else if(isDir)
    {

    }
    else //file is there but isnt a directory
    {
        NSLog(@"Fatal Error!!! Prefs directory is a file - not a directory");
        [[NSApplication sharedApplication] terminate:nil];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doQuit:) name:@"NSApplicationWillTerminateNotification" object:nil];
	NSString * lockPath =  [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"/lock-closed.icns"];
	NSString * unLockPath =  [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"/lock-open.icns"];
	NSImage * closedImage = [[NSImage alloc] initWithContentsOfFile:lockPath];
	[closedImage setSize:[lockButton visibleRect].size] ;
	[closedImage setScalesWhenResized:YES];
	[lockButton setImage:closedImage];
		
}


- (NSData *)dataRepresentationOfType:(NSString *)aType
{
    // Insert code here to write your document from the given data.  You can also choose to override -fileWrapperRepresentationOfType: or -writeToFile:ofType: instead.
    return nil;
}

- (BOOL)loadDataRepresentation:(NSData *)data ofType:(NSString *)aType
{
    // Insert code here to read your document from the given data.  You can also choose to override -loadFileWrapperRepresentation:ofType: or -readFromFile:ofType: instead.
    return YES;
}

- (IBAction)doQuit:(id)sender
{
    if(diary_locked)
    {
        [[NSApplication sharedApplication] terminate:nil];
    }
    else
    {
        [self doLock:nil]; 
        [[NSApplication sharedApplication] terminate:nil];
    }
}

- (BOOL)tabView:(NSTabView *)tabView shouldSelectTabViewItem:(NSTabViewItem *)tabViewItem
{
	if([[tabViewItem label] isEqualToString:@"Search"]){
		if(diary_locked){
			[tabView selectFirstTabViewItem:self];
			return NO;
		}

	}
	return YES;
}

- (void)tabView:(NSTabView *)tabView willSelectTabViewItem:(NSTabViewItem *)tabViewItem
{
}

- (void)tabViewDidChangeNumberOfTabViewItems:(NSTabView *)tabView
{
}

/*
- (void)applicationDidFinishLaunching:(NSNotification *)notification {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [mainWin setFrameAutosaveName:@"Control Window"];
    [listWin setFrameAutosaveName:@"List Window"];
    [entWin setFrameAutosaveName:@"Entry Window"];
    [mainWin makeKeyAndOrderFront:nil];
}
*/

@end
