//
//  PokerBluPeripheral.m
//  PokerBlu
//
//  Created by Taylor Chavez on 9/5/23.
//

#import "PokerBluPeripheral.h"

@implementation PokerBluPeripheral

-(id) initWithPeripheral:(CBPeripheral *)peripheral
       andCharacteristic:(CBCharacteristic *)characteristic {
    self = [super init];
    if(self){
        _peripheral = peripheral;
        _characteristic = characteristic;
    }
    return self;
}

@end
