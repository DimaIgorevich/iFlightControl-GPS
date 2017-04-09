//
//  FCEngine.m
//  iFlightControl
//
//  Created by Admin on 08.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import "FCEngine.h"

@interface FCEngine () {
    FCBluetoothManager *_bluetoothManager;
}

@end

@implementation FCEngine

+ (instancetype)sharedInstance {
    static FCEngine *instanceFCEngine = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        instanceFCEngine = [[self alloc] init];
    });
    
    return instanceFCEngine;
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

- (FCBluetoothManager *)bluetoothManager {
    if (!_bluetoothManager) {
        _bluetoothManager = [[FCBluetoothManager alloc] init];
    }
    return _bluetoothManager;
}

@end