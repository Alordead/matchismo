//
//  Card.h
//  test
//
//  Created by Александр Попов on 04.10.2018.
//  Copyright © 2018 Александр Попов. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards atGameMode:(BOOL)gameMode;

@end


