//
//  AppDelegate.m
//  CoreDataStackDemo
//
//  Created by LiMengtian on 20/08/2017.
//  Copyright © 2017 LiMengtian. All rights reserved.
//

#import "AppDelegate.h"
#import "MTCoreDataStack.h"
#import "Master+CoreDataClass.h"
#import "Doge+CoreDataClass.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self importSeedJsonSeedIfNeeded];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - private

- (void)importSeedJsonSeedIfNeeded {
    
    NSManagedObjectContext *context = [[MTCoreDataStack sharedInstance] managedContext];
    
    NSFetchRequest * fetchRequest = [Master fetchRequest];
    fetchRequest.resultType = NSCountResultType;
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    if (!error) {
        if ([results count] > 0) {
            NSInteger masterCount = [[results objectAtIndex:0] integerValue];
            if (masterCount <= 0) {
                [self importJsonSeed];
            }
        } else {
            [self importJsonSeed];
        }
        
    }else {
        [self importJsonSeed];
    }
    
}

- (void)importJsonSeed {
    NSURL *jsonURL = [[NSBundle mainBundle] URLForResource:@"seed" withExtension:@"json"];
    
    NSError *error;
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonURL options:0 error:&error];
    
    if (!error) {
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (!error) {
            
            NSManagedObjectContext *context = [[MTCoreDataStack sharedInstance] managedContext];
            
            NSEntityDescription *masterEntity = [NSEntityDescription entityForName:@"Master" inManagedObjectContext:context];
            NSEntityDescription *dogeEntity = [NSEntityDescription entityForName:@"Doge" inManagedObjectContext:context];
            
            NSDictionary *masterDict = jsonDict[@"master"];
            if (![masterDict isKindOfClass:[NSDictionary class]]) {
                return;
            }
            
            Master *master = [[Master alloc] initWithEntity:masterEntity insertIntoManagedObjectContext:context];
            master.name = masterDict[@"name"];
            master.age = [masterDict[@"age"] integerValue];
        
            NSArray *doges = jsonDict[@"doges"];
            
            for (NSDictionary *dogeDict in doges) {
                if (![dogeDict isKindOfClass:[NSDictionary class]]) {
                    continue;
                }
                Doge *doge = [[Doge alloc] initWithEntity:dogeEntity insertIntoManagedObjectContext:context];
                doge.name = dogeDict[@"name"];
                doge.age = [dogeDict[@"age"] integerValue];
                doge.master = master; //因为在DataModel 里设置了 inverse， 所以master 和 doge可以相互关联上
            }
            //一定要调用 save 方法，才能真正的将文件存入数据库
            [[MTCoreDataStack sharedInstance] saveContext];
        }
    }
}

@end
