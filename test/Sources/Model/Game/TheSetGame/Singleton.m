//
//  Singleton.m
//  test
//
//  Created by Александр Попов on 11.10.2018.
//  Copyright © 2018 Александр Попов. All rights reserved.
//

#import "Singleton.h"

static Singleton *_shared;

@implementation Singleton

+ (instancetype)shared
{
    if (!_shared) _shared = [self new];
    
    return _shared;
}

- (void)appendValue
{
    self->_value++;
}

@end
