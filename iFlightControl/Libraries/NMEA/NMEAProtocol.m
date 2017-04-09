//
//  NMEAProtocol.m
//  iFlightControl
//
//  Created by Admin on 09.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import "NMEAProtocol.h"

NSString * const NMEAProtocolExpressionPatternGPGGA = @"([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*)";
NSString * const NMEAProtocolExpressionPatternGPGLL = @"([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*)";
NSString * const NMEAProtocolExpressionPatternGPGSA = @"([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*)";
NSString * const NMEAProtocolExpressionPatternGPGSV = @"([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*)";
NSString * const NMEAProtocolExpressionPatternGPRMC = @"([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*)";
NSString * const NMEAProtocolExpressionPatternGPVTG = @"([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*)";
NSString * const NMEAProtocolExpressionPatternGPZDA = @"([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*)";

@implementation NMEAProtocol

+ (GPSNMEAProtocolType)protocolTypeByString:(NSString *)data {
    if ([data rangeOfString:kGPSNMEAProtocolTypeGPGGAString].location != NSNotFound) {
        return GPSNMEAProtocolTypeGPGGA;
    } else if ([data rangeOfString:kGPSNMEAProtocolTypeGPGLLString].location != NSNotFound) {
        return GPSNMEAProtocolTypeGPGLL;
    } else if ([data rangeOfString:kGPSNMEAProtocolTypeGPGSAString].location != NSNotFound) {
        return GPSNMEAProtocolTypeGPGSA;
    } else if ([data rangeOfString:kGPSNMEAProtocolTypeGPGSVString].location != NSNotFound) {
        return GPSNMEAProtocolTypeGPGSV;
    } else if ([data rangeOfString:kGPSNMEAProtocolTypeGPRMCString].location != NSNotFound) {
        return GPSNMEAProtocolTypeGPRMC;
    } else if ([data rangeOfString:kGPSNMEAProtocolTypeGPVTGString].location != NSNotFound) {
        return GPSNMEAProtocolTypeGPVTG;
    } else if ([data rangeOfString:kGPSNMEAProtocolTypeGPZDAString].location != NSNotFound) {
        return GPSNMEAProtocolTypeGPZDA;
    }
    return GPSNMEAProtocolTypeUnknown;
}

+ (void)parseNMEAData:(NSString *)data delegate:(id <NMEAProtocolDelegate> )delegate {
    
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    NSError *error = NULL;
    NSRegularExpression *regex;
    NSArray *matches;
    
    GPSNMEAProtocolType protocolType = [NMEAProtocol protocolTypeByString:data];
    
    switch (protocolType) {
        case GPSNMEAProtocolTypeGPGGA: {
            regex = [NSRegularExpression regularExpressionWithPattern:NMEAProtocolExpressionPatternGPGGA options:NSRegularExpressionCaseInsensitive error:&error];
            matches = [regex matchesInString:data options:0 range:NSMakeRange(0, data.length)];
            [NMEAProtocol parseTypeGPGGAData:data withMatches:matches delegate:delegate];
        }
            break;
        case GPSNMEAProtocolTypeGPGLL: {
            regex = [NSRegularExpression regularExpressionWithPattern:NMEAProtocolExpressionPatternGPGLL options:NSRegularExpressionCaseInsensitive error:&error];
            matches = [regex matchesInString:data options:0 range:NSMakeRange(0, data.length)];
            [NMEAProtocol parseTypeGPGLLData:data withMatches:matches delegate:delegate];
        }
            break;
        case GPSNMEAProtocolTypeGPGSA: {
            regex = [NSRegularExpression regularExpressionWithPattern:NMEAProtocolExpressionPatternGPGSA options:NSRegularExpressionCaseInsensitive error:&error];
            matches = [regex matchesInString:data options:0 range:NSMakeRange(0, data.length)];
            [NMEAProtocol parseTypeGPGSAData:data withMatches:matches delegate:delegate];
        }
            break;
        case GPSNMEAProtocolTypeGPGSV: {
            regex = [NSRegularExpression regularExpressionWithPattern:NMEAProtocolExpressionPatternGPGSV options:NSRegularExpressionCaseInsensitive error:&error];
            matches = [regex matchesInString:data options:0 range:NSMakeRange(0, data.length)];
            [NMEAProtocol parseTypeGPGSVData:data withMatches:matches delegate:delegate];
        }
            break;
        case GPSNMEAProtocolTypeGPRMC: {
            regex = [NSRegularExpression regularExpressionWithPattern:NMEAProtocolExpressionPatternGPRMC options:NSRegularExpressionCaseInsensitive error:&error];
            matches = [regex matchesInString:data options:0 range:NSMakeRange(0, data.length)];
            [NMEAProtocol parseTypeGPRMCData:data withMatches:matches delegate:delegate];
        }
            break;
        case GPSNMEAProtocolTypeGPVTG: {
            regex = [NSRegularExpression regularExpressionWithPattern:NMEAProtocolExpressionPatternGPVTG options:NSRegularExpressionCaseInsensitive error:&error];
            matches = [regex matchesInString:data options:0 range:NSMakeRange(0, data.length)];
            [NMEAProtocol parseTypeGPVTGData:data withMatches:matches delegate:delegate];
        }
            break;
        case GPSNMEAProtocolTypeGPZDA: {
            regex = [NSRegularExpression regularExpressionWithPattern:NMEAProtocolExpressionPatternGPZDA options:NSRegularExpressionCaseInsensitive error:&error];
            matches = [regex matchesInString:data options:0 range:NSMakeRange(0, data.length)];
            [NMEAProtocol parseTypeGPZDAData:data withMatches:matches delegate:delegate];
        }
            break;
        case GPSNMEAProtocolTypeUnknown:
            NSLog(@"GPSNMEAProtocolTypeUnknown");
            break;
    }
}

