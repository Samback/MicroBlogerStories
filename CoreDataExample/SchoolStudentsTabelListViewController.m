#import "SchoolStudentsTabelListViewController.h"
#import "CoreAppDelegate.h"
#import "Student.h"

@interface SchoolStudentsTabelListViewController ()
@property (nonatomic, retain)NSManagedObjectContext * context;
@property (nonatomic, retain)NSEntityDescription * entityDescription;
@property (nonatomic, retain)NSArray * students;
@property (nonatomic, assign)BOOL selected;
-(void) studentsList;


@end

@implementation SchoolStudentsTabelListViewController
@synthesize context = _context;
@synthesize students = _students;
@synthesize entityDescription = _entityDescription;
@synthesize selected = _selected;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CoreAppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [appDelegate managedObjectContext];
    self.entityDescription = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:_context];  
    _selected = NO;
    [self studentsList];
}
-(void) studentsList
{
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(age BETWEEN {10, 50})"];/* OR (firstName LIKE[c] 'Max')"];*/
    
    [request setEntity:_entityDescription];
    [request setPredicate:predicate];
    NSError * error;
    self.students = [_context executeFetchRequest:request error:&error];
    if (_students == nil)
        NSLog(@"The error with Core Data");
    NSLog(@"Number of elements %d", [_students count]);
    [request release];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  self.context = nil;
  self.students = nil;
  self.entityDescription = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_students count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Student Data";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
  Student * student = [_students objectAtIndex:indexPath.row];
  cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
  cell.detailTextLabel.text = [student.age description];
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selected = YES;
}
- (IBAction)deleteChoosenRow:(UIBarButtonItem *)sender 
{
    if (_selected && ([_students count ] > 0)) 
    {      
        NSInteger row = [self.tableView indexPathForSelectedRow].row;
        
        Student * student = [_students objectAtIndex:row];
        [_context deleteObject:student];
        
        NSError * error;
        if (![_context save:&error]) 
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            return;
        }    
        [self studentsList];
        [self.tableView reloadData];
        NSLog(@" %d num",  [_students count]);
    }
}

@end
