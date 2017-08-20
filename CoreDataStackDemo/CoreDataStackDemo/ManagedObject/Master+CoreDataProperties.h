//
//  Master+CoreDataProperties.h
//  CoreDataStackDemo
//
//  Created by LiMengtian on 20/08/2017.
//  Copyright © 2017 LiMengtian. All rights reserved.
//

#import "Master+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Master (CoreDataProperties)

+ (NSFetchRequest<Master *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t age;
@property (nullable, nonatomic, retain) NSSet<Doge *> *doges;

@end

@interface Master (CoreDataGeneratedAccessors)

- (void)addDogesObject:(Doge *)value;
- (void)removeDogesObject:(Doge *)value;
- (void)addDoges:(NSSet<Doge *> *)values;
- (void)removeDoges:(NSSet<Doge *> *)values;

@end

NS_ASSUME_NONNULL_END
