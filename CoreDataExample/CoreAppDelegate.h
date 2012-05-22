#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CoreAppDelegate : UIResponder <UIApplicationDelegate>

@property (retain, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSManagedObjectContext * managedObjectContext;
@property (nonatomic, retain) NSManagedObjectModel        * managedObjectModel;
@property (nonatomic, retain) NSPersistentStoreCoordinator * persistentStoreCoordinator;
@end
