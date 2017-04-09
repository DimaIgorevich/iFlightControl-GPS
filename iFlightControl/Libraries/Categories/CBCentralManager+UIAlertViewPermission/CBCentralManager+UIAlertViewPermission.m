//
//  CBCentralManager+UIAlertViewPermission.m
//  iFlightControl
//
//  Created by Admin on 08.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import "CBCentralManager+UIAlertViewPermission.h"

NSInteger const CBCentralManagerBluetoothSettingButtonIndex = 1;

@implementation CBCentralManager (UIAlertViewPermission)

- (void)infoViewWithMessage:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"Dismiss", nil) otherButtonTitles:nil] show];
}

- (void)permissionViewWithMessage:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"Dismiss", nil) otherButtonTitles:NSLocalizedString(@"Settings", nil), nil] show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0) {
    if (CBCentralManagerBluetoothSettingButtonIndex == buttonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=Bluetooth"]];
    }
}

@end
