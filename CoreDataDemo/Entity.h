//
//  Entity.h
//  CoreDataDemo
//
//  Created by ChildhoodAndy on 14-5-22.
//  Copyright (c) 2014年 ChildhoodAndy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSDate * creationDate;

@end
