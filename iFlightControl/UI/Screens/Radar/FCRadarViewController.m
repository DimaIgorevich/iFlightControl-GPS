//
//  FCRadarViewController.m
//  iFlightControl
//
//  Created by Admin on 08.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import "FCRadarViewController.h"
#import "FCPlaneAnnotationView.h"

NSInteger const FCRadarViewControllerStandardMapViewIndex = 0;
NSInteger const FCRadarViewControllerSatelliteMapViewIndex = 1;

@interface FCRadarViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *vMap;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (strong, nonatomic) FCPlaneAnnotationView *planeAnnotation;

@end

@implementation FCRadarViewController

#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDeviceLocationNotification:) name:kUpdateDeviceLocationNotification object:nil];
    self.title = self.device.localName;
    [[FCEngine sharedInstance].bluetoothManager connectToPeripheral:self.device.peripheral];
    self.planeAnnotation = [[FCPlaneAnnotationView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vMap.delegate = self;
}

#pragma mark - Notifications

- (void)updateDeviceLocationNotification:(NSNotification *)notification {
    NSDictionary *object = notification.object;
    CLLocation *deviceLocation = [object objectForKey:kDeviceLocation];
    self.planeAnnotation.coordinate = deviceLocation.coordinate;
    [self.vMap addAnnotation:self.planeAnnotation];
}

#pragma mark - MKMapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    MKAnnotationView *pinView = nil;
    if(annotation != mapView.userLocation) {
        static NSString *defaultPinID = @"com.invasivecode.pin";
        pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil ) {
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        }
        pinView.image = [UIImage imageNamed:@"plane_annotation_icon_32x32.png"];
    }
    
    return pinView;
}

#pragma mark - UISegmentControl

- (IBAction)didSegmentControlChangedValue:(id)sender {
    switch (self.segmentControl.selectedSegmentIndex) {
        case FCRadarViewControllerStandardMapViewIndex:
            self.vMap.mapType = MKMapTypeStandard;
            break;
        case FCRadarViewControllerSatelliteMapViewIndex:
            self.vMap.mapType = MKMapTypeSatellite;
            break;
    }
}

@end