#import <UIKit/UIKit.h>

@protocol SimpleViewDelegate
-(void)changeBackGroundAtController;
@end

@interface SimpleView : UIView
@property(nonatomic, assign) id<SimpleViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame andDelegate:(id<SimpleViewDelegate>) theDelegate;
@end
