//
//  About_iPad.h
//  Kings & Corpses
//
//  Created by Danny Perski on 12/20/14.
//  Copyright (c) 2014 Danny Perski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface About_iPad : UIViewController {
    AVAudioPlayer *buttonSound;
    
    IBOutlet UILabel *aboutLabel;
    IBOutlet UILabel *musicToggleLabel;
    
    IBOutlet UISwitch *musicToggle;
}

-(IBAction)switch:(id)sender;

@end
