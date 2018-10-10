//
//  TheSetCardGameViewController.h
//  test
//
//  Created by Александр Попов on 10.10.2018.
//  Copyright © 2018 Александр Попов. All rights reserved.
//

#import "Deck.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TheSetCardGameViewController : UIViewController

@property (nonatomic) BOOL gameMode;
-(Deck *)createDeck;

@end

NS_ASSUME_NONNULL_END
