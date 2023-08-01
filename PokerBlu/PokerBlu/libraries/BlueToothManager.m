//
//  BlueToothManager.m
//  PokerBlu
//
//  Created by Taylor Chavez on 7/31/23.
//

#import "BlueToothManager.h"

@implementation BlueToothManager


-(id) initWithCompletion:(PeripheralListCompletion) completion{
    self = [super init];
    if (self) {
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        _peripherals = @[].mutableCopy;
        _peripheralCompletion = completion;
    }
    return self;
}


- (void)centralManagerDidUpdateState:(nonnull CBCentralManager *)central {
    if (central.state == CBManagerStatePoweredOn) {
            // Bluetooth is powered on and ready to use
            // Start scanning for peripherals with the service UUID you're interested in
            // If you want to scan for all peripherals, pass nil as the first parameter
        [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    } else {
            // Handle other Bluetooth states if necessary
    }
}


- (void)addPeripheralToList:(CBPeripheral *)peripheral{
    if(peripheral.name == nil){
        return;
    }
    for(int i = 0; i < _peripherals.count; i++){
        CBPeripheral *curPeripheral = _peripherals[i];
        if(curPeripheral.identifier == peripheral.identifier){
            return;
        }
    }
    
    [_peripherals addObject:peripheral];
    _peripheralCompletion(_peripherals);
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    // This method will be called when a peripheral is discovered during scanning
    [self addPeripheralToList:peripheral];
    // You can check the peripheral's name or other advertisement data to identify the one you're interested in
    if ([peripheral.name isEqualToString:@"YourDesiredPeripheral"]) {
        // Stop scanning as you've found the peripheral you want
        [self.centralManager stopScan];
        
        // Connect to the peripheral to start interacting with it
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    // This method will be called when the central successfully connects to the peripheral
    NSLog(@"Connected to peripheral: %@", peripheral.name);
    
    // Now you can interact with the connected peripheral
    // For example, you can discover services and characteristics, read/write data, etc.
}


@end
