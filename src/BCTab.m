#import "BCTab.h"

@interface BCTab ()
@property (nonatomic, strong) UIImage *rightBorder;
@property (nonatomic, strong) UIImage *backgroundSelected;
@end

@implementation BCTab
@synthesize rightBorder, backgroundSelected;

- (id)initWithIconImageName:(NSString *)imageName bgImageSelected: (UIImage *) bgImage
{
	if (self = [super init]) {
		self.adjustsImageWhenHighlighted = NO;
		
		self.backgroundColor = [UIColor clearColor];
		
		[self setBackgroundSelected:bgImage];
				
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

- (void)drawRect:(CGRect)rect {
	if (self.selected) {
		UIColor *bgSelectedPattern = [UIColor colorWithPatternImage: backgroundSelected];
		
		CGFloat minx = CGRectGetMinX(rect), maxx = CGRectGetMaxX(rect);
        CGFloat miny = CGRectGetMinY(rect), maxy = CGRectGetMaxY(rect);
		
		
		CGContextRef context = UIGraphicsGetCurrentContext();
		
		CGMutablePathRef a_path = CGPathCreateMutable();
		CGContextBeginPath(context);
		
		
		
		//Add a polygon to the path
		CGContextMoveToPoint(context, minx, miny); 
		CGContextAddLineToPoint(context, maxx, miny);
		CGContextAddLineToPoint(context, maxx, maxy);
		CGContextAddLineToPoint(context, minx, maxy);
		
		CGContextClosePath(context);
		
		CGContextAddPath(context, a_path);
		
		// Fill the path
		CGContextSetFillColorWithColor(context, [bgSelectedPattern CGColor]);
		CGContextFillPath(context);
		CGPathRelease(a_path);
	}
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
