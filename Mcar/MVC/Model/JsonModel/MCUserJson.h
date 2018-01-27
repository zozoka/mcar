//
//  MCUserJson.h
//  BaseProject
//
//  Created by Tinhvv on 8/12/16.
//  Copyright © 2016 Tinhvv. All rights reserved.
//

#import "MCBaseJson.h"

@interface MCUserJson : MCBaseJson

/**
 *  Option 1: Use coding convention
 */
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString <Optional>*userName;
@property (nonatomic, strong) NSString *email;

/**
 *  Option 2: Quickly
 */
//@property (nonatomic, strong) NSString *id;
//@property (nonatomic, strong) NSString <Optional>*user_name;
//@property (nonatomic, strong) NSString *email;

@end
