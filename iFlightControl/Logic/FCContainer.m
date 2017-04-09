//
//  FCContainer.m
//  iFlightControl
//
//  Created by Admin on 08.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import "FCContainer.h"

@interface FCContainer () {
    NSArray *_devices;
}

@end

@implementation FCContainer

+ (instancetype)sharedInstance {
    static FCContainer *instanceFCContainer = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        instanceFCContainer = [[self alloc] init];
    });
    
    return instanceFCContainer;
}

#pragma mark - Getters

- (NSArray <FCBLEDevice *> *)devices {
    if (!_devices) {
        _devices = [NSArray array];
    }
    return _devices;
}

- (void)addBLEDevice:(FCBLEDevice *)device {
    NSMutableArray *mutableDeviceList = [NSMutableArray arrayWithArray:_devices];
    [mutableDeviceList addObject:device];
    _devices = nil;
    _devices = [NSArray arrayWithArray:[mutableDeviceList copy]];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateBLEDeviceListNotification object:nil];
}

- (BOOL)isBLEDeviceExist:(FCBLEDevice *)device {
    if (_devices.count > 0) {
        for (FCBLEDevice *deviceInList in _devices) {
            if ([deviceInList.manufacturerData isEqualToString:device.manufacturerData]) {
                return YES;
            }
        }
    }
    return NO;
}

@end
