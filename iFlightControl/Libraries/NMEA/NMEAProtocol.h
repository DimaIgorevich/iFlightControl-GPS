//
//  NMEAProtocol.h
//  iFlightControl
//
//  Created by Admin on 09.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GPSNMEAProtocolType) {
    GPSNMEAProtocolTypeGPGGA    = 0,
    GPSNMEAProtocolTypeGPGLL    = 1,
    GPSNMEAProtocolTypeGPGSA    = 2,
    GPSNMEAProtocolTypeGPGSV    = 3,
    GPSNMEAProtocolTypeGPRMC    = 4,
    GPSNMEAProtocolTypeGPVTG    = 5,
    GPSNMEAProtocolTypeGPZDA    = 6,
    GPSNMEAProtocolTypeUnknown  = 7
};

typedef NS_ENUM(NSInteger, GPGGAGroupSequance) {
    GPGGAGroupSequanceType                      = 1,
    GPGGAGroupSequanceGreenwichTimestamp        = 2,
    GPGGAGroupSequanceLatitude                  = 3,
    GPGGAGroupSequanceVerticalGeography         = 4,
    GPGGAGroupSequanceLongitude                 = 5,
    GPGGAGroupSequanceHorizontalGeography       = 6,
    GPGGAGroupSequanceQualityGPSSignal          = 7,
    GPGGAGroupSequanceSatellitesCount           = 8,
    GPGGAGroupSequanceAccuracyFactorHDOP        = 9,
    GPGGAGroupSequanceReceiverAntennaHeight     = 10,
    GPGGAGroupSequanceUnitOfMeasurementHeight   = 11,
    GPGGAGroupSequanceGeoidalDifference         = 12,
    GPGGAGroupSequanceUnitOfDifference          = 13,
    GPGGAGroupSequanceAgeOfDifferentialData     = 14,
    GPGGAGroupSequanceStationIndicator          = 15,
    GPGGAGroupSequanceCheckSum                  = 16
};

typedef NS_ENUM(NSInteger, QualityGPSSignalType) {
    QualityGPSSignalTypeNotPossible  = 0,
    QualityGPSSignalTypeStandard     = 1,
    QualityGPSSignalTypeDifferential = 2,
    QualityGPSSignalTypePrecision    = 3
};

typedef NS_ENUM(NSInteger, GPGLLGroupSequance) {
    GPGLLGroupSequanceType                  = 1,
    GPGLLGroupSequanceLatitude              = 2,
    GPGLLGroupSequanceVerticalGeography     = 3,
    GPGLLGroupSequanceLongitude             = 4,
    GPGLLGroupSequanceHorizontalGeography   = 5,
    GPGLLGroupSequanceGreenwichTimestamp    = 6,
    GPGLLGroupSequanceGPSDataStatus         = 7,
    GPGLLGroupSequanceCheckSum              = 8
};

typedef NS_ENUM(NSInteger, GPSDataStatus) {
    GPSDataStatusA = 0,
    GPSDataStatusV = 1
};

typedef NS_ENUM(NSInteger, GPGSAGroupSequance) {
    GPGSAGroupSequanceType            = 1,
    GPGSAGroupSequanceMode            = 2,
    GPGSAGroupSequanceShowMode        = 3,
    GPGSAGroupSequanceSatellitesPRN1  = 4,
    GPGSAGroupSequanceSatellitesPRN2  = 5,
    GPGSAGroupSequanceSatellitesPRN3  = 6,
    GPGSAGroupSequanceSatellitesPRN4  = 7,
    GPGSAGroupSequanceSatellitesPRN5  = 8,
    GPGSAGroupSequanceSatellitesPRN6  = 9,
    GPGSAGroupSequanceSatellitesPRN7  = 10,
    GPGSAGroupSequanceSatellitesPRN8  = 11,
    GPGSAGroupSequanceSatellitesPRN9  = 12,
    GPGSAGroupSequanceSatellitesPRN10 = 13,
    GPGSAGroupSequanceSatellitesPRN11 = 14,
    GPGSAGroupSequanceSatellitesPRN12 = 15,
    GPGSAGroupSequanceFactorPDOP      = 16,
    GPGSAGroupSequanceFactorHDOP      = 17,
    GPGSAGroupSequanceFactorVDOP      = 18,
    GPGSAGroupSequanceCheckSum        = 19
};

typedef NS_ENUM(NSInteger, GPSMode) {
    GPSModeA = 0,
    GPSModeM = 1
};

