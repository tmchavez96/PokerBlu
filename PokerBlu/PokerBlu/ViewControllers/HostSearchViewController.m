//
//  HostSearchViewController.m
//  PokerBlu
//
//  Created by Taylor Chavez on 7/30/23.
//

#import "HostSearchViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface HostSearchViewController ()

@end

@implementation HostSearchViewController

NSString  *_Nullable kHostDefaultCellIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _content = [[NSMutableArray alloc] initWithArray:@[]];
    _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];

    _table.delegate = self;
    _table.dataSource = self;
    
    
    [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:kHostDefaultCellIdentifier];
    
    
    [self.view addSubview: _table];
    [_table reloadData];
    
    __weak typeof(self) weakSelf = self;
    _btm = [[BlueToothManager alloc] initWithCompletion:^(NSArray * _Nonnull list) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf->_content = list.mutableCopy;
        [strongSelf->_table reloadData];
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
       
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHostDefaultCellIdentifier forIndexPath:indexPath];
       
    if (cell == nil) {
           // If there were no cells available in the reuse pool, create a new cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kHostDefaultCellIdentifier];
    }
     
    CBPeripheral *curPeripheral = _content[indexPath.row];
    if(curPeripheral){
        NSString *curName = curPeripheral.name ?: @"(ghost)";
        NSString *rowText = [[@(indexPath.row) stringValue] stringByAppendingFormat:@") %@ - %@",curName, [self stateToString: curPeripheral.state]];
        [cell.textLabel setText:rowText];
    }
    return cell;
}


-(NSString *)stateToString:(CBPeripheralState ) state{
    switch(state){
        case CBPeripheralStateConnected:
            return @"Connected";
        case CBPeripheralStateDisconnected:
            return @"Disconnected";
        case CBPeripheralStateConnecting:
            return @"Connecting";
        case CBPeripheralStateDisconnecting:
            return @"Disconnecting";
        default:
            return @"unknown?";
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_content count];
}
@end
