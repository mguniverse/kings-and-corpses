//
//  Gameplay_iPhone.h
//  Kings & Corpses
//
//  Created by Danny Perski on 12/18/14.
//  Copyright (c) 2014 Danny Perski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Gameplay_iPhone : UIViewController {
    AVAudioPlayer *buttonSound;
    
    bool defaultLevel;
    bool gameOver;
    bool zombiesDefeated;
    bool creatingKnight;
    bool necromancerSpawned;

    bool a1if;
    bool a2if;
    bool a3if;
    bool a4if;
    bool b1if;
    bool b2if;
    bool b3if;
    bool b4if;
    bool c1if;
    bool c2if;
    bool c3if;
    bool c4if;
    
    int pieces;
    int zombiesMoved;
    int c;
    int r;
    int temp;
    int loneZombies;
    int score;
    int topScore;
    int lastScore;
    int dailyScore;
    int wins;
    int gamemode;
    int displayedScore;
    int selectedTheme;
    
    //1 : kings
    //2 : pawns
    //3 : zombies
    //4 : knights
    
    int kingGeneratePriority;
    int zombieGeneratePriority;
    float animationSpeed;
    float animationIntensity;
    float timerCount;
    float timerIntensity;
    
    int a1p;
    int a2p;
    int a3p;
    int a4p;
    int b1p;
    int b2p;
    int b3p;
    int b4p;
    int c1p;
    int c2p;
    int c3p;
    int c4p;
    
    NSString *currentDate;
    NSString *newDate;
    NSTimer *moveTimer;
    
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *helpLabel;
    IBOutlet UIButton *a1b;
    IBOutlet UIButton *a2b;
    IBOutlet UIButton *a3b;
    IBOutlet UIButton *a4b;
    IBOutlet UIButton *b1b;
    IBOutlet UIButton *b2b;
    IBOutlet UIButton *b3b;
    IBOutlet UIButton *b4b;
    IBOutlet UIButton *c1b;
    IBOutlet UIButton *c2b;
    IBOutlet UIButton *c3b;
    IBOutlet UIButton *c4b;
    
    IBOutlet UIButton *tweetButton;
    IBOutlet UIButton *skipButton;
    IBOutlet UIButton *generateButton;
    IBOutlet UIButton *menuButton;
    
    IBOutlet UIImageView *deadScreen;
    IBOutlet UIImageView *winScreen;
    IBOutlet UIImageView *a1i;
    IBOutlet UIImageView *a2i;
    IBOutlet UIImageView *a3i;
    IBOutlet UIImageView *a4i;
    IBOutlet UIImageView *b1i;
    IBOutlet UIImageView *b2i;
    IBOutlet UIImageView *b3i;
    IBOutlet UIImageView *b4i;
    IBOutlet UIImageView *c1i;
    IBOutlet UIImageView *c2i;
    IBOutlet UIImageView *c3i;
    IBOutlet UIImageView *c4i;
    
    UIImage *emptyImage;
    UIImage *kingImage;
    UIImage *pawnImage;
    UIImage *zombieImage;
    UIImage *knightImage;
}

-(IBAction)start;
-(IBAction)quit;
-(IBAction)tweet;

-(IBAction)a1a;
-(IBAction)a2a;
-(IBAction)a3a;
-(IBAction)a4a;
-(IBAction)b1a;
-(IBAction)b2a;
-(IBAction)b3a;
-(IBAction)b4a;
-(IBAction)c1a;
-(IBAction)c2a;
-(IBAction)c3a;
-(IBAction)c4a;

@end
