@class BCTab;

@protocol BCTabBarDelegate;

@interface BCTabBar : UIView

- (id)initWithFrame:(CGRect)aFrame backgroundImage:(UIImage *)bgImage;

- (void)setSelectedTab:(BCTab *)aTab animated:(BOOL)animated;

@property (nonatomic, strong) NSArray *tabs;
@property (nonatomic, strong) BCTab *selectedTab;
@property (nonatomic, unsafe_unretained) id <BCTabBarDelegate> delegate;
@property (nonatomic, assign) BOOL isInvisible;
@end

@protocol BCTabBarDelegate
- (void)tabBar:(BCTabBar *)aTabBar didSelectTabAtIndex:(NSInteger)index;
@end