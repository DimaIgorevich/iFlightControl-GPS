//
//  CBCentralManager+UIAlertViewPermission.h
//  iFlightControl
//
//  Created by Admin on 08.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

#import <UIKit/UIKit.h>

@interface CBCentralManager (UIAlertViewPermission) <UIAlertViewDelegate>

- (void)infoViewWithMessage:(NSString *)message;

- (void)permissionViewWithMessage:(NSString *)message;

@end
