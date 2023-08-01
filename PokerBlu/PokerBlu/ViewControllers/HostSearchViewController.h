//
//  HostSearchViewController.h
//  PokerBlu
//
//  Created by Taylor Chavez on 7/30/23.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BlueToothManager.h"


NS_ASSUME_NONNULL_BEGIN

@interface HostSearchViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *table;
@property (strong, nonatomic) NSMutableArray *content;
@property (strong, nonatomic) BlueToothManager *btm;

@end

NS_ASSUME_NONNULL_END
