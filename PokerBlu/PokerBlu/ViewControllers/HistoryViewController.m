//
//  HistoryViewController.m
//  PokerBlu
//
//  Created by Taylor Chavez on 7/30/23.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

NSString  *_Nullable kDefaultCellIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _content = [[NSMutableArray alloc] initWithArray:@[@"1",@"2",@"3"]];
    _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];

    _table.delegate = self;
    _table.dataSource = self;
    
    [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:kDefaultCellIdentifier];
    
    [self.view addSubview: _table];
    [_table reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
       
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDefaultCellIdentifier forIndexPath:indexPath];
       
    if (cell == nil) {
           // If there were no cells available in the reuse pool, create a new cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDefaultCellIdentifier];
    }
       
    [cell.textLabel setText:@"Hello World"];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_content count];
}

@end
