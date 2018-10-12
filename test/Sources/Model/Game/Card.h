#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (strong, nonatomic) UIColor *showColorOfObjectOnTheCard;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

-(int)match:(NSArray *)otherCards atGameMode: (BOOL) gameMode;
-(int)match:(NSArray *)otherCards;
-(int)checkingTheSet:(NSMutableArray *)cards;

@end


