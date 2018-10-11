//
//  TheSetHistoryViewController.m
//  test
//
//  Created by Александр Попов on 11.10.2018.
//  Copyright © 2018 Александр Попов. All rights reserved.
//

#import "TheSetHistoryViewController.h"

@interface TheSetHistoryViewController()

@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation TheSetHistoryViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (NSString *array in self.historyArray)
    {
        [self.historyTextView setText:[NSString stringWithFormat:@"%@\n%@",self.historyTextView.text, (NSString*)array]];
    }
    
}

@end
