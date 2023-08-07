//
//  BlueToothHostManager.m
//  PokerBlu
//
//  Created by Taylor Chavez on 8/6/23.
//

#import "BlueToothHostManager.h"

@implementation BlueToothHostManager


-(instancetype)initWithName:(NSString *)serviceName{

    self = [super init];
    if (self) {
        self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
        _serviceId = @"E20A39F4-73F5-4BC4-A12F-17D1AD07A961";//[BlueToothHostManager getServiceID];
        _characteristicId = @"08590F7E-DB05-467E-8757-72F6FAEB13D4";//[BlueToothHostManager getServiceID];
        _serviceName = serviceName;
    }
    return self;
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state == CBManagerStatePoweredOn) {
        // Bluetooth is powered on and ready to use
        // Start advertising your services
        [self startAdvertising];
    } else {
        // Handle other Bluetooth states if necessary
    }
}


+(NSString *)getServiceID {
//  NSString *base = @"XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX";
//  NSString *generic = @"00001800-0000-1000-8000-00805F9B34FB";
    NSString *generic = @"AFAF1010-3131-1341-8081-00805F9B34FB";
    NSInteger randomCalc = 111111111111;
    int r = arc4random_uniform(1000000);
    
    NSString *rv = [@"AFAF1010-3131-1341-8081-" stringByAppendingFormat:@"%ld",r+randomCalc];
    return rv;
}

- (void)startAdvertising {
    // Create a service and characteristic
    // CBUUID *serviceUUID = [CBUUID UUIDWithString:@"YOUR_SERVICE_UUID"];
    CBUUID *serviceUUID = [CBUUID UUIDWithString:_serviceId];

    CBMutableService *service = [[CBMutableService alloc] initWithType:serviceUUID primary:YES];
    
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:_characteristicId];
    
    CBMutableCharacteristic *characteristic = [[CBMutableCharacteristic alloc] initWithType:characteristicUUID properties:CBCharacteristicPropertyRead | CBCharacteristicPropertyWrite value:nil permissions: CBAttributePermissionsReadable | CBAttributePermissionsWriteable ];

    
    service.characteristics = @[characteristic];
    
    // Add the service to the peripheral manager
    [self.peripheralManager addService:service];
    
    // Start advertising the service
    NSDictionary *advertisementData = @{CBAdvertisementDataServiceUUIDsKey: @[serviceUUID],CBAdvertisementDataLocalNameKey: _serviceName };
    [self.peripheralManager startAdvertising:advertisementData];
}

// Implement other delegate methods as needed
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error {
    NSLog(@"did start advertising");
    if(error != nil){
        NSLog(@"did start advertising %@",error.localizedDescription);
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request {
    
}

-(void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray<CBATTRequest *> *)requests {
    
}

@end
