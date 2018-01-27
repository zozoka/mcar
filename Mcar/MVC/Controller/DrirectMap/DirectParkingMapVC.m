//
//  DirectParkingMapVC.m
//  Mcar
//
//  Created by thanh tung on 10/17/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "DirectParkingMapVC.h"
#import "AppDelegate.h"

@interface DirectParkingMapVC ()

@end

@implementation DirectParkingMapVC
AppDelegate *appDelegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configMap];
    appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    CLLocation *destination = [[CLLocation alloc]initWithLatitude:[self.parkingJson.latitude floatValue] longitude:[self.parkingJson.longitude floatValue]];
    [self drawRoute:appDelegate.myLocation destination:destination];
    // Do any additional setup after loading the view from its nib.
}

- (void)configMap{
    [self.mapView clear];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:appDelegate.myLocation.coordinate.latitude
                                                            longitude:appDelegate.myLocation.coordinate.longitude
                                                                 zoom:15];
    self.mapView.camera = camera;
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.myLocationButton = YES;
    GMSMarker *marker = [[GMSMarker alloc] init];
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake([self.parkingJson.latitude floatValue],[self.parkingJson.longitude floatValue]);
    marker.position = position;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 28)];
    iconView.image = [UIImage imageNamed:@"logo-mcar-maps.png"];
    marker.iconView = iconView;
    marker.map = self.mapView;
    marker.opacity = 1;
    marker.title = self.parkingJson.address;
}

- (void)drawRoute:(CLLocation *)myOrigin destination:(CLLocation *)myDestination{
    [self fetchPolylineWithOrigin:myOrigin destination:myDestination completionHandler:^(GMSPolyline *polyline)
     {
         if(polyline){
             polyline.map = self.mapView;
             polyline.strokeColor = [UIColor blueColor];
             polyline.strokeWidth = 4.f;
         }
     }];
}

- (void)fetchPolylineWithOrigin:(CLLocation *)origin destination:(CLLocation *)destination completionHandler:(void (^)(GMSPolyline *))completionHandler{
    NSString *originString = [NSString stringWithFormat:@"%f,%f", origin.coordinate.latitude, origin.coordinate.longitude];
    NSString *destinationString = [NSString stringWithFormat:@"%f,%f", destination.coordinate.latitude, destination.coordinate.longitude];
    NSString *directionsAPI = @"https://maps.googleapis.com/maps/api/directions/json?";
    NSString *directionsUrlString = [NSString stringWithFormat:@"%@&origin=%@&destination=%@&mode=driving", directionsAPI, originString, destinationString];
    NSURL *directionsUrl = [NSURL URLWithString:directionsUrlString];
    
    
    NSURLSessionDataTask *fetchDirectionsTask = [[NSURLSession sharedSession] dataTaskWithURL:directionsUrl completionHandler:
                                                 ^(NSData *data, NSURLResponse *response, NSError *error)
                                                 {
                                                     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                     if(error)
                                                     {
                                                         if(completionHandler)
                                                             completionHandler(nil);
                                                         return;
                                                     }
                                                     
                                                     NSArray *routesArray = [json objectForKey:@"routes"];
                                                     
                                                     __block GMSPolyline *polyline = nil;
                                                     if ([routesArray count] > 0)
                                                     {
                                                         NSDictionary *routeDict = [routesArray objectAtIndex:0];
                                                         NSDictionary *routeOverviewPolyline = [routeDict objectForKey:@"overview_polyline"];
                                                         NSString *points = [routeOverviewPolyline objectForKey:@"points"];
                                                         dispatch_sync(dispatch_get_main_queue(), ^{
                                                             GMSPath *path = [GMSPath pathFromEncodedPath:points];
                                                             polyline = [GMSPolyline polylineWithPath:path];
                                                         });
                                                     }
                                                     
                                                     // run completionHandler on main thread
                                                     dispatch_sync(dispatch_get_main_queue(), ^{
                                                         if(completionHandler)
                                                             completionHandler(polyline);
                                                     });
                                                 }];
    [fetchDirectionsTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)closeButtonTap:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