#pragma mark - GPGGA

+ (void)parseTypeGPGGAData:(NSString *)data withMatches:(NSArray *)matches delegate:(id <NMEAProtocolDelegate> )delegate {
    NSTextCheckingResult *match = [matches firstObject];
    
    NSArray *result = @[
                        [data substringWithRange:[match rangeAtIndex:GPGGAGroupSequanceType]],
                        [data substringWithRange:[match rangeAtIndex:GPGGAGroupSequanceGreenwichTimestamp]],
                        [data substringWithRange:[match rangeAtIndex:GPGGAGroupSequanceLatitude]],
                        [data substringWithRange:[match rangeAtIndex:GPGGAGroupSequanceVerticalGeography]],
                        [data substringWithRange:[match rangeAtIndex:GPGGAGroupSequanceLongitude]],
                        [data substringWithRange:[match rangeAtIndex:GPGGAGroupSequanceHorizontalGeography]],
                        [data substringWithRange:[match rangeAtIndex:GPGGAGroupSequanceQualityGPSSignal]],
                        [data substringWithRange:[match rangeAtIndex:GPGGAGroupSequanceSatellitesCount]],
                        [data substringWithRange:[match rangeAtIndex:GPGGAGroupSequanceAccuracyFactorHDOP]],
                        [data substringWithRange:[match rangeAtIndex:GPGGAGroupSequanceReceiverAntennaHeight]],
                        [data substringWithRange:[match rangeAtIndex:GPGGAGroupSequanceUnitOfMeasurementHeight]],
                        [data substringWithRange:[match rangeAtIndex:GPGGAGroupSequanceGeoidalDifference]],
                        [data substringWithRange:[match rangeAtIndex:GPGGAGroupSequanceUnitOfDifference]],
                        [data substringWithRange:[match rangeAtIndex:GPGGAGroupSequanceAgeOfDifferentialData]],
                        [data substringWithRange:[match rangeAtIndex:GPGGAGroupSequanceCheckSum]]
                        ];
    
    if ([delegate respondsToSelector:@selector(didFinishParseData:protocolType:)]) {
        [delegate didFinishParseData:result protocolType:GPSNMEAProtocolTypeGPGGA];
    }
}

#pragma mark - GPGLL

+ (void)parseTypeGPGLLData:(NSString *)data withMatches:(NSArray *)matches delegate:(id <NMEAProtocolDelegate> )delegate {
    NSTextCheckingResult *match = [matches firstObject];
    
    NSArray *result = @[
                        [data substringWithRange:[match rangeAtIndex:GPGLLGroupSequanceType]],
                        [data substringWithRange:[match rangeAtIndex:GPGLLGroupSequanceLatitude]],
                        [data substringWithRange:[match rangeAtIndex:GPGLLGroupSequanceVerticalGeography]],
                        [data substringWithRange:[match rangeAtIndex:GPGLLGroupSequanceLongitude]],
                        [data substringWithRange:[match rangeAtIndex:GPGLLGroupSequanceHorizontalGeography]],
                        [data substringWithRange:[match rangeAtIndex:GPGLLGroupSequanceGreenwichTimestamp]],
                        [data substringWithRange:[match rangeAtIndex:GPGLLGroupSequanceGPSDataStatus]],
                        [data substringWithRange:[match rangeAtIndex:GPGLLGroupSequanceCheckSum]],
                        ];
    
    if ([delegate respondsToSelector:@selector(didFinishParseData:protocolType:)]) {
        [delegate didFinishParseData:result protocolType:GPSNMEAProtocolTypeGPGLL];
    }
}

