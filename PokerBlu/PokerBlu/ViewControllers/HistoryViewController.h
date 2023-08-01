//
//  HistoryViewController.h
//  PokerBlu
//
//  Created by Taylor Chavez on 7/30/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *table;
@property (strong, nonatomic) NSMutableArray *content;

@end

NS_ASSUME_NONNULL_END
