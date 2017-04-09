//
//  FCEngine.h
//  iFlightControl
//
//  Created by Admin on 08.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FCObject.h"

@interface FCEngine : NSObject

@property (nonatomic, readonly) CBCentralManager *bluetoothManager;

@property (nonatomic, readonly) CBPeripheral *peripheral;

- (void)connectToPeripheral:(CBPeripheral *)peripheral;

+ (id)sharedInstance;

+ (NSArray *)arrayOfObjectsOfClass:(Class)obj_class fromJSON:(id)json;

+ (NSArray *)arrayOfObjectsOfClass:(Class)obj_class fromJSON:(id)json postIterationBlock:(void(^) (FCObject *obj))block;

@end
