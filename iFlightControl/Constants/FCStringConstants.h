//
//  FCStringConstants.h
//  iFlightControl
//
//  Created by Admin on 08.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCStringConstants : NSObject

#pragma mark - Storyboards

FOUNDATION_EXTERN NSString * const kMainStoryboad;
FOUNDATION_EXTERN NSString * const kRadarStoryboard;

#pragma mark - CBAdvertisementData Keys

FOUNDATION_EXTERN NSString * const kCBAdvDataIsConnectable;
FOUNDATION_EXTERN NSString * const kCBAdvDataLocalName;
FOUNDATION_EXTERN NSString * const kCBAdvDataManufacturerData;
FOUNDATION_EXTERN NSString * const kCBAdvDataServiceData;
FOUNDATION_EXTERN NSString * const kCBAdvDataServiceUUIDs;
FOUNDATION_EXTERN NSString * const kCBAdvDataTxPowerLevel;

#pragma mark - Notifications

FOUNDATION_EXTERN NSString * const kUpdateBLEDeviceListNotification;
FOUNDATION_EXTERN NSString * const kUpdateDeviceLocationNotification;
FOUNDATION_EXTERN NSString * const kDeviceLocation;

#pragma mark - BLE Service UUIDs

FOUNDATION_EXTERN NSString * const kBLEHMSoftServiceUUID;

#pragma mark - GPS NMEA Protocol String Keys

FOUNDATION_EXTERN NSString * const kGPSNMEAProtocolTypeGPGGAString;
FOUNDATION_EXTERN NSString * const kGPSNMEAProtocolTypeGPGLLString;
FOUNDATION_EXTERN NSString * const kGPSNMEAProtocolTypeGPGSAString;
FOUNDATION_EXTERN NSString * const kGPSNMEAProtocolTypeGPGSVString;
FOUNDATION_EXTERN NSString * const kGPSNMEAProtocolTypeGPRMCString;
FOUNDATION_EXTERN NSString * const kGPSNMEAProtocolTypeGPVTGString;
FOUNDATION_EXTERN NSString * const kGPSNMEAProtocolTypeGPZDAString;
FOUNDATION_EXTERN NSString * const kGPSNMEAProtocolTypeEndSuffix;

@end
