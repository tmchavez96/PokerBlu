//
//  MainTabController.m
//  PokerBlu
//
//  Created by Taylor Chavez on 7/30/23.
//

#import "MainTabController.h"
#import "HistoryViewController.h"
#import "HostSearchViewController.h"

@interface MainTabController ()

@end

@implementation MainTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createViews];
}

-(void) createViews {
    HistoryViewController *hvc = [[HistoryViewController alloc] init];
    UIImage *historyIcon = [UIImage systemImageNamed:@"archivebox"];
    UINavigationController *histNavView = [self createNavController:hvc title:@"history" navImage:historyIcon];
    
    HostSearchViewController *hsvc = [[HostSearchViewController alloc] init];
    UIImage *searchIcon = [UIImage systemImageNamed:@"paperplane"];
    UINavigationController *searchNavView = [self createNavController:hsvc title:@"search" navImage:searchIcon];
    
    [self setViewControllers:@[searchNavView, histNavView]];
}


-(UINavigationController*)createNavController:(UIViewController*) rootView
                                        title:(NSString*) title
                                     navImage:(UIImage*)navImage{
    UINavigationController *newNav = [[UINavigationController alloc] initWithRootViewController:rootView];
    [[newNav tabBarItem] setTitle:title];
    [[newNav tabBarItem] setImage:navImage];
    return newNav;
}


@end
