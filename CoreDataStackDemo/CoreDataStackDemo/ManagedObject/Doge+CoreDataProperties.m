//
//  Doge+CoreDataProperties.m
//  CoreDataStackDemo
//
//  Created by LiMengtian on 20/08/2017.
//  Copyright © 2017 LiMengtian. All rights reserved.
//

#import "Doge+CoreDataProperties.h"

@implementation Doge (CoreDataProperties)

+ (NSFetchRequest<Doge *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Doge"];
}

@dynamic name;
@dynamic age;
@dynamic master;

@end
