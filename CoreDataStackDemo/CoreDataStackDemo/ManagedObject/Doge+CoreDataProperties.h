//
//  Doge+CoreDataProperties.h
//  CoreDataStackDemo
//
//  Created by LiMengtian on 20/08/2017.
//  Copyright © 2017 LiMengtian. All rights reserved.
//

#import "Doge+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Doge (CoreDataProperties)

+ (NSFetchRequest<Doge *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t age;
@property (nullable, nonatomic, retain) Master *master;

@end

NS_ASSUME_NONNULL_END
