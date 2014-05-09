//
//  TeslaApi.h
//  teslaapitest
//
//  Created by Tim Flack on 5/3/14.
//  Copyright (c) 2014 Idynomite Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperationManager;

@interface TeslaApi : NSObject {
    @public
    AFHTTPRequestOperationManager *manager;
    NSString *baseUrl;
    BOOL loggedIn;
}

@property (strong, nonatomic) NSNumber *vehicleId;

-(BOOL)hasValidCredentialCookie;
-(void)doLoginWithUserName:(NSString *)userName andPassword:(NSString *)password andCompletionBlock:(void(^)(NSArray *))blkCompletion andErrorBlock:(void(^)(NSError *))blkError;
-(void)listVehiclesWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)vehicleTelemetryStatusWithCompletionBlock:(void(^)(NSString *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)wakeUpWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)chargeStateWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)statusWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)climateStateWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)guiSettingsWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)vehicleStateWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)chargePortDoorOpenWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)chargeStandardWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)setChargeLimit:(NSInteger *)percent withCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)chargeStartWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)chargeStopWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)flashLightsWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)honkHornWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)doorLockWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)doorUnLockWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)setTemps:(NSInteger *)driverDegC passenger:(NSInteger *)passengerDegC withCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)autoConditioningStartWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)autoConditioningStopWithCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)sunRoofControl:(NSString *)state  withCompletionBlock:(void(^)(NSArray *))completionBlock andErrorBlock:(void(^)(NSError *))blkError;
-(void)unlink;
@end
