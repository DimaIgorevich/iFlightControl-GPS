//
//  CLLocation+DMSCoordinate.m
//  iFlightControl
//
//  Created by Admin on 09.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import "CLLocation+DMSCoordinate.h"

@implementation CLLocation (DMSCoordinate)

+ (instancetype)locationWithDMSCoordinate:(CLLocationCoordinate2D)coordinate {
    return [[super alloc] initWithLatitude:[CLLocation dmsFormatToDecimalFormatValue:coordinate.latitude] longitude:[CLLocation dmsFormatToDecimalFormatValue:coordinate.longitude]];
}

+ (CGFloat)dmsFormatToDecimalFormatValue:(CLLocationDegrees)dmsFormatValue {
    NSInteger degrees = dmsFormatValue / 100;
    CGFloat minutes = dmsFormatValue - degrees * 100;
    CGFloat decimal = degrees + minutes / 60;
    return decimal;
}

@end
