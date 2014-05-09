//
//  ViewController.m
//  teslaapitest
//
//  Created by tflack on 5/1/14.
//  Copyright (c) 2014 Idynomite Media. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize textBox;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
/*
	NSHTTPCookieStorage * sharedCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
	NSArray * cookies = [sharedCookieStorage cookies];
	for (NSHTTPCookie * cookie in cookies){
		NSLog(@"%@",cookie.domain);
		NSLog(@"deleting");
		[sharedCookieStorage deleteCookie:cookie];
	}
*/
    
    tApi = [[TeslaApi alloc] init];
	[tApi doLoginWithUserName:@"TESLAEMAIL" andPassword:@"TESLAPASSWORD" andCompletionBlock:^(NSArray *vehicles) {
		NSLog(@"Logged In %@",vehicles);
	} andErrorBlock:^(NSError *error) {
		NSLog(@"Log In Error %@",error);
	}];
}

- (IBAction)chargeStateTouched:(id)sender {
    [tApi chargeStateWithCompletionBlock:^(NSArray *chargeInfo) {
        NSLog(@"Charge Info %@",chargeInfo);
        [self updateTextBox:chargeInfo];
    } andErrorBlock:^(NSError *error) {
        NSLog(@"Error Getting Charge State %@",error);
    } ];
}

- (IBAction)vehicleListTouched:(id)sender {
    [tApi listVehiclesWithCompletionBlock:^(NSArray *vehicles) {
        NSLog(@"VEHICLE: %@",vehicles);
        [self updateTextBox:vehicles];
    } andErrorBlock:^(NSError *error) {
        NSLog(@"ERROR: %@",error);
    }];
}

- (IBAction)vehicleStateTouched:(id)sender {
    [tApi vehicleStateWithCompletionBlock:^(NSArray *data) {
        NSLog(@"Data: %@",data);
        [self updateTextBox:data];
    } andErrorBlock:^(NSError *error) {
        NSLog(@"ERROR: %@",error);
    }];
}

- (IBAction)vehicleStatusTouched:(id)sender {
    [tApi statusWithCompletionBlock:^(NSArray *data) {
        NSLog(@"Data: %@",data);
        [self updateTextBox:data];
    } andErrorBlock:^(NSError *error) {
        NSLog(@"ERROR: %@",error);
    }];
}

- (IBAction)climateStateTouched:(id)sender {
    [tApi climateStateWithCompletionBlock:^(NSArray *data) {
        NSLog(@"Data: %@",data);
        [self updateTextBox:data];
    } andErrorBlock:^(NSError *error) {
        NSLog(@"ERROR: %@",error);
    }];
}

- (IBAction)guiSettingsTouched:(id)sender {
    [tApi guiSettingsWithCompletionBlock:^(NSArray *data) {
        NSLog(@"Data: %@",data);
        [self updateTextBox:data];
    } andErrorBlock:^(NSError *error) {
        NSLog(@"ERROR: %@",error);
    }];
}

- (IBAction)openChargePortTouched:(id)sender {
    [tApi chargePortDoorOpenWithCompletionBlock:^(NSArray *data) {
        NSLog(@"Data: %@",data);
        [self updateTextBox:data];
    } andErrorBlock:^(NSError *error) {
        NSLog(@"ERROR: %@",error);
    }];
}

- (IBAction)flashLightsTouched:(id)sender {
    [tApi flashLightsWithCompletionBlock:^(NSArray *data) {
        NSLog(@"Data: %@",data);
        [self updateTextBox:data];
    } andErrorBlock:^(NSError *error) {
        NSLog(@"ERROR: %@",error);
    }];
}

- (IBAction)honkHornTouched:(id)sender {
    [tApi honkHornWithCompletionBlock:^(NSArray *data) {
        NSLog(@"Data: %@",data);
        [self updateTextBox:data];
    } andErrorBlock:^(NSError *error) {
        NSLog(@"ERROR: %@",error);
    }];
}

- (IBAction)doorLockTouched:(id)sender {
    [tApi doorLockWithCompletionBlock:^(NSArray *data) {
        NSLog(@"Data: %@",data);
        [self updateTextBox:data];
    } andErrorBlock:^(NSError *error) {
        NSLog(@"ERROR: %@",error);
    }];
}

- (IBAction)doorUnlockTouched:(id)sender {
    [tApi doorUnLockWithCompletionBlock:^(NSArray *data) {
        NSLog(@"Data: %@",data);
        [self updateTextBox:data];
    } andErrorBlock:^(NSError *error) {
        NSLog(@"ERROR: %@",error);
    }];
}

- (IBAction)chargeStandardTouched:(id)sender {
    [tApi chargeStandardWithCompletionBlock:^(NSArray *data) {
        NSLog(@"Data: %@",data);
        [self updateTextBox:data];
    } andErrorBlock:^(NSError *error) {
        NSLog(@"ERROR: %@",error);
    }];
}

- (IBAction)startChargeTouched:(id)sender {
    [tApi chargeStartWithCompletionBlock:^(NSArray *data) {
        NSLog(@"Data: %@",data);
        [self updateTextBox:data];
    } andErrorBlock:^(NSError *error) {
        NSLog(@"ERROR: %@",error);
    }];
}

- (IBAction)stopChargeTouched:(id)sender {
    [tApi chargeStopWithCompletionBlock:^(NSArray *data) {
        NSLog(@"Data: %@",data);
        [self updateTextBox:data];
    } andErrorBlock:^(NSError *error) {
        NSLog(@"ERROR: %@",error);
    }];
}

- (void) updateTextBox:(NSArray *)data {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                       options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [textBox setText:jsonString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
