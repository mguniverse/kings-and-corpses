//
//  AppDelegate.m
//  Kings & Corpses
//
//  Created by Danny Perski on 7/22/14.
//  Copyright (c) 2014 Danny Perski. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize menuMusic;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    delayIntensity = 1;
    
    [self titleSwitch];
    
    //this line of code allows you to listen to music on iOS in the background
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    
    // Override point for customization after application launch.
    return YES;
}

-(void)gameplaySwitch {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Gameplay" ofType:@"mp3"];
    menuMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    menuMusic.numberOfLoops = -1;
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"musicDisabled"]) {
    }
    else {
        [menuMusic play];
    }
}

-(void)titleSwitch {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Title" ofType:@"mp3"];
    menuMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    menuMusic.numberOfLoops = -1;
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"musicDisabled"]) {
    }
    else {
        [menuMusic play];
    }
}

-(void)muteMusic {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"musicDisabled"];
}

-(void)unmuteMusic {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"musicDisabled"];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
