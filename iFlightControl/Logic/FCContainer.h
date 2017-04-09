//
//  FCContainer.h
//  iFlightControl
//
//  Created by Admin on 08.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCContainer : NSObject

@property (nonatomic, readonly) NSArray <FCBLEDevice *> *devices;

- (void)addBLEDevice:(FCBLEDevice *)device;

- (BOOL)isBLEDeviceExist:(FCBLEDevice *)device;

+ (id)sharedInstance;

@end
