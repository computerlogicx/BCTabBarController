@interface BCTab : UIButton
{
    UIImage *background;
    UIImage *rightBorder;
}

- (id)initWithIconImageName:(NSString *)imageName bgImageSelected:(UIImage *)bgImage;
@end
