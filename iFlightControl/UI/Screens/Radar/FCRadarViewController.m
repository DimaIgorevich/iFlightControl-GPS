//
//  FCRadarViewController.m
//  iFlightControl
//
//  Created by Admin on 08.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import "FCRadarViewController.h"

@interface FCRadarViewController ()

@end

@implementation FCRadarViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = self.device.localName;
    [[FCEngine sharedInstance] connectToPeripheral:self.device.peripheral];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


@end