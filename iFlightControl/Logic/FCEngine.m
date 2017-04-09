//
//  FCEngine.m
//  iFlightControl
//
//  Created by Admin on 08.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import "FCEngine.h"

@interface FCEngine () <CBCentralManagerDelegate, CBPeripheralDelegate> {
    CBCentralManager *_bluetoothManager;
    CBPeripheral *_peripheral;
    NSString *_buffer;
}

@end

@implementation FCEngine

+ (id)sharedInstance {
    static FCEngine *instanceFCEngine = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        instanceFCEngine = [[self alloc] init];
    });
    
    return instanceFCEngine;
}

- (void)connectToPeripheral:(CBPeripheral *)peripheral {
    _peripheral = peripheral;
    peripheral.delegate = self;
    [_bluetoothManager connectPeripheral:peripheral options:nil];
}

#pragma mark - Fabric

+ (NSArray *)arrayOfObjectsOfClass:(Class)obj_class fromJSON:(id)json {
    return [FCEngine arrayOfObjectsOfClass:obj_class fromJSON:json postIterationBlock:nil];
}

+ (NSArray *)arrayOfObjectsOfClass:(Class)obj_class fromJSON:(id)json postIterationBlock:(void(^) (FCObject *obj))block {
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSDictionary *info in json) {
        FCObject *obj = [[obj_class alloc] initWithDictionary:info];
        [result addObject:obj];
        if (block) {
            block(obj);
        }
    }
    
    return result.count > 0 ? result : nil;
}

#pragma mark - Getters

- (CBCentralManager *)bluetoothManager {
    if (!_bluetoothManager) {
        _bluetoothManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return _bluetoothManager;
}

- (CBPeripheral *)peripheral {
    return  _peripheral;
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if ([central state] == CBCentralManagerStatePoweredOff) {
        [_bluetoothManager permissionViewWithMessage:@"CoreBluetooth BLE hardware is powered off"];
    }
    else if ([central state] == CBCentralManagerStatePoweredOn) {
        [_bluetoothManager infoViewWithMessage:@"CoreBluetooth BLE hardware is powered on and ready"];
        [[[FCEngine sharedInstance] bluetoothManager] scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES}];
    }
    else if ([central state] == CBCentralManagerStateUnauthorized) {
        [_bluetoothManager infoViewWithMessage:@"CoreBluetooth BLE state is unauthorized"];
    }
    else if ([central state] == CBCentralManagerStateUnknown) {
        [_bluetoothManager infoViewWithMessage:@"CoreBluetooth BLE state is unknown"];
    }
    else if ([central state] == CBCentralManagerStateUnsupported) {
        [_bluetoothManager infoViewWithMessage:@"CoreBluetooth BLE hardware is unsupported on this platform"];
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    FCBLEDevice *device = [[FCBLEDevice alloc] initWithDictionary:advertisementData];
    if (![[FCContainer sharedInstance] isBLEDeviceExist:device]) {
        device.RSSI = RSSI;
        device.peripheral = peripheral;
        [[FCContainer sharedInstance] addBLEDevice:device];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];
    if (peripheral.state == CBPeripheralStateConnected) {
        [self.bluetoothManager infoViewWithMessage:@"Connected is successfully"];
    } else {
        [self.bluetoothManager infoViewWithMessage:@"Connected is unsuccessfully"];
    }
}

#pragma mark - CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    for (CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error {
    if ([service.UUID isEqual:[CBUUID UUIDWithString:kBLEHMSoftServiceUUID]]) {
        for (CBCharacteristic *characteristic in service.characteristics) {
            [self.peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error {
    if (!_buffer) {
        _buffer = [NSString stringWithFormat:@""];
    }
    
    if ([NSString stringWithUTF8String:[characteristic.value bytes]]) {
        _buffer = [_buffer stringByAppendingString:[NSString stringWithUTF8String:[characteristic.value bytes]]];
    }
    
    if ([_buffer rangeOfString:kGPSNMEAProtocolTypeEndSuffix].location != NSNotFound) {
        NSString *protocolString = [_buffer substringWithRange:NSMakeRange(0, [_buffer rangeOfString:kGPSNMEAProtocolTypeEndSuffix].location + kGPSNMEAProtocolTypeEndSuffix.length)];
        _buffer = [_buffer substringFromIndex:protocolString.length];
        
        protocolString = [protocolString stringByReplacingOccurrencesOfString:kGPSNMEAProtocolTypeEndSuffix withString:@""];
        
        if (![protocolString isEqualToString:@""]) {
            [NMEAProtocol parseNMEAData:protocolString];
        }
        
    }
}

@end