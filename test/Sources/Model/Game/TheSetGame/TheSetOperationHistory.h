//
//  TheSetOperationHistory.h
//  test
//
//  Created by Александр Попов on 11.10.2018.
//  Copyright © 2018 Александр Попов. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TheSetOperationHistory : NSObject

@property (strong, nonatomic) NSMutableArray *historyArray;
-(void)addString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
