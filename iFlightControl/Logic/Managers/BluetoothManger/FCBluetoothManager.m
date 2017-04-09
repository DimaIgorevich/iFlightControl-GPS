//
//  FCBluetoothManager.m
//  iFlightControl
//
//  Created by Admin on 09.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import "FCBluetoothManager.h"

@interface FCBluetoothManager () <CBCentralManagerDelegate, CBPeripheralDelegate, NMEAProtocolDelegate>

@property (strong, nonatomic) CBCentralManager *centralManager;

@property (strong, nonatomic) CBPeripheral *peripheral;

@property (strong, nonatomic) NSString *inputStream;

@end

@implementation FCBluetoothManager

#pragma mark - Lifecycle

- (id)init {
    if (self = [super init]) {
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        self.inputStream = [NSString stringWithFormat:@""];
    }
    return self;
}

- (void)checkState {
    [self.centralManager state];
}

- (void)connectToPeripheral:(CBPeripheral *)peripheral {
    self.peripheral = peripheral;
    peripheral.delegate = self;
    [self.centralManager connectPeripheral:peripheral options:nil];
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if ([central state] == CBCentralManagerStatePoweredOff) {
        [self.centralManager permissionViewWithMessage:@"CoreBluetooth BLE hardware is powered off"];
    }
    else if ([central state] == CBCentralManagerStatePoweredOn) {
        [self.centralManager infoViewWithMessage:@"CoreBluetooth BLE hardware is powered on and ready"];
        [self.centralManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES}];
    }
    else if ([central state] == CBCentralManagerStateUnauthorized) {
        [self.centralManager infoViewWithMessage:@"CoreBluetooth BLE state is unauthorized"];
    }
    else if ([central state] == CBCentralManagerStateUnknown) {
        [self.centralManager infoViewWithMessage:@"CoreBluetooth BLE state is unknown"];
    }
    else if ([central state] == CBCentralManagerStateUnsupported) {
        [self.centralManager infoViewWithMessage:@"CoreBluetooth BLE hardware is unsupported on this platform"];
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
    [self.centralManager stopScan];
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];
    if (peripheral.state == CBPeripheralStateConnected) {
        [self.centralManager infoViewWithMessage:@"Connected is successfully"];
    } else {
        [self.centralManager infoViewWithMessage:@"Connected is unsuccessfully"];
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

    if ([NSString stringWithUTF8String:[characteristic.value bytes]]) {
        self.inputStream = [self.inputStream stringByAppendingString:[NSString stringWithUTF8String:[characteristic.value bytes]]];
    }
    
    if ([self.inputStream rangeOfString:kGPSNMEAProtocolTypeEndSuffix].location != NSNotFound) {
        NSString *packageString = [self.inputStream substringWithRange:NSMakeRange(0, [self.inputStream rangeOfString:kGPSNMEAProtocolTypeEndSuffix].location + kGPSNMEAProtocolTypeEndSuffix.length)];
        self.inputStream = [self.inputStream substringFromIndex:packageString.length];
        
        packageString = [packageString stringByReplacingOccurrencesOfString:kGPSNMEAProtocolTypeEndSuffix withString:@""];
        
        if (![packageString isEqualToString:@""]) {
            [NMEAProtocol parseNMEAData:packageString delegate:self];
        }
        
    }
}

#pragma mark - NMEAProtocolDelegate

- (void)didFinishParseData:(NSArray *)data protocolType:(GPSNMEAProtocolType)protocolType {
    if (protocolType == GPSNMEAProtocolTypeGPGLL) {
        if ([[data objectAtIndex:GPGLLGroupSequanceGPSDataStatus - 1] isEqualToString:@"A"]) {
            CLLocation *deviceLocation = [CLLocation locationWithDMSCoordinate:CLLocationCoordinate2DMake([[data objectAtIndex:GPGLLGroupSequanceLatitude - 1] floatValue], [[data objectAtIndex:GPGLLGroupSequanceLongitude - 1] floatValue])];
            [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateDeviceLocationNotification
                                                                object:@{kDeviceLocation:deviceLocation}];
        }
    }
}

@end
