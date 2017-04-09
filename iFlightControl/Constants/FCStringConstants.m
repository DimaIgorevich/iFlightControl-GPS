//
//  FCStringConstants.m
//  iFlightControl
//
//  Created by Admin on 08.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import "FCStringConstants.h"

@implementation FCStringConstants

#pragma mark - Storyboards

NSString * const kMainStoryboad = @"Main";
NSString * const kRadarStoryboard = @"Radar";

#pragma mark - CBAdvertisementData Keys

NSString * const kCBAdvDataIsConnectable = @"kCBAdvDataIsConnectable";
NSString * const kCBAdvDataLocalName = @"kCBAdvDataLocalName";
NSString * const kCBAdvDataManufacturerData = @"kCBAdvDataManufacturerData";
NSString * const kCBAdvDataServiceData = @"kCBAdvDataServiceData";
NSString * const kCBAdvDataServiceUUIDs = @"kCBAdvDataServiceUUIDs";
NSString * const kCBAdvDataTxPowerLevel = @"kCBAdvDataTxPowerLevel";

#pragma mark - Notifications

NSString * const kUpdateBLEDeviceListNotification = @"kUpdateBLEDeviceListNotification";

#pragma mark - BLE Service UUIDs

NSString * const kBLEHMSoftServiceUUID = @"FFE0";

#pragma mark - GPS NMEA Protocol String Keys

NSString * const kGPSNMEAProtocolTypeGPGGAString = @"$GPGGA";
NSString * const kGPSNMEAProtocolTypeGPGLLString = @"$GPGLL";
NSString * const kGPSNMEAProtocolTypeGPGSAString = @"$GPGSA";
NSString * const kGPSNMEAProtocolTypeGPGSVString = @"$GPGSV";
NSString * const kGPSNMEAProtocolTypeGPRMCString = @"$GPRMC";
NSString * const kGPSNMEAProtocolTypeGPVTGString = @"$GPVTG";
NSString * const kGPSNMEAProtocolTypeGPZDAString = @"$GPZDA";
NSString * const kGPSNMEAProtocolTypeEndSuffix = @"#END";

@end
