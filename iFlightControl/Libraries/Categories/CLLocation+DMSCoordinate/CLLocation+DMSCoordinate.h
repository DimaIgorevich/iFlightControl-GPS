//
//  CLLocation+DMSCoordinate.h
//  iFlightControl
//
//  Created by Admin on 09.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (DMSCoordinate)

+ (instancetype)locationWithDMSCoordinate:(CLLocationCoordinate2D)coordinate;

@end
