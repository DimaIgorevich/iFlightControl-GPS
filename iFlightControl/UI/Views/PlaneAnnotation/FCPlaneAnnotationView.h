//
//  FCPlaneAnnotationView.h
//  iFlightControl
//
//  Created by Admin on 09.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface FCPlaneAnnotationView : MKAnnotationView <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
