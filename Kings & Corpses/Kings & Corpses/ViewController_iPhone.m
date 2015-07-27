//
//  ViewController_iPhone_iPhone.m
//  Kings & Corpses
//
//  Created by Danny Perski on 7/23/14.
//  Copyright (c) 2014 Danny Perski. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController_iPhone.h"

@interface ViewController_iPhone ()

@end

@implementation ViewController_iPhone

-(void)buttonSound {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"button" ofType:@"wav"];
    buttonSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    buttonSound.volume = 0.5;
    [buttonSound play];
}

-(IBAction)play {
    [self buttonSound];
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate gameplaySwitch];
}

-(IBAction)menu {
    [self buttonSound];
}

-(IBAction)about {
    [self buttonSound];
}

- (void)viewDidLoad
{
    //settings for animations, gameplay, level generation, etc
    animationSpeed = 0.25;
    animationIntensity = 0.1;
    currentTheme = 1;
    
    /*
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Title" ofType:@"mp3"];
    menuMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    menuMusic.numberOfLoops = -1;
    [menuMusic play];
    
    //this line of code allows you to listen to music on iOS in the background
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    */
    
    //without these lines of code, Kings & Corpses cannot use the Asap font for labels
    [themeLabel setFont: [UIFont fontWithName: @"Asap-Italic" size: themeLabel.font.pointSize]];
    [themeText setFont: [UIFont fontWithName: @"Asap-Italic" size: themeText.font.pointSize]];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end