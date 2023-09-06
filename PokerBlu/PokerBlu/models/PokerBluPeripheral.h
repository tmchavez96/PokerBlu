//
//  PokerBluPeripheral.h
//  PokerBlu
//
//  Created by Taylor Chavez on 9/5/23.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>


NS_ASSUME_NONNULL_BEGIN

@interface PokerBluPeripheral : NSObject

@property (strong, nonatomic) CBPeripheral *peripheral;
@property (strong, nonatomic) CBCharacteristic *characteristic;

-(id) initWithPeripheral:(CBPeripheral *)peripheral
       andCharacteristic:(CBCharacteristic *)characteristic;

@end

NS_ASSUME_NONNULL_END
