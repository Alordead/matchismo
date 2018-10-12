//
//  Singleton.h
//  test
//
//  Created by Александр Попов on 11.10.2018.
//  Copyright © 2018 Александр Попов. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Singleton : NSObject

+ (instancetype)shared;

@property (readonly) NSInteger value;
- (void)appendValue;

@end

NS_ASSUME_NONNULL_END
