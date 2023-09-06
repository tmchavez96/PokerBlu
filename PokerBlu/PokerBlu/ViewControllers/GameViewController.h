//
//  GameViewController.h
//  PokerBlu
//
//  Created by Taylor Chavez on 9/5/23.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "PokerBluPeripheral.h"
#import "BlueToothManager.h"



NS_ASSUME_NONNULL_BEGIN

@interface GameViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) BlueToothManager *btm;

-(id) initWithConnection:(CBPeripheral *) peripheral
        andManager:(BlueToothManager *)btm;


@end

NS_ASSUME_NONNULL_END
