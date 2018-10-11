//
//  TheSetOperationHistory.m
//  test
//
//  Created by Александр Попов on 11.10.2018.
//  Copyright © 2018 Александр Попов. All rights reserved.
//

#import "TheSetOperationHistory.h"

@implementation TheSetOperationHistory

-(NSMutableArray *)historyArray
{
    if (!_historyArray) _historyArray = [[NSMutableArray alloc] init];
    return _historyArray;
}

-(void)addString:(NSString *)string
{
    if (self.historyArray) {
    [self.historyArray addObject:string];
    } else {
        self.historyArray.init;
    }
}

@end
