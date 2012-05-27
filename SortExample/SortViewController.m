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
        NSNumber * temp  = nil;
        for (int j = 0; j < [_inputArray count]-1; j++)
            for (int i = 0; i < [_inputArray count]-1; i++)
            {
                if ([[_inputArray objectAtIndex:i] intValue] > [[_inputArray objectAtIndex:i+1] intValue]) 
                {
                    temp =  [_inputArray objectAtIndex:i];
                    NSLog(@"replace %@   and %@", temp, [_inputArray objectAtIndex:i+1]);
                    [self.inputArray replaceObjectAtIndex:i withObject:[_inputArray objectAtIndex:i+1]];
                    [self.inputArray replaceObjectAtIndex:i+1 withObject:temp];
                }
                NSLog(@"%@", _inputArray);
            }
    }
    _resultLabel.text = [_inputArray componentsJoinedByString:@","];
    
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
}


@end
