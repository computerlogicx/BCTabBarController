#import "BCTab.h"

@interface BCTab ()
@property (nonatomic, strong) UIImage *rightBorder;
@property (nonatomic, strong) UIImageView *backgroundImage;
@end

@implementation BCTab
@synthesize rightBorder, backgroundImage;

- (id)initWithIconImageName:(NSString *)imageName bgImageSelected: (UIImage *) bgImage
{
	if (self = [super init]) {
		self.adjustsImageWhenHighlighted = NO;
		
		self.backgroundImage = [[UIImageView alloc] initWithImage:bgImage];
		
		[self.backgroundImage setFrame:self.bounds];
		[self.backgroundImage setContentMode:UIViewContentModeRedraw];
		
		[self addSubview:self.backgroundImage];
		
		self.backgroundColor = [UIColor clearColor];
		
		NSString *selectedName = [NSString stringWithFormat:@"%@-selected.%@",
								   [imageName stringByDeletingPathExtension],
								   [imageName pathExtension]];
		
		[self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
		[self setImage:[UIImage imageNamed:selectedName] forState:UIControlStateSelected];
	}
	return self;
}

- (void)setHighlighted:(BOOL)aBool {
	// no highlight state
}


- (void)setFrame:(CGRect)aFrame {
	[super setFrame:aFrame];
	[self setNeedsDisplay];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	UIEdgeInsets imageInsets = UIEdgeInsetsMake(floor((self.bounds.size.height / 2) -
												(self.imageView.image.size.height / 2)),
												floor((self.bounds.size.width / 2) -
												(self.imageView.image.size.width / 2)),
												floor((self.bounds.size.height / 2) -
												(self.imageView.image.size.height / 2)),
												floor((self.bounds.size.width / 2) -
												(self.imageView.image.size.width / 2)));
	self.imageEdgeInsets = imageInsets;
}

@end
