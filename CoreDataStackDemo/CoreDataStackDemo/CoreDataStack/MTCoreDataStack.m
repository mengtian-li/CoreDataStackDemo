//
//  MTCoreDataStack.m
//  CoreDataStackDemo
//
//  Created by LiMengtian on 20/08/2017.
//  Copyright © 2017 LiMengtian. All rights reserved.
//

#import "MTCoreDataStack.h"

static NSString *const kModelName = @"Model";

@interface MTCoreDataStack ()

@property (nonatomic, strong, readwrite) NSManagedObjectContext *managedContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *psc;
@property (nonatomic, strong) NSManagedObjectModel *managedModel;

@end

@implementation MTCoreDataStack

#pragma mark - Public

+ (instancetype)sharedInstance {
    static MTCoreDataStack *stack = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stack = [[MTCoreDataStack alloc] init];
    });
    return stack;
}

- (void)saveContext {
    NSError *error;
    if ([self.managedContext hasChanges] && ![self.managedContext save:&error]) {
        NSLog(@"NSManagedObjectContext Save Error: %@",[error localizedDescription]);
    }
}
#pragma mark - Accessor 

- (NSManagedObjectContext *)managedContext {
    if (!_managedContext) {
        _managedContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedContext.persistentStoreCoordinator = self.psc;
    }
    return _managedContext;
}

- (NSPersistentStoreCoordinator *)psc {
    if (!_psc) {
        _psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedModel];
        
        NSURL *URL = [[self documentURL] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",kModelName]];
        NSError *error;
        if (![_psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:URL options:nil error:&error]) {
            NSLog(@"addPersistentStoreWithType Error: %@",[error localizedDescription]);
        }
    }
    return _psc;
}

- (NSManagedObjectModel *)managedModel {
    if (!_managedModel) {
        NSURL *momdURL = [[NSBundle mainBundle]URLForResource:kModelName withExtension:@"momd"];
        _managedModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:momdURL];
    }
    return _managedModel;
}

#pragma mark - Helper 

- (NSURL *)documentURL {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
}

@end
