//
//  FCBluetoothManager.h
//  iFlightControl
//
//  Created by Admin on 09.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCBluetoothManager : NSObject

- (void)checkState;

- (void)connectToPeripheral:(CBPeripheral *)peripheral;

@end
