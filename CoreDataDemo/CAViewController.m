//
//  CAViewController.m
//  CoreDataDemo
//
//  Created by ChildhoodAndy on 14-5-22.
//  Copyright (c) 2014年 ChildhoodAndy. All rights reserved.
//

#import "CAViewController.h"
#import "Entity.h"
#import "CAAppDelegate.h"

@interface CAViewController ()

@end

@implementation CAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.myDelegate = (CAAppDelegate*)[[UIApplication sharedApplication] delegate];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.titleTextField = nil;
    self.contentTextField = nil;
}

- (IBAction)addToDB:(id)sender {
    Entity* entity = (Entity*)[NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:self.myDelegate.managedObjectContext];
    
    [entity setValue:self.titleTextField.text forKey:@"title"];
    [entity setValue:self.contentTextField.text forKey:@"body"];
    [entity setValue:[NSDate date] forKey:@"creationDate"];
    
    [self.myDelegate saveContext];
}

// NSFetchRequest 获取数据的请求
// NSEntityDescription 实体结构
- (IBAction)queryDB:(id)sender {
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:self.myDelegate.managedObjectContext];
    [request setEntity:entity];
    
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:NO];
    NSArray* sortDescriptions = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    
    NSError* error;
    NSMutableArray* mutableFetchResult = [[self.myDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil) {
        NSLog(@"Error: %@, %@", error, [error userInfo]);
    }
    
    self.entities = mutableFetchResult;
    
    NSLog(@"The count of entites: %i", [self.entities count]);
    
    for (Entity* entity in self.entities) {
        NSLog(@"Title:%@", entity.title);
        NSLog(@"Content:%@", entity.body);
        NSLog(@"creationData:%@", entity.creationDate);
    }
}

- (IBAction)backgroundTapped:(id)sender {
    [self.titleTextField resignFirstResponder];
    [self.contentTextField resignFirstResponder];
}
@end
