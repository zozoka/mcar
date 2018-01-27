//
//  MapCell.h
//  Mcar
//
//  Created by thanh tung on 9/22/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;

@interface MapCell : UITableViewCell
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@end
