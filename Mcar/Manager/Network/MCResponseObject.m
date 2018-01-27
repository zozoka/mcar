//
//  MCResponseObject.m
//  BaseProject
//
//  Created by Tinhvv on 8/12/16.
//  Copyright © 2016 Tinhvv. All rights reserved.
//

#import "MCResponseObject.h"

@implementation MCResponseObject
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{ @"message" : @"message",
                                                        @"data" : @"responseData",
                                                        @"error" : @"error",
                                                        }];
}

+ (MCResponseObject *)responseObjectWithResponse:(NSHTTPURLResponse *)response
                                  responseObject:(id)responseObject
                                           error:(NSError *)error {
    MCResponseObject *obj = nil;
    NSMutableDictionary* responseDict;
    //    NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        responseDict = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary*)responseObject];
    }
    
    if (responseDict) {
        NSMutableDictionary *mInfo = [[NSMutableDictionary alloc] initWithDictionary:responseDict];
        id resultData = [mInfo objectForKey:@"data"];
        if (resultData) {
            if ([resultData isKindOfClass:[NSArray class]]) {
                if (!((NSArray *)resultData).count) {
                    resultData = @{};
                    [mInfo setObject:resultData forKey:@"data"];
                }
            }
        }
        
        NSError *parserError = nil;
        obj = [[MCResponseObject alloc] initWithDictionary:mInfo error:&parserError];
        obj.errorException = error ? error : parserError;
        obj.statusCode = @(response.statusCode);
    }
    
    return obj;
}
@end
