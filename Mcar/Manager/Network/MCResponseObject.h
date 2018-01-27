//
//  MCResponseObject.h
//  BaseProject
//
//  Created by Tinhvv on 8/12/16.
//  Copyright © 2016 Tinhvv. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface MCResponseObject : JSONModel
@property (strong, nonatomic) NSNumber <Ignore> *statusCode;
@property (strong, nonatomic) NSError <Ignore>*errorException;
@property (strong, nonatomic) id <Optional> responseData;
@property (strong, nonatomic) NSString <Optional>* message;
@property (strong, nonatomic) NSNumber <Optional>* error;
@property (strong, nonatomic) id <Optional> detail;


+ (MCResponseObject *)responseObjectWithResponse:(NSHTTPURLResponse *)response
                                  responseObject:(id)responseObject
                                           error:(NSError *)error;
@end
