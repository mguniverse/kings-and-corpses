//
//  Themes_iPad.m
//  Kings & Corpses
//
//  Created by Danny Perski on 1/3/15.
//  Copyright (c) 2015 Danny Perski. All rights reserved.
//

#import "Themes_iPad.h"

@interface Themes_iPad ()

@end

@implementation Themes_iPad


-(IBAction)nextTheme {
    [self buttonSound];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    themeLabel.transform = CGAffineTransformMakeTranslation(-160, 0);
    themeText.transform = CGAffineTransformMakeTranslation(-160, 0);
    themeLabel.alpha = 0;
    themeText.alpha = 0;
    [UIView commitAnimations];
    
    currentTheme++;
    
    if (currentTheme > 5) {
        currentTheme = 1;
    }
    
    [self performSelector:@selector(offsetThemeText) withObject:self afterDelay:0.1];
}

-(IBAction)selectTheme {
    [self buttonSound];
    selectedTheme = currentTheme;
    
    [[NSUserDefaults standardUserDefaults] setInteger:selectedTheme forKey:@"savedTheme"];
    
    [self loadTheme];
}

-(void)offsetThemeText {
    themeLabel.transform = CGAffineTransformMakeTranslation(160, 0);
    themeText.transform = CGAffineTransformMakeTranslation(160, 0);
    
    [self loadTheme];
}

-(void)loadTheme {
    selectedTheme = [[NSUserDefaults standardUserDefaults] floatForKey:@"savedTheme"];
    
    if (currentTheme == 1) {
        [a1t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"king-large.png"]]];
        [a2t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"pawn-large.png"]]];
        [a3t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"zombie-large.png"]]];
        [a4t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"knight-large.png"]]];
        themeLabel.text = [NSString stringWithFormat:@"Default"];
        
        if (selectedTheme == 1) {
            themeLabel.text = [NSString stringWithFormat:@"(Default)"];
        }
        
        themeText.text = [NSString stringWithFormat:@"The default set for Kings & Corpses."];
    }
    else if (currentTheme == 2) {
        [a1t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"king-xl-large.png"]]];
        [a2t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"pawn-xl-large.png"]]];
        [a3t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"zombie-xl-large.png"]]];
        [a4t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"knight-xl-large.png"]]];
        themeLabel.text = [NSString stringWithFormat:@"Jumbo"];
        
        if (selectedTheme == 2) {
            themeLabel.text = [NSString stringWithFormat:@"(Jumbo)"];
        }
        
        themeText.text = [NSString stringWithFormat:@"All the pieces you love, but bigger and better."];
    }
    else if (currentTheme == 3) {
        [a1t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"king-alpha-large.png"]]];
        [a2t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"pawn-alpha-large.png"]]];
        [a3t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"zombie-alpha-large.png"]]];
        [a4t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"knight-alpha-large.png"]]];
        themeLabel.text = [NSString stringWithFormat:@"Alphabet"];
        
        if (selectedTheme == 3) {
            themeLabel.text = [NSString stringWithFormat:@"(Alphabet)"];
        }
        
        themeText.text = [NSString stringWithFormat:@"These pieces are represented using the game's typeface."];
    }
    else if (currentTheme == 4) {
        [a1t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"king-outline-large.png"]]];
        [a2t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"pawn-outline-large.png"]]];
        [a3t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"zombie-outline-large.png"]]];
        [a4t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"knight-outline-large.png"]]];
        themeLabel.text = [NSString stringWithFormat:@"Outline"];
        
        if (selectedTheme == 4) {
            themeLabel.text = [NSString stringWithFormat:@"(Outline)"];
        }
        
        themeText.text = [NSString stringWithFormat:@"The default set with a thin, outline effect."];
    }
    else if (currentTheme == 5) {
        [a1t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"king-doge-large.png"]]];
        [a2t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"pawn-doge-large.png"]]];
        [a3t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"zombie-doge-large.png"]]];
        [a4t setImage:[UIImage imageNamed:[NSString stringWithFormat:@"knight-doge-large.png"]]];
        themeLabel.text = [NSString stringWithFormat:@"Doge"];
        
        if (selectedTheme == 5) {
            themeLabel.text = [NSString stringWithFormat:@"(Doge)"];
        }
        
        themeText.text = [NSString stringWithFormat:@"Such theme,\nvery customize."];
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    themeLabel.transform = CGAffineTransformMakeTranslation(0, 0);
    themeText.transform = CGAffineTransformMakeTranslation(0, 0);
    themeLabel.alpha = 1;
    themeText.alpha = 1;
    [UIView commitAnimations];
}

-(IBAction)menu {
    [self buttonSound];
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
    
    //settings for animations, gameplay, level generation, etc
    animationSpeed = 0.25;
    animationIntensity = 0.1;
    currentTheme = 1;
    
    [self loadTheme];
    
    //this line of code allows you to listen to music on iOS in the background
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    
    //without these lines of code, Kings & Corpses cannot use the Asap font for labels
    [themeLabel setFont: [UIFont fontWithName: @"Asap-Italic" size: themeLabel.font.pointSize]];
    [themeText setFont: [UIFont fontWithName: @"Asap-Italic" size: themeText.font.pointSize]];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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

@end
