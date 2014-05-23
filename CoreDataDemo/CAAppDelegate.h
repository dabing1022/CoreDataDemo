//
//  CAAppDelegate.h
//  CoreDataDemo
//
//  Created by ChildhoodAndy on 14-5-22.
//  Copyright (c) 2014年 ChildhoodAndy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CAViewController;
@interface CAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CAViewController* viewController;

@property (strong, nonatomic) NSManagedObjectModel* managedObjectModel;
@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) NSPersistentStoreCoordinator* persistentStoreCoordinator;


- (void)saveContext;
- (NSURL*)applicationDocDir;

- (NSPersistentStoreCoordinator*)persistentStoreCoordinator;
- (NSManagedObjectModel*)managedObjectModel;
- (NSManagedObjectContext*)managedObjectContext;

@end
