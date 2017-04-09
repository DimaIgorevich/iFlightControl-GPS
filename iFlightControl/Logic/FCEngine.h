//
//  FCEngine.h
//  iFlightControl
//
//  Created by Admin on 08.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

@interface FCEngine : NSObject

@property (nonatomic, readonly) FCBluetoothManager *bluetoothManager;

+ (instancetype)sharedInstance;

+ (NSArray *)arrayOfObjectsOfClass:(Class)obj_class fromJSON:(id)json;

+ (NSArray *)arrayOfObjectsOfClass:(Class)obj_class fromJSON:(id)json postIterationBlock:(void(^) (FCObject *obj))block;

@end
