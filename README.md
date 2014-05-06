tesla-api-objectivec
====================

ObjectiveC Wrapper For Tesla APIs

Install using cocoapods
====================

Include the following in your Podfile

pod 'TeslaApiObjectiveCWrapper'

In Your Project
====================

#import "TeslaApi.h"

in ViewDidLoad (or wherever you want to use it)

```
TeslaApi *tApi = [[TeslaApi alloc]initWithUserName:@"YOUREMAIL" andPassword:@"YOURPASSWORD"];

[tApi listVehiclesWithCompletionBlock:^(NSArray *vehicles) {
        NSLog(@"VEHICLE: %@",vehicles);
    } andErrorBlock:^(NSError *error) {
        NSLog(@"ERROR: %@",error);
    }];
```

Download the example project for exact usage






