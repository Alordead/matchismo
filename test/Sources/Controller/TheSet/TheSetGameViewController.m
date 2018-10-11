//
//  TheSetGameViewController.m
//  test
//
//  Created by Александр Попов on 09.10.2018.
//  Copyright © 2018 Александр Попов. All rights reserved.
//

#import "TheSetGameViewController.h"
#import "TheSetPlayingCardDeck.h"

@interface TheSetGameViewController ()

@end

@implementation TheSetGameViewController

- (TheSetPlayingCardDeck *)createDeck
{
    return  [[TheSetPlayingCardDeck alloc] init];
}



@end
