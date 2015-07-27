//
//  Tutorial_iPad.h
//  Kings & Corpses
//
//  Created by Danny Perski on 1/2/15.
//  Copyright (c) 2015 Danny Perski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Tutorial_iPad : UIViewController {
    AVAudioPlayer *buttonSound;
    int tutorialPage;
    float animationSpeed;
    float animationIntensity;
    
    IBOutlet UILabel *tutorialLabel;
    IBOutlet UITextView *tutorialText;
    
    IBOutlet UIButton *tutorialNextButton;
    IBOutlet UIButton *tutorialPlayButton;
    
    IBOutlet UIImageView *tutorialScreen;
    
    IBOutlet UISwitch *musicToggle;
}

@end
