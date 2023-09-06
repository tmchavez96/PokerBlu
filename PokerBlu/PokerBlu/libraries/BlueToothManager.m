//
//  BlueToothManager.m
//  PokerBlu
//
//  Created by Taylor Chavez on 7/31/23.
//

#import "BlueToothManager.h"
#import "PlayerState.h"
#import "PokerBluPeripheral.h"



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


- (void)addPeripheralToList:(CBPeripheral *)peripheral
          advertisementData:(NSDictionary<NSString *, id> *)advertisementData{
    if(![(NSString *)[advertisementData objectForKey:@"kCBAdvDataLocalName"] isEqualToString:@"PokerBluSession"]){
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
    if([(NSString *)[advertisementData objectForKey:@"kCBAdvDataLocalName"] isEqualToString:@"PokerBluSession"]){
        NSLog(@"Discovered Nearby poker blue session");
        NSLog(@"%@",advertisementData);
        NSLog(@"peripheral name / id  = %@ / %@",peripheral.name, peripheral.identifier);
    }
    // This method will be called when a peripheral is discovered during scanning
    [self addPeripheralToList:peripheral
            advertisementData:advertisementData];
    // You can check the peripheral's name or other advertisement data to identify the one you're interested in
    if ([peripheral.name isEqualToString:@"YourDesiredPeripheral"]) {
        // Stop scanning as you've found the peripheral you want
        [self.centralManager stopScan];
        // Connect to the peripheral to start interacting with it
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}

//
- (BOOL)connectToPeripheral:(CBPeripheral *)peripheral {
    [self.centralManager connectPeripheral:peripheral options:nil];
    [self.centralManager stopScan];
    return YES;
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    // This method will be called when the central successfully connects to the peripheral
    NSLog(@"Connected to peripheral: %@", peripheral.name);
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
    // Now you can interact with the connected peripheral
    // For example, you can discover services and characteristics, read/write data, etc.
}


- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    NSLog(@"Discovered services");
    if(error != nil){
        NSLog(@"error discovering service %@",error.localizedDescription);
    }
    for(int i = 0; i < peripheral.services.count; i++){
        CBService *curService = peripheral.services[i];
        [peripheral discoverCharacteristics:nil forService:curService];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    
    NSLog(@"Discovered chars");
    if (error) {
        NSLog(@"Error discovering characteristics: %@", error);
        return;
    }
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"08590F7E-DB05-467E-8757-72F6FAEB13D4"]]) {
            // Read from the characteristic
            [peripheral readValueForCharacteristic:characteristic];
            
//            // Write to the characteristic
//            NSData *dataToSend = [@"Hello, Peripheral!" dataUsingEncoding:NSUTF8StringEncoding];
//            [peripheral writeValue:dataToSend forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
//            NSLog(@"write to char");
            // save the current characteristic oif its our desired characteristic
            _curCharacteristic = characteristic;
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"Error reading characteristic value: %@", error);
        return;
    }
    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"08590F7E-DB05-467E-8757-72F6FAEB13D4"]]) {
        // Process the data read from the characteristic
        NSData *data = characteristic.value;
        NSString *receivedString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Received data: %@", receivedString);
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"Error writing characteristic value: %@", error);
        return;
    }
    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"YOUR_CHARACTERISTIC_UUID"]]) {
        NSLog(@"Data sent successfully.");
    }
}


-(BOOL)writeToPeripheral:(CBPeripheral *)peripheral
                 message:(NSString *) message {
    NSDictionary *messageDict = @{
        @"type":@"message",
        @"message":message
    };
    NSData *fullData = [NSKeyedArchiver archivedDataWithRootObject:messageDict requiringSecureCoding:NO error:nil];
    NSMutableArray<NSData *> *packets = @[].mutableCopy;
    NSInteger maxLength = 20; // Maximum packet size
    for (NSInteger offset = 0; offset < fullData.length; offset += maxLength) {
        NSInteger length = MIN(fullData.length - offset, maxLength);
        NSData *curPacket = [fullData subdataWithRange:NSMakeRange(offset, length)];
        [packets addObject:curPacket];
    }
    // first send a packet
    NSString *headerMessage = [NSString stringWithFormat: @"h:%lu", (unsigned long)packets.count];
    [peripheral writeValue: [headerMessage dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:_curCharacteristic type:CBCharacteristicWriteWithResponse];
    for (int i = 0; i < packets.count; i++){
        NSData *currentPacket = packets[i];
        [peripheral writeValue:currentPacket forCharacteristic:_curCharacteristic type:CBCharacteristicWriteWithResponse];
    }
    return YES;
}

@end
