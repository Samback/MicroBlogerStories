//
//  SortViewController.m
//  SortExample
//
//  Created by Max Tymchii on 27.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SortViewController.h"

@interface SortViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (nonatomic, weak) NSMutableArray * inputArray;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation SortViewController
@synthesize inputTextField = _inputTextField;
@synthesize inputArray = _inputArray;
@synthesize resultLabel = _resultLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setInputTextField:nil];
    [self setResultLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)arrayMaker
{
    _inputArray = (NSMutableArray *)[_inputTextField.text componentsSeparatedByString:@","];
    for (int z = 0; z < [_inputArray count]; z++) {
        [_inputArray replaceObjectAtIndex:z withObject:[NSNumber numberWithInt:[[_inputArray objectAtIndex:z] intValue]]];
    }

}
- (IBAction)bubbleSort:(UIButton *)sender {
    [self arrayMaker];
    if ([_inputArray count] > 2)
    { 
       
        for (int j = 0; j < [_inputArray count]-1; j++)
            for (int i = 0; i < [_inputArray count]-1; i++)
            {
                if ([[_inputArray objectAtIndex:i] intValue] > [[_inputArray objectAtIndex:i+1] intValue]) 
                    [self swapLeft:i andRight:i+1];                
            }
    }
    _resultLabel.text = [_inputArray componentsJoinedByString:@","];
    
}
-(void)swapLeft:(int)i andRight:(int)j
{
    NSNumber * temp  = nil;
    temp =  [_inputArray objectAtIndex:i];
   // NSLog(@"replace %@   and %@", temp, [_inputArray objectAtIndex:j]);
    [self.inputArray replaceObjectAtIndex:i withObject:[_inputArray objectAtIndex:j]];
    [self.inputArray replaceObjectAtIndex:j withObject:temp];

}
- (IBAction)comparatorSort:(UIButton *)sender {
    [self arrayMaker];
    if ([_inputArray count] > 2)
    {
        [_inputArray sortUsingComparator:^(id obj1, id obj2)
        {
            if ([obj1 intValue] < [obj2 intValue]) 
                return (NSComparisonResult)NSOrderedAscending;
            else if([obj1 intValue] > [obj2 intValue])
                return (NSComparisonResult)NSOrderedDescending;
            else
                return (NSComparisonResult)NSOrderedSame;
        }];
    }
      _resultLabel.text = [_inputArray componentsJoinedByString:@","];
}
- (IBAction)quickSort:(UIButton *)sender {
    [self arrayMaker];
    [self sortBeginElement:0 endElemen:[_inputArray count]-1];
    _resultLabel.text = [_inputArray componentsJoinedByString:@","];

}

- (void) sortBeginElement:(int)beg endElemen:(int)end
{
    if (end > beg + 1)
    {
        int  piv = [[_inputArray objectAtIndex:beg]intValue];
        int  l = beg + 1;
        int  r = end;
        
        while (l < r)
        {
            if ([[_inputArray objectAtIndex:l] intValue] <= piv)
                l++;
            else
                [self swapLeft:l andRight:--r];
        }
        
        [self swapLeft:--l andRight:beg];
       
        [self sortBeginElement:beg endElemen:l];
        [self sortBeginElement:r endElemen:end];             
    }
}

@end
