//
//  About_iPhone.m
//  Kings & Corpses
//
//  Created by Danny Perski on 12/20/14.
//  Copyright (c) 2014 Danny Perski. All rights reserved.
//

#import "AppDelegate.h"
#import "About_iPhone.h"

@interface About_iPhone ()

@end

@implementation About_iPhone

-(IBAction)switch:(id)sender {
    if (musicToggle.on) {
        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [appDelegate.menuMusic play];
        [appDelegate unmuteMusic];
        [self buttonSound];
    }
    else {
        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [appDelegate.menuMusic stop];
        [appDelegate muteMusic];
        [self buttonSound];
    }
}

-(IBAction)menu {
    [self buttonSound];
}

-(IBAction)moreGames {
    [self buttonSound];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.mguniverse.com/games"]];
}

-(void)buttonSound {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"button" ofType:@"wav"];
    buttonSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    buttonSound.volume = 0.5;
    [buttonSound play];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"musicDisabled"]) {
        [musicToggle setOn:NO animated:NO];
    }
    else {
        [musicToggle setOn:YES animated:NO];
    }
    
    [aboutLabel setFont: [UIFont fontWithName: @"Asap-Italic" size: aboutLabel.font.pointSize]];
    [musicToggleLabel setFont: [UIFont fontWithName: @"Asap-Italic" size: musicToggleLabel.font.pointSize]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
