#import "PlayingCard.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TheSetPlayingCard : PlayingCard

@property (strong, nonatomic) NSString *typeOfCard; //suits
@property (nonatomic) NSUInteger countOfObjectsOnTheCard; //rank
@property (strong, nonatomic) UIColor *colorOfObjectsOnTheCard; //color

+(NSArray *)validTypesOfCard;
+(NSUInteger)maxCountOfObjects;
+(UIColor *)randomColor;
+(NSString *)randomType;
+(NSUInteger)randomCountOfObjects;
-(UIColor *)getColor;

@end

NS_ASSUME_NONNULL_END
