//
//  CAAppDelegate.m
//  CoreDataDemo
//
//  Created by ChildhoodAndy on 14-5-22.
//  Copyright (c) 2014年 ChildhoodAndy. All rights reserved.
//

#import "CAAppDelegate.h"
#import <CoreData/CoreData.h>

@implementation CAAppDelegate
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self logPaths];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSError* error;
    if (self.managedObjectContext != nil) {
        if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
            NSLog(@"Error: %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)logPaths
{
    // 1. 获取应用沙盒根路径
    NSLog(@"app_home: %@", NSHomeDirectory());
    
    // 2. 获取Documents目录路径
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDir = [paths objectAtIndex:0];
    NSLog(@"app_home_doc: %@", documentsDir);
    
    // 3. 获取Library目录路径
    paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* libDir = [paths objectAtIndex:0];
    NSLog(@"app_home_lib: %@", libDir);
    
    // 4. 获取Cache目录路径
    paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* cachePath = [paths objectAtIndex:0];
    NSLog(@"app_home_cache: %@", cachePath);
    
    // 5. 获取Tmp目录路径
    NSLog(@"app_home_tmp: %@", NSTemporaryDirectory());
    
    // 6. 创建文件夹
    NSString* testDir = [documentsDir stringByAppendingPathComponent:@"test"];
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:testDir withIntermediateDirectories:YES attributes:nil error:nil];
    if (success) {
        NSLog(@"文件夹创建成功");
    }else {
        NSLog(@"文件夹创建失败");
    }
    
    // 7. 创建文件
    NSString* testFilePath = [testDir stringByAppendingPathComponent:@"test.txt"];
    success = [[NSFileManager defaultManager] createFileAtPath:testFilePath contents:nil attributes:nil];
    if (success) {
        NSLog(@"文件创建成功");
    }else {
        NSLog(@"文件创建失败");
    }
    
    // 8. 写数据到文件
    NSString* content = @"Hello World!!!";
    success = [content writeToFile:testFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (success) {
        NSLog(@"文件写入成功");
    }else {
        NSLog(@"文件写入失败");
    }
    
    // 9. 文件属性
    NSDictionary* fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:testFilePath error:nil];
    NSArray* keys = [fileAttributes allKeys];
    int count = [keys count];
    id key, value;
    for (int i = 0; i < count; i++) {
        key = [keys objectAtIndex:i];
        value = [fileAttributes objectForKey:key];
        NSLog(@"Key: %@ for value: %@", key, value);
    }
    
    // 10. 删除文件
    success = [[NSFileManager defaultManager] removeItemAtPath:testFilePath error:nil];
    if (success) {
        NSLog(@"文件删除成功");
    }else {
        NSLog(@"文件删除失败");
    }
}


#pragma mark - CoreDataAbout

- (void)saveContext
{
    NSError* error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error :%@, %@", error, [error userInfo]);
            abort();
        }else{
            NSLog(@"save success!");
        }
    }
}

- (NSURL*)applicationDocDir
{
    NSURL* url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
    NSLog(@"%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]);
    
    return url;
}

// 后缀为.xcdatamodeld的包，里面是.xcdatamodel文件，用数据模型编辑器编辑
// 编译后为.momd或.mom文件
- (NSManagedObjectModel*)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL* modelURL = [[NSBundle mainBundle] URLForResource:@"Journal" withExtension:@"momd"];
    NSLog(@"model url: %@", [modelURL path]);
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return self.managedObjectModel;
}

- (NSManagedObjectContext*)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator* coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil) {
        self.managedObjectContext = [[NSManagedObjectContext alloc]init];
        [self.managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return self.managedObjectContext;
}

- (NSPersistentStoreCoordinator*)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL* storeUrl = [[self applicationDocDir] URLByAppendingPathComponent:@"Journal.sqlite"];
    
    NSError* error = nil;
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        NSLog(@"Error: %@, %@", error, [error userInfo]);
    }
    
    return self.persistentStoreCoordinator;
}

@end
