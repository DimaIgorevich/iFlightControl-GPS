//
//  FCMainViewController.m
//  iFlightControl
//
//  Created by Admin on 08.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import "FCMainViewController.h"
#import "FCRadarViewController.h"

@interface FCMainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tvDevices;

@end

@implementation FCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBLEDeviceList) name:kUpdateBLEDeviceListNotification object:nil];
    [[FCEngine sharedInstance].bluetoothManager checkState];
}

#pragma mark - Notification Methods

- (void)updateBLEDeviceList {
    [self.tvDevices reloadData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kRadarStoryboard bundle:nil];
    FCRadarViewController *radarVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(FCRadarViewController.class)];
    radarVC.device = [[[FCContainer sharedInstance] devices] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:radarVC animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [FCContainer sharedInstance].devices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    FCBLEDevice *device = [[[FCContainer sharedInstance] devices] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = device.localName;
    
    return cell;
}

@end
