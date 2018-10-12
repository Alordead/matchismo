#import "TheSetPlayingCard.h"

@implementation TheSetPlayingCard

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    if ([otherCards count] == 1) {
            TheSetPlayingCard *otherCard = [otherCards firstObject];
            if ([self.typeOfCard isEqualToString:otherCard.typeOfCard]) {
                score = 1;
            } else if (self.countOfObjectsOnTheCard == otherCard.countOfObjectsOnTheCard) {
                score = 4;
            }
        }
    return score;
}

@synthesize typeOfCard = _typeOfCard;
+(NSArray *)validTypesOfCard
{
    return @[@"■",@"●",@"▴"];
}

- (NSString *)contents
{
    NSString *str = [NSString new];
    for (int x = 1; x <= self.countOfObjectsOnTheCard; x++) {
        str = [NSString stringWithFormat:@"%@%@", str, self.typeOfCard];
    }
    return str;
}
- (UIColor *)showColorOfObjectOnTheCard
{
    UIColor *color = [[UIColor alloc]init];
    color = self.colorOfObjectsOnTheCard;
    return color;
}
-(UIColor *)getColor
{
    return self.colorOfObjectsOnTheCard;
}

- (void)setColorOfObjectsOnTheCard:(UIColor *)colorOfObjectsOnTheCard
{
    // FIXME:
    if ([[TheSetPlayingCard validTypesOfCard] containsObject:colorOfObjectsOnTheCard]) {
        self.colorOfObjectsOnTheCard = colorOfObjectsOnTheCard;
    }
    
    _colorOfObjectsOnTheCard = colorOfObjectsOnTheCard;
}

+(NSArray *)colorOfObjects
{
    return @[[UIColor blackColor], [UIColor redColor], [UIColor blueColor]];
}

+(UIColor *)randomColor {
    int x = arc4random()%3;
    UIColor *someColor = [[UIColor alloc] init];
    switch (x) {
        case 0:
            someColor = [UIColor blackColor];
            break;
        case 1: someColor = [UIColor redColor];
            break;
        case 2: someColor = [UIColor blueColor];
            break;
        default: someColor = [UIColor yellowColor]; break;
    }
    return someColor;
}

+(NSUInteger)randomCountOfObjects {
    NSUInteger x = arc4random()%3 +1;
    return x;
}

+(NSString *)randomType {
    int x = arc4random()%3;
    NSString *someString = [NSString new];
    switch (x) {
        case 0:
            someString = @"■";
            break;
        case 1: someString = @"●";
            break;
        case 2: someString = @"►";
            break;
    }
    return someString;
}
+(NSUInteger)maxCountOfObjects { return [[self colorOfObjects] count]; }

-(void)setCountOfObjectsOnTheCard:(NSUInteger)countOfObjectsOnTheCard
{
    if (countOfObjectsOnTheCard <= [TheSetPlayingCard maxCountOfObjects]) {
        _countOfObjectsOnTheCard = countOfObjectsOnTheCard;
    }
}

@end
