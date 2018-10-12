#import "TheSetHistoryViewController.h"

@interface TheSetHistoryViewController()

@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation TheSetHistoryViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (NSMutableAttributedString *line in self.historyArray)
    {
        NSMutableAttributedString *oldStr = self.historyTextView.attributedText.mutableCopy;
        [oldStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        [oldStr appendAttributedString:line];
        
        self.historyTextView.attributedText = oldStr;
    }
    
}

@end
