//
//  PlayerState.h
//  PokerBlu
//
//  Created by Taylor Chavez on 9/4/23.
//

// object that will be constantly sent from each cental manager (player)
// to the host (peripheral)

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayerState : NSObject

@property (strong, nonatomic) NSString *playerName;

-(id) initWithName:(NSString *) playerName;


@end

NS_ASSUME_NONNULL_END
