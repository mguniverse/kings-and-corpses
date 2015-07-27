//
//  Themes_iPad.h
//  Kings & Corpses
//
//  Created by Danny Perski on 1/3/15.
//  Copyright (c) 2015 Danny Perski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Themes_iPad : UIViewController {
    AVAudioPlayer *buttonSound;
    
    float animationSpeed;
    float animationIntensity;
    
    int currentTheme;
    int selectedTheme;
    
    IBOutlet UILabel *themeLabel;
    IBOutlet UITextView *themeText;
    
    IBOutlet UIButton *nextThemeButton;
    IBOutlet UIButton *selectThemeButton;
    
    IBOutlet UIImageView *a1t;
    IBOutlet UIImageView *a2t;
    IBOutlet UIImageView *a3t;
    IBOutlet UIImageView *a4t;
}

@end