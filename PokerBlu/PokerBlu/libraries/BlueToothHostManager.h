//
//  BlueToothHostManager.h
//  PokerBlu
//
//  Created by Taylor Chavez on 8/6/23.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlueToothHostManager : NSObject  <CBPeripheralManagerDelegate>

@property (nonatomic, strong) CBPeripheralManager *peripheralManager;
@property (nonatomic, strong) NSString *serviceName;
@property (nonatomic, strong) NSString *serviceId;
@property (nonatomic, strong) NSString *characteristicId;

-(id)initWithName:(NSString *)serviceName;

@end

NS_ASSUME_NONNULL_END
