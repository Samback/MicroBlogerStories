#import "SchoolStudentsTabelListViewController.h"
#import "CoreAppDelegate.h"
#import "Student.h"

@interface SchoolStudentsTabelListViewController ()
@property (nonatomic, retain)NSManagedObjectContext * context;
@property (nonatomic, retain)NSArray * students;


@end

@implementation SchoolStudentsTabelListViewController
@synthesize context = _context;
@synthesize students = _students;

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
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:_context];
  
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(age BETWEEN {20, 30}) OR (firstName LIKE[c] 'Max')"];
  
    [request setEntity:entityDescription];
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
