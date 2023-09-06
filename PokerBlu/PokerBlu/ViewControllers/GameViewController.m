//
//  GameViewController.m
//  PokerBlu
//
//  Created by Taylor Chavez on 9/5/23.
//

#import "GameViewController.h"

@interface GameViewController ()

@property (nonatomic, strong) UITextField *chatBox;

@end

@implementation GameViewController


-(id) initWithConnection:(CBPeripheral *) peripheral
              andManager:(BlueToothManager *)btm {
    self = [super init];
    if(self){
        _peripheral = peripheral;
        _btm = btm;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _chatBox = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 200, 40)];

    [_chatBox setPlaceholder:@"chat"];
    _chatBox.delegate = self;
    // Do any additional setup after loading the view.
    [self.view addSubview:_chatBox];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    // send the chat message if i
    if(textField.text && textField.text != @""){
        [_btm writeToPeripheral:_peripheral message:textField.text];
    }
    return YES;
}

@end
