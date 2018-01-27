//
//  MCBaseVC.m
//  BaseProject
//
//  Created by Tinhvv on 4/20/16.
//  Copyright © 2016 Tinhvv. All rights reserved.
//

#import "MCBaseVC.h"

@interface MCBaseVC ()
@property (nonatomic, strong) MCNetworkManager *networkManager;
@property (nonatomic, strong) MCSession *session;
@end

@implementation MCBaseVC
- (void)viewDidLoad{
    [super viewDidLoad];
}

- (MCNetworkManager *) networkManager{
    if (!_networkManager) {
        _networkManager = [MCNetworkManager sharedService];
    }
    return _networkManager;
}

- (MCSession *) session {
    if (!_session) {
        _session = [MCSession sharedSession];
    }
    return _session;
}

@end