typedef NS_ENUM(NSInteger, GPSShowMode) {
    GPSShowModeLocationNotDefined = 1,
    GPSShowMode2D                 = 2,
    GPSShowMode3D                 = 3
};

typedef NS_ENUM(NSInteger, GPGSVGroupSequance) {
    GPGSVGroupSequanceType                              = 1,
    GPGSVGroupSequanceTotalNumberOfMessages             = 2,
    GPGSVGroupSequanceNumberOfMessage                   = 3,
    GPGSVGroupSequanceTotalNumberOfVisibleSatellites    = 4,
    GPGSVGroupSequancePRN1NumberOfSatellites            = 5,
    GPGSVGroupSequancePRN1HeightDegrees                 = 6,
    GPGSVGroupSequancePRN1AzimuthDegrees                = 7,
    GPGSVGroupSequancePRN1SOrNRatio                     = 8,
    GPGSVGroupSequancePRN2NumberOfSatellites            = 9,
    GPGSVGroupSequancePRN2HeightDegrees                 = 10,
    GPGSVGroupSequancePRN2AzimuthDegrees                = 11,
    GPGSVGroupSequancePRN2SOrNRatio                     = 12,
    GPGSVGroupSequancePRN3NumberOfSatellites            = 13,
    GPGSVGroupSequancePRN3HeightDegrees                 = 14,
    GPGSVGroupSequancePRN3AzimuthDegrees                = 15,
    GPGSVGroupSequancePRN3SOrNRatio                     = 16,
    GPGSVGroupSequancePRN4NumberOfSatellites            = 17,
    GPGSVGroupSequancePRN4HeightDegrees                 = 18,
    GPGSVGroupSequancePRN4AzimuthDegrees                = 19,
    GPGSVGroupSequancePRN4SOrNRatio                     = 20,
    GPGSVGroupSequanceCheckSum                          = 21
};

typedef NS_ENUM(NSInteger, GPRMCGroupSequance) {
    GPRMCGroupSequanceType                          = 1,
    GPRMCGroupSequanceTimestamp                     = 2,
    GPRMCGroupSequanceState                         = 3,
    GPRMCGroupSequanceLatitude                      = 4,
    GPRMCGroupSequanceVerticalGeography             = 5,
    GPRMCGroupSequanceLongitude                     = 6,
    GPRMCGroupSequanceHorizontalGeography           = 7,
    GPRMCGroupSequanceSpeedSOGInKnots               = 8,
    GPRMCGroupSequanceCourseDirectionInDegrees      = 9,
    GPRMCGroupSequanceDate                          = 10,
    GPRMCGroupSequanceMagneticDeclinationInDegrees  = 11,
    GPRMCGroupSequanceMagneticHorizontalGeography   = 12,
    GPRMCGroupSequanceCheckSum                      = 13
};

typedef NS_ENUM(NSInteger, GPSState) {
    GPSStateA = 0,
    GPSStateV = 1
};

typedef NS_ENUM(NSInteger, GPVTGGroupSequance) {
    GPVTGGroupSequanceType                          = 1,
    GPVTGGroupSequanceCourseDirectionInDegrees      = 2,
    GPVTGGroupSequanceMagneticDeclinationInDegrees  = 3,
    GPVTGGroupSequanceSpeedSOGInKnots               = 4,
    GPVTGGroupSequanceSpeedSOGInKilometersPerHour   = 5,
    GPVTGGroupSequanceCheckSum                      = 7
};

typedef NS_ENUM(NSInteger, GPZDAGroupSequance) {
    GPZDAGroupSequanceType                          = 1,
    GPZDAGroupSequanceTimestampUTC                  = 2,
    GPZDAGroupSequanceDay                           = 3,
    GPZDAGroupSequanceMounth                        = 4,
    GPZDAGroupSequanceYear                          = 5,
    GPZDAGroupSequanceTimeZoneOffsetFromGMTHours    = 6,
    GPZDAGroupSequanceTimeZoneOffsetFromGMTMinutes  = 7,
    GPZDAGroupSequanceCheckSum                      = 8
};

@protocol NMEAProtocolDelegate <NSObject>

- (void)didFinishParseData:(NSArray *)data protocolType:(GPSNMEAProtocolType)protocolType;

@end

@interface NMEAProtocol : NSObject

+ (GPSNMEAProtocolType)protocolTypeByString:(NSString *)data;

+ (void)parseNMEAData:(NSString *)data delegate:(id <NMEAProtocolDelegate> )delegate;

@end
