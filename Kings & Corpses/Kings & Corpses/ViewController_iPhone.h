//
//  ViewController_iPhone.h
//  Kings & Corpses
//
//  Created by Danny Perski on 7/23/14.
//  Copyright (c) 2014 Danny Perski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController_iPhone : UIViewController {
    AVAudioPlayer *buttonSound;
    
    float animationSpeed;
    float animationIntensity;
    
    bool ch01;
    bool ch02;
    bool ch03;
    bool ch04;
    bool ch05;
    bool ch06;
    bool ch07;
    bool ch08;
    
    int currentTheme;
    int selectedTheme;
    int occupiedCorners;
    
    IBOutlet UIProgressView *progressView;
    
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
