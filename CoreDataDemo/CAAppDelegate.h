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

// 被管理的数据模型
@property (strong, nonatomic) NSManagedObjectModel* managedObjectModel;

// 被管理的数据上下文
@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;

// 持久化存储协调器
@property (strong, nonatomic) NSPersistentStoreCoordinator* persistentStoreCoordinator;

- (void)logPaths;
- (void)saveContext;
- (NSURL*)applicationDocDir;

@end
