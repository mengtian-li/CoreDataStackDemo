//
//  MTCoreDataStack.h
//  CoreDataStackDemo
//
//  Created by LiMengtian on 20/08/2017.
//  Copyright © 2017 LiMengtian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MTCoreDataStack : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedContext;

+ (instancetype)sharedInstance;
- (void)saveContext;

@end
