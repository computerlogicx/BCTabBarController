#import "BCTabBar.h"
#import "BCTab.h"

#define kTabMargin 0.0

@interface BCTabBar ()
@property (nonatomic, strong) UIImageView *backgroundImage;
@end

@implementation BCTabBar
@synthesize tabs, selectedTab, backgroundImage, delegate, isInvisible;

- (id)initWithFrame:(CGRect)aFrame backgroundImage:(UIImage *)bgImage
{

    if (self = [super initWithFrame:aFrame])
    {
        [self setBackgroundColor:[UIColor blackColor]];
        self.backgroundImage = [[UIImageView alloc] initWithImage:bgImage];

        [self.backgroundImage setFrame:self.bounds];
        [self.backgroundImage setContentMode:UIViewContentModeRedraw];

        [self addSubview:self.backgroundImage];

        self.userInteractionEnabled = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight |
                UIViewAutoresizingFlexibleTopMargin;

    }

    return self;
}

- (void)setTabs:(NSArray *)array
{
    if (tabs != array)
    {
        for (BCTab *tab in tabs)
        {
            [tab removeFromSuperview];
        }

        tabs = array;

        for (BCTab *tab in tabs)
        {
            tab.userInteractionEnabled = YES;
            [tab addTarget:self action:@selector(tabSelected:) forControlEvents:UIControlEventTouchDown];
        }
        [self setNeedsLayout];

    }
}

- (void)setSelectedTab:(BCTab *)aTab animated:(BOOL)animated
{
    if (aTab != selectedTab)
    {
        selectedTab = aTab;
        selectedTab.selected = YES;

        for (BCTab *tab in tabs)
        {
            if (tab == aTab)
            {
                continue;
            }

            tab.selected = NO;
        }
    }
}

- (void)setSelectedTab:(BCTab *)aTab
{
    [self setSelectedTab:aTab animated:YES];
}

- (void)tabSelected:(BCTab *)sender
{
    [self.delegate tabBar:self didSelectTabAtIndex:[self.tabs indexOfObject:sender]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect f = self.bounds;
    f.size.width /= self.tabs.count;
    f.size.width -= (kTabMargin * (self.tabs.count + 1)) / self.tabs.count;
    for (BCTab *tab in self.tabs)
    {
        f.origin.x += kTabMargin;

        CGFloat spacer = 1.0;

        if ([tab isEqual:self.tabs.lastObject])
        {
            spacer = 0.0;
        }

        tab.frame = CGRectMake(floorf(f.origin.x), f.origin.y, floorf(f.size.width - spacer), f.size.height);
        f.origin.x += f.size.width;
        [self addSubview:tab];
    }
}

- (void)setFrame:(CGRect)aFrame
{
    [super setFrame:aFrame];
    [self setNeedsDisplay];
}

@end