#pragma mark - GPGSA

+ (void)parseTypeGPGSAData:(NSString *)data withMatches:(NSArray *)matches delegate:(id <NMEAProtocolDelegate> )delegate {
    NSTextCheckingResult *match = [matches firstObject];
    
    NSArray *result = @[
                        [data substringWithRange:[match rangeAtIndex:GPGSAGroupSequanceType]],
                        [data substringWithRange:[match rangeAtIndex:GPGSAGroupSequanceMode]],
                        [data substringWithRange:[match rangeAtIndex:GPGSAGroupSequanceShowMode]],
                        [data substringWithRange:[match rangeAtIndex:GPGSAGroupSequanceSatellitesPRN1]],
                        [data substringWithRange:[match rangeAtIndex:GPGSAGroupSequanceSatellitesPRN2]],
                        [data substringWithRange:[match rangeAtIndex:GPGSAGroupSequanceSatellitesPRN3]],
                        [data substringWithRange:[match rangeAtIndex:GPGSAGroupSequanceSatellitesPRN4]],
                        [data substringWithRange:[match rangeAtIndex:GPGSAGroupSequanceSatellitesPRN5]],
                        [data substringWithRange:[match rangeAtIndex:GPGSAGroupSequanceSatellitesPRN6]],
                        [data substringWithRange:[match rangeAtIndex:GPGSAGroupSequanceSatellitesPRN7]],
                        [data substringWithRange:[match rangeAtIndex:GPGSAGroupSequanceSatellitesPRN8]],
                        [data substringWithRange:[match rangeAtIndex:GPGSAGroupSequanceSatellitesPRN9]],
                        [data substringWithRange:[match rangeAtIndex:GPGSAGroupSequanceSatellitesPRN10]],
                        [data substringWithRange:[match rangeAtIndex:GPGSAGroupSequanceSatellitesPRN11]],
                        [data substringWithRange:[match rangeAtIndex:GPGSAGroupSequanceFactorPDOP]],
                        [data substringWithRange:[match rangeAtIndex:GPGSAGroupSequanceFactorHDOP]],
                        [data substringWithRange:[match rangeAtIndex:GPGSAGroupSequanceFactorVDOP]],
                        [data substringWithRange:[match rangeAtIndex:GPGSAGroupSequanceCheckSum]],
                        ];
    
    if ([delegate respondsToSelector:@selector(didFinishParseData:protocolType:)]) {
        [delegate didFinishParseData:result protocolType:GPSNMEAProtocolTypeGPGSA];
    }
}

#pragma mark - GPGSV

+ (void)parseTypeGPGSVData:(NSString *)data withMatches:(NSArray *)matches delegate:(id <NMEAProtocolDelegate> )delegate {
    NSTextCheckingResult *match = [matches firstObject];

    NSArray *result = @[
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequanceType]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequanceTotalNumberOfMessages]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequanceNumberOfMessage]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequancePRN1NumberOfSatellites]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequancePRN1HeightDegrees]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequancePRN1AzimuthDegrees]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequancePRN1SOrNRatio]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequancePRN2NumberOfSatellites]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequancePRN2HeightDegrees]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequancePRN2AzimuthDegrees]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequancePRN2SOrNRatio]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequancePRN3NumberOfSatellites]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequancePRN3HeightDegrees]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequancePRN3AzimuthDegrees]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequancePRN3SOrNRatio]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequancePRN4NumberOfSatellites]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequancePRN4HeightDegrees]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequancePRN4AzimuthDegrees]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequancePRN4SOrNRatio]],
                        [data substringWithRange:[match rangeAtIndex:GPGSVGroupSequanceCheckSum]],
                        ];
    if ([delegate respondsToSelector:@selector(didFinishParseData:protocolType:)]) {
        [delegate didFinishParseData:result protocolType:GPSNMEAProtocolTypeGPGSV];
    }
}

#pragma mark - GPRMC

