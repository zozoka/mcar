//
//  DirectGarageMapVC.h
//  Mcar
//
//  Created by thanh tung on 10/13/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBaseVC.h"
#import "GarageDetailJsonModel.h"
#import "AppDelegate.h"
@import GoogleMaps;

@interface DirectGarageMapVC : MCBaseVC
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *titleGarageLabel;
@property (strong, nonatomic)GarageDetailJsonModel *garageModel;

@end
