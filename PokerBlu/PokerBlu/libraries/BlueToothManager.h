//
//  BlueToothManager.h
//  PokerBlu
//
//  Created by Taylor Chavez on 7/31/23.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>


NS_ASSUME_NONNULL_BEGIN

typedef void (^PeripheralListCompletion)(NSArray *list);


@interface BlueToothManager : NSObject <CBCentralManagerDelegate>

@property (strong, nonatomic) CBCentralManager *centralManager;
@property (strong, nonatomic) NSMutableArray *peripherals;
@property (nonatomic, copy) PeripheralListCompletion peripheralCompletion;

-(id) initWithCompletion:(PeripheralListCompletion) completion;

@end

NS_ASSUME_NONNULL_END
