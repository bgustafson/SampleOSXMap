//
//  AppDelegate.h
//  SampleMapViewer
//
//  Created by Brian Gustafson on 12/21/13.
//  Copyright (c) 2013 Brian Gustafson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <ArcGIS/ArcGIS.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong)IBOutlet AGSMapView *mapView;

@property (strong) IBOutlet NSSegmentedControl *changeBackground;


@end
