#import "CoreViewController.h"
#import "CoreAppDelegate.h"
#import "Student.h"

@interface CoreViewController ()<UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *firstNameField;
@property (retain, nonatomic) IBOutlet UITextField *lastNameField;
@property (retain, nonatomic) IBOutlet UITextField *ageField;
@property (retain, nonatomic) IBOutletCollection(UITextField) NSArray *fieldsCollection;
@property (nonatomic, retain) NSManagedObjectContext * context;
@end

@implementation CoreViewController
@synthesize firstNameField = _firstNameField;
@synthesize lastNameField = _lastNameField;
@synthesize ageField = _ageField;
@synthesize fieldsCollection = _fieldsCollection;
@synthesize context = _context;



- (void)viewDidLoad
{
    [super viewDidLoad];
    CoreAppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [appDelegate managedObjectContext];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setFirstNameField:nil];
    [self setLastNameField:nil];
    [self setAgeField:nil];
    [self setFieldsCollection:nil];
    self.context = nil;
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
- (IBAction)saveStudentInfo:(id)sender {
    Student * student =  [NSEntityDescription                                                            insertNewObjectForEntityForName:@"Student"                                                            inManagedObjectContext:_context];
    student.firstName = _firstNameField.text;
    student.lastName  = _lastNameField.text;
    student.age       =  [NSNumber numberWithInteger:[_ageField.text integerValue]];  
    NSError * error;
    if (![_context save:&error]) 
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    
    [_fieldsCollection makeObjectsPerformSelector:@selector(setText:) withObject:@""];
  NSLog(@"%s", __PRETTY_FUNCTION__);
}
    
- (void)dealloc {
    [_firstNameField release];
    [_lastNameField release];
    [_ageField release];
    [_fieldsCollection release];
    [super dealloc];
}
@end
