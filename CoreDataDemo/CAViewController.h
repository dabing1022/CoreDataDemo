//
//  CAViewController.h
//  CoreDataDemo
//
//  Created by ChildhoodAndy on 14-5-22.
//  Copyright (c) 2014年 ChildhoodAndy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CAAppDelegate;
@interface CAViewController : UIViewController

@property (weak, nonatomic) CAAppDelegate* myDelegate;
@property (strong, nonatomic) NSMutableArray* entities;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (weak, nonatomic) IBOutlet UIButton *addToDB_Button;
@property (weak, nonatomic) IBOutlet UIButton *queryDB_Button;

- (IBAction)addToDB:(id)sender;

- (IBAction)queryDB:(id)sender;

- (IBAction)backgroundTapped:(id)sender;
@end
