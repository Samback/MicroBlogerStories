#import "SimpleViewController.h"
#import "SimpleView.h"
@interface SimpleViewController ()<SimpleViewDelegate>
@property(nonatomic, retain)SimpleView * viewWithButton;
@end

@implementation SimpleViewController
@synthesize viewWithButton = _viewWithButton;
- (void)viewDidLoad
{
    [super viewDidLoad];
  SimpleView * sView = [[SimpleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2) andDelegate:self];
  self.viewWithButton = sView;
  [sView setBackgroundColor:[UIColor blueColor]];
  [sView release];
  [self.view addSubview:_viewWithButton];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.viewWithButton = nil;
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark-
#pragma mark SimpleViewDelegate Methods
-(void)changeBackGroundAtController
{
  CGFloat r = random()% 255 / 255.0;
  CGFloat g = random()% 255 / 255.0;
  CGFloat b = random()% 255 / 255.0;
  UIColor * myColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
  [self.view setBackgroundColor:myColor];
}
@end
