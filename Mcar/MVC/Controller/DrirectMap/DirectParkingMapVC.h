//
//  DirectParkingMapVC.h
//  Mcar
//
//  Created by thanh tung on 10/17/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParkingJsonModel.h"
@import GoogleMaps;

@interface DirectParkingMapVC : UIViewController
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong ,nonatomic) ParkingJsonModel *parkingJson;
@end
