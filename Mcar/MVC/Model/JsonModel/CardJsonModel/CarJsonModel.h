//
//  CarJsonModel.h
//  Mcar
//
//  Created by thanh tung on 11/8/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "CarBrandsJsonModel.h"

@interface CarJsonModel : JSONModel
@property (strong,nonatomic) NSNumber<Optional> *idCar;
@property (strong,nonatomic) NSString<Optional> *name;
@property (strong,nonatomic) NSString<Optional> *manufacture_year;
@property (strong,nonatomic) NSString<Optional> *color;
@property (strong,nonatomic) NSNumber<Optional> *user_id;
@property (strong,nonatomic) NSString<Optional> *created_at;
@property (strong,nonatomic) NSString<Optional> *updated_at;
@property (strong,nonatomic) NSString<Optional> *license_plate;
@property (strong,nonatomic) NSString<Optional> *vin;
@property (strong,nonatomic) NSString<Optional> *car_number;
@property (strong,nonatomic) NSString<Optional> *avatar;
@property (strong,nonatomic) NSString<Optional> *type;
@property (strong,nonatomic) CarBrandsJsonModel<Optional> *brand;
@end
//"data": [
//         {
//             "id": 6,
//             "name": "das",
//             "manufacture_year": 213213,
//             "color": "adsasas",
//             "user_id": 20,
//             "created_at": "2017-09-20 14:27:42",
//             "updated_at": "2017-09-20 14:27:42",
//             "license_plate": "asdas",
//             "vin": "dasdasd",
//             "car_number": "asdasd",
//             "avatar": "http://192.168.0.161:8999/mcar/api/image/car_avatar/_2y_10_tfpYURq4vQU_ph8nNXfqbuykeaoejq8wOvytosjW0regNx4q5ZgFK.png",
//             "type": "dasdas",
//             "brand": [
//                       {
//                           "id": 1,
//                           "name": "Acura",
//                           "created_at": null,
//                           "updated_at": null,
//                           "created_user": null,
//                           "updated_user": null,
//                           "pivot": {
//                               "user_car_id": 6,
//                               "car_brand_id": 1
//                           }
//                       }
//                       ]
//         },

