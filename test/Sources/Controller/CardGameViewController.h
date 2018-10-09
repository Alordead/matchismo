//
//  ViewController.h
//  test
//
//  Created by Александр Попов on 04.10.2018.
//  Copyright © 2018 Александр Попов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController
@property (nonatomic) BOOL gameMode;
-(Deck *)createDeck;

@end