+ (void)parseTypeGPRMCData:(NSString *)data withMatches:(NSArray *)matches delegate:(id <NMEAProtocolDelegate> )delegate {
    NSTextCheckingResult *match = [matches firstObject];
    
    NSArray *result = @[
                        [data substringWithRange:[match rangeAtIndex:GPRMCGroupSequanceType]],
                        [data substringWithRange:[match rangeAtIndex:GPRMCGroupSequanceTimestamp]],
                        [data substringWithRange:[match rangeAtIndex:GPRMCGroupSequanceState]],
                        [data substringWithRange:[match rangeAtIndex:GPRMCGroupSequanceLatitude]],
                        [data substringWithRange:[match rangeAtIndex:GPRMCGroupSequanceVerticalGeography]],
                        [data substringWithRange:[match rangeAtIndex:GPRMCGroupSequanceLongitude]],
                        [data substringWithRange:[match rangeAtIndex:GPRMCGroupSequanceHorizontalGeography]],
                        [data substringWithRange:[match rangeAtIndex:GPRMCGroupSequanceSpeedSOGInKnots]],
                        [data substringWithRange:[match rangeAtIndex:GPRMCGroupSequanceCourseDirectionInDegrees]],
                        [data substringWithRange:[match rangeAtIndex:GPRMCGroupSequanceDate]],
                        [data substringWithRange:[match rangeAtIndex:GPRMCGroupSequanceMagneticDeclinationInDegrees]],
                        [data substringWithRange:[match rangeAtIndex:GPRMCGroupSequanceMagneticHorizontalGeography]],
                        [data substringWithRange:[match rangeAtIndex:GPRMCGroupSequanceCheckSum]]
                        ];
    
    if ([delegate respondsToSelector:@selector(didFinishParseData:protocolType:)]) {
        [delegate didFinishParseData:result protocolType:GPSNMEAProtocolTypeGPRMC];
    }
}

#pragma mark - GPVTG

+ (void)parseTypeGPVTGData:(NSString *)data withMatches:(NSArray *)matches delegate:(id <NMEAProtocolDelegate> )delegate {
    NSTextCheckingResult *match = [matches firstObject];
    
    NSArray *result = @[
                        [data substringWithRange:[match rangeAtIndex:GPVTGGroupSequanceType]],
                        [data substringWithRange:[match rangeAtIndex:GPVTGGroupSequanceCourseDirectionInDegrees]],
                        [data substringWithRange:[match rangeAtIndex:GPVTGGroupSequanceCourseDegreesIdentifier]],
                        [data substringWithRange:[match rangeAtIndex:GPVTGGroupSequanceMagneticDeclinationInDegrees]],
                        [data substringWithRange:[match rangeAtIndex:GPVTGGroupSequanceMagneticDegreesIdentifier]],
                        [data substringWithRange:[match rangeAtIndex:GPVTGGroupSequanceSpeedSOGInKnots]],
                        [data substringWithRange:[match rangeAtIndex:GPVTGGroupSequanceSpeedSOGKnotsIdentifier]],
                        [data substringWithRange:[match rangeAtIndex:GPVTGGroupSequanceSpeedSOGInKilometersPerHour]],
                        [data substringWithRange:[match rangeAtIndex:GPVTGGroupSequanceSpeedSOGKilometersPerHourIdentifier]],
                        [data substringWithRange:[match rangeAtIndex:GPVTGGroupSequanceCheckSum]]
                        ];
    
    if ([delegate respondsToSelector:@selector(didFinishParseData:protocolType:)]) {
        [delegate didFinishParseData:result protocolType:GPSNMEAProtocolTypeGPVTG];
    }
}

#pragma mark - GPZDA

+ (void)parseTypeGPZDAData:(NSString *)data withMatches:(NSArray *)matches delegate:(id <NMEAProtocolDelegate> )delegate {
    NSTextCheckingResult *match = [matches firstObject];
    
    NSArray *result = @[
                        [data substringWithRange:[match rangeAtIndex:GPZDAGroupSequanceType]],
                        [data substringWithRange:[match rangeAtIndex:GPZDAGroupSequanceTimestampUTC]],
                        [data substringWithRange:[match rangeAtIndex:GPZDAGroupSequanceDay]],
                        [data substringWithRange:[match rangeAtIndex:GPZDAGroupSequanceMounth]],
                        [data substringWithRange:[match rangeAtIndex:GPZDAGroupSequanceYear]],
                        [data substringWithRange:[match rangeAtIndex:GPZDAGroupSequanceTimeZoneOffsetFromGMTHours]],
                        [data substringWithRange:[match rangeAtIndex:GPZDAGroupSequanceTimeZoneOffsetFromGMTMinutes]],
                        [data substringWithRange:[match rangeAtIndex:GPZDAGroupSequanceCheckSum]]
                        ];
    
    if ([delegate respondsToSelector:@selector(didFinishParseData:protocolType:)]) {
        [delegate didFinishParseData:result protocolType:GPSNMEAProtocolTypeGPZDA];
    }
}

@end
