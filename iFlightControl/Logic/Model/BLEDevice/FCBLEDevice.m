//
//  FCBLEDevice.m
//  iFlightControl
//
//  Created by Admin on 08.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import "FCBLEDevice.h"

@implementation FCBLEDevice

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super initWithDictionary:dictionary]) {
        self.isConnectable = [[dictionary objectForKey:kCBAdvDataIsConnectable] boolValue];
        self.localName = [dictionary objectForKey:kCBAdvDataLocalName];
        self.manufacturerData = [NSString stringWithFormat:@"%@", [dictionary objectForKey:kCBAdvDataManufacturerData]];
        self.serviceData = [dictionary objectForKey:kCBAdvDataServiceData];
        self.txPowerLevel = [[dictionary objectForKey:kCBAdvDataTxPowerLevel] integerValue];
    }
    return self;
}

@end
