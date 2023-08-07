//
//  HostingViewController.m
//  PokerBlu
//
//  Created by Taylor Chavez on 8/6/23.
//

#import "HostingViewController.h"
#import "BlueToothHostManager.h"

@interface HostingViewController ()
@property (strong, nonatomic) BlueToothHostManager *hostManager;

@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UILabel *serviceNameLabel;
@property (strong, nonatomic) UILabel *serviceIDLabel;
@property (strong, nonatomic) UILabel *charUILabel;
@property (strong, nonatomic) NSString *gameName;

@end

@implementation HostingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // start the host
    _gameName = @"PokerBluSession";
    _hostManager = [[BlueToothHostManager alloc] initWithName:_gameName];
    _statusLabel = [UILabel new];
    _serviceIDLabel = [UILabel new];
    _charUILabel = [UILabel new];
    _serviceNameLabel = [UILabel new];
    UIColor *bg = [UIColor colorNamed:@"backgroundColor"];
    [self.view setBackgroundColor:bg];
    [self createUI];
}

- (void)startHosting:(id)sender {
    // Handle button tap here
    NSLog(@"Custom button tapped!");
    _hostManager = [[BlueToothHostManager alloc] init];
}

-(void)createUI {
    CGFloat viewWidth =  self.view.frame.size.width;
    CGFloat viewHeight = self.view.frame.size.height;
    
    CGRect _nameFrame = CGRectMake( 20, 100, viewWidth - 40, 100);
    CGRect _serviceFrame = CGRectMake( 20, 120, viewWidth - 40, 120);
    CGRect _charFrame = CGRectMake(20, 140, viewWidth - 40, 140);
    CGRect _statusFrame = CGRectMake(20, 160, viewWidth - 40, 160);

    UIColor *fontColor = [UIColor colorNamed:@"fontColor"];
    [_serviceIDLabel setFrame:_serviceFrame];
    [_charUILabel setFrame:_charFrame];
    [_statusLabel setFrame:_statusFrame];
    [_serviceNameLabel setFrame:_nameFrame];
    
    [_serviceIDLabel setTextColor:fontColor];
    [_charUILabel setTextColor:fontColor];
    [_statusLabel setTextColor:fontColor];
    [_serviceNameLabel setTextColor:fontColor];
    
        
    [self.view addSubview:_serviceIDLabel];
    [self.view addSubview:_charUILabel];
    [self.view addSubview:_statusLabel];
    [self.view addSubview:_serviceNameLabel];
    
    [self updateLabels];
}

-(void)updateLabels {
    [_serviceNameLabel setText:[@"Name: " stringByAppendingFormat:@"%@",_hostManager.serviceName]];
    [_serviceIDLabel setText:[@"Service ID: " stringByAppendingFormat:@"%@",_hostManager.serviceId]];
    [_charUILabel setText:[@"charactersit: " stringByAppendingFormat:@"%@", _hostManager.characteristicId]];
    [_statusLabel setText:@"Status: ? "];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
