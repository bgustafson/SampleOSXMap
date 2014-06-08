#import <Cocoa/Cocoa.h>
#import <ArcGIS/ArcGIS.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet AGSMapView *mapView;

@property (strong) IBOutlet NSSegmentedControl *changeBackground;

@property (strong) IBOutlet NSButtonCell *helpButtonClick;

@end
