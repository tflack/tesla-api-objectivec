//
//  TeslaApi.m
//  teslaapitest
//
//  Created by Tim Flack on 5/3/14.
//  Copyright (c) 2014 Idynomite Media. All rights reserved.
//

#import "TeslaApi.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"
#import "AFURLResponseSerialization.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation TeslaApi

-(id)initWithUserName:(NSString *)userName andPassword:(NSString *)password {
    baseUrl = @"https://portal.vn.teslamotors.com/";
    manager = [AFHTTPRequestOperationManager manager];
    
    if(![self hasValidCredentialCookie]){
        //Create the session, which will save the session cookie
        [self createSessionWithCompletionBlock:^{
            NSDictionary *params = @{@"user_session[email]": userName,
                                     @"user_session[password]": password};
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html", nil];
            manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
            
            NSString *callUrl = [baseUrl stringByAppendingString:@"login"];
            
            [manager POST:callUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                loggedIn = YES;
                [self listVehiclesWithCompletionBlock:^(NSArray *vehicles) {
                    NSArray *firstVehicle = [vehicles objectAtIndex:0];
                    vehicleId = [[firstVehicle valueForKey:@"id"] intValue];
                    NSLog(@"VEHICLE ID IS: %d",(int)vehicleId);
                } andErrorBlock:^(NSError *error) {
                    NSLog(@"ERROR Getting Vehicles: %@",error);
                    vehicleId = 0;
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                loggedIn = NO;
            }];
        } andErrorBlock:^(NSError *error) {
            NSLog(@"Error Logging In %@",error);
            loggedIn = NO;
        }];
    }else{
        [self listVehiclesWithCompletionBlock:^(NSArray *vehicles) {
            NSArray *firstVehicle = [vehicles objectAtIndex:0];
            vehicleId = [[firstVehicle valueForKey:@"id"] intValue];
            NSLog(@"VEHICLE ID IS: %d",(int)vehicleId);
        } andErrorBlock:^(NSError *error) {
            NSLog(@"ERROR Getting Vehicles: %@",error);
            vehicleId = 0;
        }];
    }
    return self;
}

-(BOOL)hasValidCredentialCookie{
    //Do we the user credential cookie for the domain and is it still valid?
	NSHTTPCookieStorage * sharedCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
	NSArray * cookies = [sharedCookieStorage cookiesForURL:[NSURL URLWithString:baseUrl]];
	for (NSHTTPCookie * cookie in cookies){
        NSLog(@"%@",cookie.name);
        if([cookie.name isEqualToString:@"user_credentials"]){
            NSDate *expiresDate =    [cookie expiresDate];
            NSDate *currentDate = [NSDate date];
            NSComparisonResult result = [currentDate compare:expiresDate];
            if(result==NSOrderedAscending){
                NSLog(@"expiresDate is in the future");
                return YES;
            }
            else if(result==NSOrderedDescending){
                NSLog(@"Credentials expired!");
                return NO;
            }
            else{
                NSLog(@"Credentials Will Expire Before Next Call!");
                return NO;
            }
        }
	}
    return NO;
}

-(void)createSessionWithCompletionBlock:(void(^)())blkCompletion andErrorBlock:(void(^)(NSError *))blkError {
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html", nil];
    
	NSString *callUrl = [baseUrl stringByAppendingString:@"login"];
	[manager GET:callUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:operation.response.allHeaderFields forURL:[NSURL URLWithString:callUrl]];
		NSLog(@"Session Token Creation Cookies: %@", cookies);
        blkCompletion();
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"Error: %@", error);
        blkError(error);
	}];
}

-(void)listVehiclesWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles"] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}


-(void)chargeStateWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles/%d/command/charge_state",(int)vehicleId] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}

-(void)statusWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles/%d/command/mobile_enabled",(int)vehicleId] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}

-(void)climateStateWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles/%d/command/climate_state",(int)vehicleId] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}

-(void)guiSettingsWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles/%d/command/gui_settings",(int)vehicleId] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}

-(void)vehicleStateWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles/%d/command/vehicle_state",(int)vehicleId] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}

-(void)chargePortDoorOpenWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles/%d/command/charge_port_door_open",(int)vehicleId] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}

-(void)chargeStandardWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles/%d/command/charge_standard",(int)vehicleId] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}

-(void)setChargeLimit:(NSInteger *)percent withCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles/%d/command/set_charge_limit?percent=%d",(int)vehicleId,(int)percent] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}

-(void)chargeStartWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles/%d/command/charge_start",(int)vehicleId] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}

-(void)chargeStopWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles/%d/command/charge_stop",(int)vehicleId] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}

-(void)flashLightsWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles/%d/command/flash_lights",(int)vehicleId] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}

-(void)honkHornWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles/%d/command/honk_horn",(int)vehicleId] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}

-(void)doorLockWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles/%d/command/door_lock",(int)vehicleId] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}

-(void)doorUnLockWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles/%d/command/door_unlock",(int)vehicleId] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}

-(void)setTemps:(NSInteger *)driverDegC passenger:(NSInteger *)passengerDegC withCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles/%d/command/set_temps?drive_temp=%d&passenger_temp=%d",(int)vehicleId,(int)driverDegC,(int)passengerDegC] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}

-(void)autoConditioningStartWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles/%d/command/auto_conditioning_start",(int)vehicleId] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}

-(void)autoConditioningStopWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles/%d/command/auto_conditioning_stop",(int)vehicleId] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}

-(void)sunRoofControl:(NSString *)state  withCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError{
    [self apiGet:[NSString stringWithFormat:@"vehicles/%d/command/sun_roof_control?state=%@",(int)vehicleId,state] withCompletionBlock:^(NSArray *returnArray) {
        completionBlock(returnArray);
    } andErrorBlock:^(NSError *error) {
        blkError(error);
    }];
}

-(void)apiGet:(NSString *)api withCompletionBlock:(void(^)(NSArray *))blkCompletion andErrorBlock:(void(^)(NSError *))blkError {
   	manager.requestSerializer = [AFHTTPRequestSerializer serializer];
	manager.responseSerializer = [AFJSONResponseSerializer serializer];
	manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
	manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
	NSString *callUrl = [baseUrl stringByAppendingString:api];
	
	[manager GET:callUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		blkCompletion(responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"ERROR RETRIEVING, %@",api);
        blkError(error);
	}];
}

@end
