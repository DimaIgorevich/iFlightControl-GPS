//
//  FCBaseViewController.m
//  iFlightControl
//
//  Created by Admin on 08.04.17.
//  Copyright © 2017 MohylaUniversity. All rights reserved.
//

#import "FCBaseViewController.h"

@implementation FCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackButton];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)addBackButton {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:backButton];
}

@end
