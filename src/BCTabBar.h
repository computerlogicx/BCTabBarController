@class BCTab;

@protocol BCTabBarDelegate;

@interface BCTabBar : UIView

- (id)initWithFrame:(CGRect)aFrame;
- (void)setSelectedTab:(BCTab *)aTab animated:(BOOL)animated;

@property (nonatomic, strong) NSArray *tabs;
@property (nonatomic, strong) BCTab *selectedTab;
@property (nonatomic, unsafe_unretained) id <BCTabBarDelegate> delegate;
@end

@protocol BCTabBarDelegate
- (void)tabBar:(BCTabBar *)aTabBar didSelectTabAtIndex:(NSInteger)index;
@end