//
//  Master+CoreDataProperties.m
//  CoreDataStackDemo
//
//  Created by LiMengtian on 20/08/2017.
//  Copyright © 2017 LiMengtian. All rights reserved.
//

#import "Master+CoreDataProperties.h"

@implementation Master (CoreDataProperties)

+ (NSFetchRequest<Master *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Master"];
}

@dynamic name;
@dynamic age;
@dynamic doges;

@end
