//
//  PlayerState.m
//  PokerBlu
//
//  Created by Taylor Chavez on 9/4/23.
//

#import "PlayerState.h"

@implementation PlayerState

-(id) initWithName:(NSString *) playerName{
    self = [super init];
    if(self) {
        _playerName = playerName;
    }
    return self;
}

@end
