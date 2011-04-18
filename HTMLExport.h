//
//  HTMLExport.h
//  DiaryApp
//
//  Created by David Evans on Sat Sep 20 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//
#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>


@interface HTMLExport : NSObject {

    IBOutlet id exportPanel;
    IBOutlet id goButton;
    IBOutlet id cancelButton;
    IBOutlet id fileName;

}

- (IBAction) showWindow:(id)sender;
- (IBAction) exportIt:(id)sender;
- (void) export;

@end
/*
	<style type="text/css" media="screen">
	<!--
	body
	{
		padding: 0;
		margin: 0;
		background-color: #666;
		color: #000;
	}
	
	#contents	
	{
		margin-top: 10px;
		margin-bottom: 10px;
		margin-left: 15%;
		margin-right: 15%;
		padding: 10px;
		background-color: #FFF;
		color: #000;
	}
	
	h1	
	{
		color: #333;
		background-color: transparent;
		font-family: Arial, Helvetica, sans-serif;
		font-size: 20px;
	}
	
	p	
	{
		color: #333;
		background-color: transparent;
		font-family: Arial, Helvetica, sans-serif;
		font-size: 0.8em;
	}
	
	.code
	{
		color: #339;
		background-color: transparent;
		font-family: times, serif;
		font-size: 0.9em;
		padding-left: 40px;
	}
	-->
</style>
*/