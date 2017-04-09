//
//  FCBLEDevice.h
//  iFlightControl
//
//  Created by Admin on 08.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import "FCObject.h"

@interface FCBLEDevice : FCObject

@property (nonatomic) BOOL isConnectable;
@property (nonatomic, copy) NSString *localName;
@property (nonatomic, copy) NSString *manufacturerData;
@property (nonatomic, copy) NSDictionary *serviceData;
@property (nonatomic, copy) NSArray *serviceUUIDs;
@property (nonatomic) NSInteger txPowerLevel;
@property (nonatomic, copy) NSNumber *RSSI;
@property (nonatomic, copy) CBPeripheral *peripheral;

@end
