#import "AppDelegate.h"

@implementation AppDelegate
AGSDynamicMapServiceLayer *demographicsLayer;
NSString *streetUrl = @"http://services.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer";
NSString *aerialUrl = @"http://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer";
NSString *greyUrl = @"http://services.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer";
NSString *BackgroundLayer = @"Background Layer";
AGSGeometryEngine *geometryEngine;



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    geometryEngine = [AGSGeometryEngine defaultGeometryEngine];
    
    // Initiatalize Layers
    AGSTiledMapServiceLayer *bgLayer = [[AGSTiledMapServiceLayer alloc] initWithURL:[NSURL URLWithString:streetUrl]];
    demographicsLayer = [[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"http://server.arcgisonline.com/ArcGIS/rest/services/Demographics/USA_1990-2000_Population_Change/MapServer"]];
    
    // Initalize map
    AGSEnvelope *envelope = [AGSEnvelope envelopeWithXmin:-120 ymin:15 xmax:-70  ymax:60  spatialReference:[AGSSpatialReference wgs84SpatialReference]];
    
    [geometryEngine projectGeometry:envelope toSpatialReference:[AGSSpatialReference webMercatorSpatialReference]];
    
    //reproject the envelope from geographic
    [self.mapView zoomToEnvelope:envelope animated:NO];
    
    //Add it to the map view
    [self.mapView addMapLayer:bgLayer withName:BackgroundLayer];
    [self.mapView addMapLayer:demographicsLayer withName:@"Demo Layer"];
    [self.mapView addMapLayer:[[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:@"Need Test URL with tabluar data for grid"]] withName:@"TestData"];
    
    self.mapView.touchDelegate = self;
}

- (IBAction)changeBackground:(id)sender {
    
    NSURL* basemapURL ;
    NSSegmentedControl* segControl = (NSSegmentedControl*)sender;
    switch (segControl.selectedSegment) {
        case 0: //Aerial
            basemapURL = [NSURL URLWithString:aerialUrl];
            break;
        case 1: //Street
            basemapURL = [NSURL URLWithString:streetUrl];
            break;
        case 2: //Gray
            basemapURL = [NSURL URLWithString:greyUrl];
            break;
        default:
            basemapURL = [NSURL URLWithString:aerialUrl];
            break;
    }
    
    //remove existing basemap layer
    [self.mapView removeMapLayerWithName:BackgroundLayer];
    
    //add new layer
    AGSTiledMapServiceLayer* newBasemapLayer = [AGSTiledMapServiceLayer tiledMapServiceLayerWithURL:basemapURL];
    newBasemapLayer.name = BackgroundLayer;
    [self.mapView insertMapLayer:newBasemapLayer atIndex:0];
}

- (BOOL)mapView:(AGSMapView *)mapView shouldProcessClickAtPoint:(CGPoint)screen mapPoint:(AGSPoint *)mappoint {
    NSLog(@"MapView's shouldProcessClickAtPoint invoked!");
    //do a map query
    return YES;
}

- (IBAction)helpButtonClick:(id)sender {
    NSLog(@"button clicked");
    //open a link to help doc
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString: @"http://www.google.com"]];
}

@end
