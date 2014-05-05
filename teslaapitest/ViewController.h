//
//  ViewController.h
//  teslaapitest
//
//  Created by tflack on 5/1/14.
//  Copyright (c) 2014 Idynomite Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeslaApi.h"

@interface ViewController : UIViewController {
    TeslaApi *tApi;
}
@property (weak, nonatomic) IBOutlet UITextView *textBox;
- (IBAction)chargeStateTouched:(id)sender;
- (IBAction)vehicleListTouched:(id)sender;
- (IBAction)vehicleStateTouched:(id)sender;
- (IBAction)vehicleStatusTouched:(id)sender;
- (IBAction)climateStateTouched:(id)sender;
- (IBAction)guiSettingsTouched:(id)sender;
- (IBAction)openChargePortTouched:(id)sender;
- (IBAction)flashLightsTouched:(id)sender;
- (IBAction)honkHornTouched:(id)sender;
- (IBAction)doorLockTouched:(id)sender;
- (IBAction)doorUnlockTouched:(id)sender;
- (IBAction)chargeStandardTouched:(id)sender;
- (IBAction)startChargeTouched:(id)sender;
- (IBAction)stopChargeTouched:(id)sender;


@end
