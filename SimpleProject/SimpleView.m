#import "SimpleView.h"

@interface SimpleView()
@property (nonatomic, retain) UIButton * changeBackgroundButton;
-(void) addingButton;
@end
CGFloat buttonWidth  = 140.0;
CGFloat buttonHeight = 44.0;

@implementation SimpleView
@synthesize delegate = _delegate, changeBackgroundButton = _changeBackgroundButton;

- (id)initWithFrame:(CGRect)frame andDelegate:(id<SimpleViewDelegate>) theDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
      self.delegate = theDelegate;
      [self addingButton];
    }
  
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
//- (void)drawRect:(CGRect)rect
//{
// }
-(void) addingButton
{  
  CGFloat x = (self.frame.size.width  - buttonWidth) /2.0;
  CGFloat y = (self.frame.size.height - buttonHeight)/2.0;
  UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, buttonWidth, buttonHeight)];
  self.changeBackgroundButton = button;
  [button release];
  [_changeBackgroundButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
  [_changeBackgroundButton setBackgroundColor:[UIColor yellowColor]];
  [_changeBackgroundButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [_changeBackgroundButton setTitle:@"Just click it!" forState:UIControlStateNormal];
  [self addSubview:_changeBackgroundButton];

}
-(void)clicked:(UIButton *) button
{
  [_delegate changeBackGroundAtController];
}
-(void) dealloc
{
  self.changeBackgroundButton = nil;
  [super dealloc];
}
@end
