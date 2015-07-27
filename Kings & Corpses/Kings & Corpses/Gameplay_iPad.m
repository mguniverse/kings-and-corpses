//
//  Gameplay_iPad.m
//  Kings & Corpses
//
//  Created by Danny Perski on 12/18/14.
//  Copyright (c) 2014 Danny Perski. All rights reserved.
//

#import "AppDelegate.h"
#import "Gameplay_iPad.h"

@interface Gameplay_iPad ()

@end

@implementation Gameplay_iPad

//this is the code you need to initiate before the game begins
-(IBAction)start {
    //this button generates a new level and only works if you are not in the game over transition
    if (gameOver == false) {
        [self buttonSound];
        pieces = 6;
        score = 0;
        zombiesDefeated = false;
        
        if (gamemode == 2) {
        }
        
        else {
            [self clearLevel];
            while (pieces > 0) {
                [self generateLevel];
            }
        }
    }
}

-(IBAction)skipTurn {
    if (gameOver == false) {
        [self buttonSound];
        [self endTurn];
    }
}

//when you return to the main menu do this
-(IBAction)quit {
    [self buttonSound];
}

-(IBAction)buttonAction {
    [self buttonSound];
}

-(IBAction)swapScoreText {
    displayedScore++;
    if (displayedScore > 2) {
        displayedScore = 0;
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:displayedScore forKey:@"savedDisplayedScore"];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationSpeed];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    scoreLabel.alpha = 0;
    
    [UIView commitAnimations];
    
    [self performSelector:@selector(startScoreAnimation) withObject:self afterDelay:animationSpeed];
}

-(void)showDisplayedScore {
    if (displayedScore == 0) {
        scoreLabel.text = [NSString stringWithFormat: @"Top: %i", topScore];
    }
    else if (displayedScore == 1) {
        scoreLabel.text = [NSString stringWithFormat: @"Daily: %i", dailyScore];
    }
    else if (displayedScore == 2) {
        scoreLabel.text = [NSString stringWithFormat: @"Wins: %i", wins];
    }
}

-(void)startScoreAnimation {
    if (displayedScore == 0) {
        scoreLabel.text = [NSString stringWithFormat: @"Top: %i", topScore];
    }
    else if (displayedScore == 1) {
        scoreLabel.text = [NSString stringWithFormat: @"Daily: %i", dailyScore];
    }
    else if (displayedScore == 2) {
        scoreLabel.text = [NSString stringWithFormat: @"Wins: %i", wins];
    }
    
    [self performSelector:@selector(finishScoreAnimation) withObject:self afterDelay:animationSpeed];
}

-(IBAction)finishScoreAnimation {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationSpeed];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    scoreLabel.alpha = 1;
    
    [UIView commitAnimations];
}

-(void)buttonSound {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"button" ofType:@"wav"];
    buttonSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    buttonSound.volume = 0.5;
    [buttonSound play];
}

-(IBAction)menu {
    [self buttonSound];
    [self clearLevel];
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate titleSwitch];
}

-(IBAction)a1a {
    [self buttonSound];
    
    if (a1if == true) {
        [self cancelGrid];
    }
    
    else if (b1if == true) {
        if (b1p == 4 && a1p == 3) {
            b1p = 2;
            a1p = 4;
        }
        else {
            temp = b1p;
            b1p = a1p;
            a1p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (a2if == true) {
        if (a2p == 4 && a1p == 3) {
            a2p = 2;
            a1p = 4;
        }
        else {
            temp = a2p;
            a2p = a1p;
            a1p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (creatingKnight == true) {
        if (a1p == 2) {
            a1p = 4;
            [self finishKnight];
            [self loadLevel];
            [self cancelGrid];
        }
    }
    
    else if (a1p != 0 && a1p != 3) {
        a1if = true;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationSpeed];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        a3i.alpha = animationIntensity;
        a4i.alpha = animationIntensity;
        b2i.alpha = animationIntensity;
        b3i.alpha = animationIntensity;
        b4i.alpha = animationIntensity;
        c1i.alpha = animationIntensity;
        c2i.alpha = animationIntensity;
        c3i.alpha = animationIntensity;
        c4i.alpha = animationIntensity;
        
        [UIView commitAnimations];
        
        if (a1p != 4 && a2p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            a2i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (a1p != 4 && b1p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            b1i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        
        [self disableTheFaded];
    }
}
-(IBAction)a2a {
    [self buttonSound];
    
    if (a2if == true) {
        [self cancelGrid];
    }
    
    else if (a1if == true) {
        if (a1p == 4 && a2p == 3) {
            a1p = 2;
            a2p = 4;
        }
        else {
            temp = a1p;
            a1p = a2p;
            a2p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (b2if == true) {
        if (b2p == 4 && a2p == 3) {
            b2p = 2;
            a2p = 4;
        }
        else {
            temp = b2p;
            b2p = a2p;
            a2p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (a3if == true) {
        if (a3p == 4 && a2p == 3) {
            a3p = 2;
            a2p = 4;
        }
        else {
            temp = a3p;
            a3p = a2p;
            a2p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (creatingKnight == true) {
        if (a2p == 2) {
            a2p = 4;
            [self finishKnight];
            [self loadLevel];
            [self cancelGrid];
        }
    }
    
    else if (a2p != 0 && a2p != 3) {
        a2if = true;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationSpeed];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        a4i.alpha = animationIntensity;
        b1i.alpha = animationIntensity;
        b3i.alpha = animationIntensity;
        b4i.alpha = animationIntensity;
        c1i.alpha = animationIntensity;
        c2i.alpha = animationIntensity;
        c3i.alpha = animationIntensity;
        c4i.alpha = animationIntensity;
        
        [UIView commitAnimations];
        
        if (a2p != 4 && a1p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            a1i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (a2p != 4 && a3p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            a3i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (a2p != 4 && b2p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            b2i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        
        [self disableTheFaded];
    }
}
-(IBAction)a3a {
    [self buttonSound];
    
    if (a3if == true) {
        [self cancelGrid];
    }
    
    else if (a2if == true) {
        if (a2p == 4 && a3p == 3) {
            a2p = 2;
            a3p = 4;
        }
        else {
            temp = a2p;
            a2p = a3p;
            a3p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (b3if == true) {
        if (b3p == 4 && a3p == 3) {
            b3p = 2;
            a3p = 4;
        }
        else {
            temp = b3p;
            b3p = a3p;
            a3p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (a4if == true) {
        if (a4p == 4 && a3p == 3) {
            a4p = 2;
            a3p = 4;
        }
        else {
            temp = a4p;
            a4p = a3p;
            a3p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (creatingKnight == true) {
        if (a3p == 2) {
            a3p = 4;
            [self finishKnight];
            [self loadLevel];
            [self cancelGrid];
        }
    }
    
    else if (a3p != 0 && a3p != 3) {
        a3if = true;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationSpeed];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        a1i.alpha = animationIntensity;
        b1i.alpha = animationIntensity;
        b2i.alpha = animationIntensity;
        b4i.alpha = animationIntensity;
        c1i.alpha = animationIntensity;
        c2i.alpha = animationIntensity;
        c3i.alpha = animationIntensity;
        c4i.alpha = animationIntensity;
        
        [UIView commitAnimations];
        
        if (a3p != 4 && a2p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            a2i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (a3p != 4 && a4p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            a4i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (a3p != 4 && b3p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            b3i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        
        [self disableTheFaded];
    }
}
-(IBAction)a4a {
    [self buttonSound];
    
    if (a4if == true) {
        [self cancelGrid];
    }
    
    else if (a3if == true) {
        if (a3p == 4 && a4p == 3) {
            a3p = 2;
            a4p = 4;
        }
        else {
            temp = a3p;
            a3p = a4p;
            a4p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (b4if == true) {
        if (b4p == 4 && a4p == 3) {
            b4p = 2;
            a4p = 4;
        }
        else {
            temp = b4p;
            b4p = a4p;
            a4p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (creatingKnight == true) {
        if (a4p == 2) {
            a4p = 4;
            [self finishKnight];
            [self loadLevel];
            [self cancelGrid];
        }
    }
    
    else if (a4p != 0 && a4p != 3) {
        a4if = true;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationSpeed];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        a1i.alpha = animationIntensity;
        a2i.alpha = animationIntensity;
        b1i.alpha = animationIntensity;
        b2i.alpha = animationIntensity;
        b3i.alpha = animationIntensity;
        c1i.alpha = animationIntensity;
        c2i.alpha = animationIntensity;
        c3i.alpha = animationIntensity;
        c4i.alpha = animationIntensity;
        
        [UIView commitAnimations];
        
        if (a4p != 4 && a3p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            a3i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (a4p != 4 && b4p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            b4i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        
        [self disableTheFaded];
    }
}
-(IBAction)b1a {
    [self buttonSound];
    
    if (b1if == true) {
        [self cancelGrid];
    }
    
    else if (a1if == true) {
        if (a1p == 4 && b1p == 3) {
            a1p = 2;
            b1p = 4;
        }
        else {
            temp = a1p;
            a1p = b1p;
            b1p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (c1if == true) {
        if (c1p == 4 && b1p == 3) {
            c1p = 2;
            b1p = 4;
        }
        else {
            temp = c1p;
            c1p = b1p;
            b1p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (b2if == true) {
        if (b2p == 4 && b1p == 3) {
            b2p = 2;
            b1p = 4;
        }
        else {
            temp = b2p;
            b2p = b1p;
            b1p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (creatingKnight == true) {
        if (b1p == 2) {
            b1p = 4;
            [self finishKnight];
            [self loadLevel];
            [self cancelGrid];
        }
    }
    
    else if (b1p != 0 && b1p != 3) {
        b1if = true;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationSpeed];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        a2i.alpha = animationIntensity;
        a3i.alpha = animationIntensity;
        a4i.alpha = animationIntensity;
        b3i.alpha = animationIntensity;
        b4i.alpha = animationIntensity;
        c2i.alpha = animationIntensity;
        c3i.alpha = animationIntensity;
        c4i.alpha = animationIntensity;
        
        [UIView commitAnimations];
        
        if (b1p != 4 && a1p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            a1i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (b1p != 4 && b2p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            b2i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (b1p != 4 && c1p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            c1i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        
        [self disableTheFaded];
    }
}
-(IBAction)b2a {
    [self buttonSound];
    
    if (b2if == true) {
        [self cancelGrid];
    }
    
    else if (b1if == true) {
        if (b1p == 4 && b2p == 3) {
            b1p = 2;
            b2p = 4;
        }
        else {
            temp = b2p;
            b2p = b1p;
            b1p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (a2if == true) {
        if (a2p == 4 && b2p == 3) {
            a2p = 2;
            b2p = 4;
        }
        else {
            temp = a2p;
            a2p = b2p;
            b2p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (c2if == true) {
        if (c2p == 4 && b2p == 3) {
            c2p = 2;
            b2p = 4;
        }
        else {
            temp = c2p;
            c2p = b2p;
            b2p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (b3if == true) {
        if (b3p == 4 && b2p == 3) {
            b3p = 2;
            b2p = 4;
        }
        else {
            temp = b3p;
            b3p = b2p;
            b2p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (creatingKnight == true) {
        if (b2p == 2) {
            b2p = 4;
            [self finishKnight];
            [self loadLevel];
            [self cancelGrid];
        }
    }
    
    else if (b2p != 0 && b2p != 3) {
        b2if = true;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationSpeed];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        a1i.alpha = animationIntensity;
        a3i.alpha = animationIntensity;
        a4i.alpha = animationIntensity;
        b4i.alpha = animationIntensity;
        c1i.alpha = animationIntensity;
        c3i.alpha = animationIntensity;
        c4i.alpha = animationIntensity;
        
        [UIView commitAnimations];
        
        if (b2p != 4 && a2p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            a2i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (b2p != 4 && b1p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            b1i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (b2p != 4 && b3p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            b3i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (b2p != 4 && c2p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            c2i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        
        [self disableTheFaded];
    }
}
-(IBAction)b3a {
    [self buttonSound];
    
    if (b3if == true) {
        [self cancelGrid];
    }
    
    else if (b2if == true) {
        if (b2p == 4 && b3p == 3) {
            b2p = 2;
            b3p = 4;
        }
        else {
            temp = b2p;
            b2p = b3p;
            b3p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (a3if == true) {
        if (a3p == 4 && b3p == 3) {
            a3p = 2;
            b3p = 4;
        }
        else {
            temp = a3p;
            a3p = b3p;
            b3p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (c3if == true) {
        if (c3p == 4 && b3p == 3) {
            c3p = 2;
            b3p = 4;
        }
        else {
            temp = c3p;
            c3p = b3p;
            b3p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (b4if == true) {
        if (b4p == 4 && b3p == 3) {
            b4p = 2;
            b3p = 4;
        }
        else {
            temp = b4p;
            b4p = b3p;
            b3p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (creatingKnight == true) {
        if (b3p == 2) {
            b3p = 4;
            [self finishKnight];
            [self loadLevel];
            [self cancelGrid];
        }
    }
    
    else if (b3p != 0 && b3p != 3) {
        b3if = true;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationSpeed];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        a1i.alpha = animationIntensity;
        a2i.alpha = animationIntensity;
        a4i.alpha = animationIntensity;
        b1i.alpha = animationIntensity;
        c1i.alpha = animationIntensity;
        c2i.alpha = animationIntensity;
        c4i.alpha = animationIntensity;
        
        [UIView commitAnimations];
        
        if (b3p != 4 && a3p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            a3i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (b3p != 4 && b2p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            b2i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (b3p != 4 && b4p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            b4i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (b3p != 4 && c3p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            c3i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        
        [self disableTheFaded];
    }
}
-(IBAction)b4a {
    [self buttonSound];
    
    if (b4if == true) {
        [self cancelGrid];
    }
    
    else if (b3if == true) {
        if (b3p == 4 && b4p == 3) {
            b3p = 2;
            b4p = 4;
        }
        else {
            temp = b3p;
            b3p = b4p;
            b4p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (a4if == true) {
        if (a4p == 4 && b4p == 3) {
            a4p = 2;
            b4p = 4;
        }
        else {
            temp = a4p;
            a4p = b4p;
            b4p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (c4if == true) {
        if (c4p == 4 && b4p == 3) {
            c4p = 2;
            b4p = 4;
        }
        else {
            temp = c4p;
            c4p = b4p;
            b4p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (creatingKnight == true) {
        if (b4p == 2) {
            b4p = 4;
            [self finishKnight];
            [self loadLevel];
            [self cancelGrid];
        }
    }
    
    else if (b4p != 0 && b4p != 3) {
        b4if = true;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationSpeed];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        a1i.alpha = animationIntensity;
        a2i.alpha = animationIntensity;
        a3i.alpha = animationIntensity;
        b1i.alpha = animationIntensity;
        b2i.alpha = animationIntensity;
        c1i.alpha = animationIntensity;
        c2i.alpha = animationIntensity;
        c3i.alpha = animationIntensity;
        
        [UIView commitAnimations];
        
        if (b4p != 4 && a4p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            a4i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (b4p != 4 && b3p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            b3i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (b4p != 4 && c4p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            c4i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        
        [self disableTheFaded];
    }
}
-(IBAction)c1a {
    [self buttonSound];
    
    if (c1if == true) {
        [self cancelGrid];
    }
    
    else if (b1if == true) {
        if (b1p == 4 && c1p == 3) {
            b1p = 2;
            c1p = 4;
        }
        else {
            temp = c1p;
            c1p = b1p;
            b1p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (c2if == true) {
        if (c2p == 4 && c1p == 3) {
            c2p = 2;
            c1p = 4;
        }
        else {
            temp = c2p;
            c2p = c1p;
            c1p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (creatingKnight == true) {
        if (c1p == 2) {
            c1p = 4;
            [self finishKnight];
            [self loadLevel];
            [self cancelGrid];
        }
    }
    
    else if (c1p != 0 && c1p != 3) {
        c1if = true;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationSpeed];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        a1i.alpha = animationIntensity;
        a2i.alpha = animationIntensity;
        a3i.alpha = animationIntensity;
        a4i.alpha = animationIntensity;
        b2i.alpha = animationIntensity;
        b3i.alpha = animationIntensity;
        b4i.alpha = animationIntensity;
        c3i.alpha = animationIntensity;
        c4i.alpha = animationIntensity;
        
        [UIView commitAnimations];
        
        if (c1p != 4 && b1p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            b1i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (c1p != 4 && c2p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            c2i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        
        [self disableTheFaded];
    }
}
-(IBAction)c2a {
    [self buttonSound];
    
    if (c2if == true) {
        [self cancelGrid];
    }
    
    else if (c1if == true) {
        if (c1p == 4 && c2p == 3) {
            c1p = 2;
            c2p = 4;
        }
        else {
            temp = c1p;
            c1p = c2p;
            c2p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (b2if == true) {
        if (b2p == 4 && c2p == 3) {
            b2p = 2;
            c2p = 4;
        }
        else {
            temp = b2p;
            b2p = c2p;
            c2p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (c3if == true) {
        if (c3p == 4 && c2p == 3) {
            c3p = 2;
            c2p = 4;
        }
        else {
            temp = c3p;
            c3p = c2p;
            c2p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (creatingKnight == true) {
        if (c2p == 2) {
            c2p = 4;
            [self finishKnight];
            [self loadLevel];
            [self cancelGrid];
        }
    }
    
    else if (c2p != 0 && c2p != 3) {
        c2if = true;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationSpeed];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        a1i.alpha = animationIntensity;
        a2i.alpha = animationIntensity;
        a3i.alpha = animationIntensity;
        a4i.alpha = animationIntensity;
        b1i.alpha = animationIntensity;
        b3i.alpha = animationIntensity;
        b4i.alpha = animationIntensity;
        c4i.alpha = animationIntensity;
        
        [UIView commitAnimations];
        
        if (c2p != 4 && b2p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            b2i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (c2p != 4 && c1p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            c1i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (c2p != 4 && c3p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            c3i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        
        [self disableTheFaded];
    }
}
-(IBAction)c3a {
    [self buttonSound];
    
    if (c3if == true) {
        [self cancelGrid];
    }
    
    else if (c2if == true) {
        if (c2p == 4 && c3p == 3) {
            c2p = 2;
            c3p = 4;
        }
        else {
            temp = c2p;
            c2p = c3p;
            c3p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (b3if == true) {
        if (b3p == 4 && c3p == 3) {
            b3p = 2;
            c3p = 4;
        }
        else {
            temp = b3p;
            b3p = c3p;
            c3p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (c4if == true) {
        if (c4p == 4 && c3p == 3) {
            c4p = 2;
            c3p = 4;
        }
        else {
            temp = c4p;
            c4p = c3p;
            c3p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (creatingKnight == true) {
        if (c3p == 2) {
            c3p = 4;
            [self finishKnight];
            [self loadLevel];
            [self cancelGrid];
        }
    }
    
    else if (c3p != 0 && c3p != 3) {
        c3if = true;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationSpeed];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        a1i.alpha = animationIntensity;
        a2i.alpha = animationIntensity;
        a3i.alpha = animationIntensity;
        a4i.alpha = animationIntensity;
        b1i.alpha = animationIntensity;
        b2i.alpha = animationIntensity;
        b4i.alpha = animationIntensity;
        c1i.alpha = animationIntensity;
        
        [UIView commitAnimations];
        
        if (c3p != 4 && b3p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            b3i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (c3p != 4 && c2p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            c2i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (c3p != 4 && c4p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            c4i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        
        [self disableTheFaded];
    }
}
-(IBAction)c4a {
    [self buttonSound];
    
    if (c4if == true) {
        [self cancelGrid];
    }
    
    else if (c3if == true) {
        if (c3p == 4 && c4p == 3) {
            c3p = 2;
            c4p = 4;
        }
        else {
            temp = c3p;
            c3p = c4p;
            c4p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (b4if == true) {
        if (b4p == 4 && c4p == 3) {
            b4p = 2;
            c4p = 4;
        }
        else {
            temp = b4p;
            b4p = c4p;
            c4p = temp;
        }
        
        [self loadLevel];
        [self cancelGrid];
        [self endTurn];
    }
    
    else if (creatingKnight == true) {
        if (c4p == 2) {
            c4p = 4;
            [self finishKnight];
            [self loadLevel];
            [self cancelGrid];
        }
    }
    
    else if (c4p != 0 && c4p != 3) {
        c4if = true;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationSpeed];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        a1i.alpha = animationIntensity;
        a2i.alpha = animationIntensity;
        a3i.alpha = animationIntensity;
        a4i.alpha = animationIntensity;
        b1i.alpha = animationIntensity;
        b2i.alpha = animationIntensity;
        b3i.alpha = animationIntensity;
        c1i.alpha = animationIntensity;
        c2i.alpha = animationIntensity;
        
        [UIView commitAnimations];
        
        if (c4p != 4 && b4p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            b4i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (c4p != 4 && c3p == 3) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            c3i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        
        [self disableTheFaded];
    }
}

-(IBAction)tweet {
    [self buttonSound];
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *tweetSheet =[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        if (zombiesDefeated == false) {
            [tweetSheet setInitialText: [NSString stringWithFormat:@"My king survived for %i turns in Kings & Corpses by @mguniverse!",lastScore]];
        }
        
        else {
            [tweetSheet setInitialText: [NSString stringWithFormat:@"The king is saved, I've beaten Kings & Corpses by @mguniverse!"]];
        }
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
        
    }
    
    else {
        //This alreat tells the user that they can't use built in socal interegration and why they can't.
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"The tweet could not be tweeted, connect to your Twitter account via the Settings app and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)getDate {
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    
    newDate = dateString;
    
    if (![newDate isEqualToString:currentDate]) {
        currentDate = newDate;
        dailyScore = 0;
        [[NSUserDefaults standardUserDefaults] setInteger:dailyScore forKey:@"savedDaily"];
        [[NSUserDefaults standardUserDefaults] setObject:newDate forKey:@"savedNewDate"];
        [[NSUserDefaults standardUserDefaults] setObject:currentDate forKey:@"savedCurrentDate"];
    }
}

-(void)endTurn {
    [self disableAllButtons];
    [self checkForZombies];
    
    if (zombiesDefeated == false) {
        [self countZombies];
        zombiesMoved = 0;
        score++;
        
        
        if (loneZombies != 0) {
            while (zombiesMoved < 1) {
                [self zombieAttack];
            }
        }
        
        else {
            while (zombiesMoved < 1) {
                [self zombieMove];
            }
        }
        
        [self loadLevel];
        [self enableAllButtons];
        [self checkForDeadKings];
    }
}

-(void)checkForZombies {
    if (a1p != 3 && a2p != 3 && a3p != 3 && a4p != 3 && b1p != 3 && b2p != 3 && b3p != 3 && b4p != 3 && c1p != 3 && c2p != 3 && c3p != 3 && c4p != 3) {
        [moveTimer invalidate];
        zombiesDefeated = true;
        
        //add one point for the winning move, multiply total score by 2
        score++;
        scoreLabel.text = [NSString stringWithFormat: @"Score: %i", score];
        score = score * 2;
        
        [self disableAllButtons];
        [self animateGridAway];
        gameOver = true;
        
        wins++;
        [[NSUserDefaults standardUserDefaults] setInteger:wins forKey:@"savedWins"];
        
        if (score > topScore) {
            topScore = score;
            [[NSUserDefaults standardUserDefaults] setInteger:topScore forKey:@"savedScore"];
        }
        
        if (score > dailyScore) {
            dailyScore = score;
            [[NSUserDefaults standardUserDefaults] setInteger:dailyScore forKey:@"savedDaily"];
        }
        
        [self performSelector:@selector(gameOver) withObject:self afterDelay:2.0];
    }
}

-(void)checkForDeadKings {
    if (a1p != 1 && a2p != 1 && a3p != 1 && a4p != 1 && b1p != 1 && b2p != 1 && b3p != 1 && b4p != 1 && c1p != 1 && c2p != 1 && c3p != 1 && c4p != 1) {
        [moveTimer invalidate];
        [self disableAllButtons];
        [self animateGridAway];
        gameOver = true;
        
        if (score > topScore) {
            topScore = score;
            [[NSUserDefaults standardUserDefaults] setInteger:topScore forKey:@"savedScore"];
        }
        
        if (score > dailyScore) {
            dailyScore = score;
            [[NSUserDefaults standardUserDefaults] setInteger:dailyScore forKey:@"savedDaily"];
        }
        
        //save current score as last score, then set current score to 0
        lastScore = score;
        score = 0;
        
        [self performSelector:@selector(gameOver) withObject:self afterDelay:2.0];
    }
    
    else if ((score % 5) == 0) {
        [self createKnight];
    }
}

-(void)createKnight {
    if (a1p == 2 || a2p == 2 || a3p == 2 || a4p == 2 || b1p == 2 || b2p == 2 || b3p == 2 || b4p == 2 || c1p == 2 || c2p == 2 || c3p == 2 || c4p == 2) {
        [moveTimer invalidate];
        creatingKnight = true;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationSpeed];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        skipButton.alpha = 0;
        generateButton.alpha = 0;
        helpLabel.alpha = 1;
        
        [UIView commitAnimations];
        
        if (a1p != 2) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            a1i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (a2p != 2) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            a2i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (a3p != 2) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            a3i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (a4p != 2) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            a4i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (b1p != 2) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            b1i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (b2p != 2) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            b2i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (b3p != 2) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            b3i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (b4p != 2) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            b4i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (c1p != 2) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            c1i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (c2p != 2) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            c2i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (c3p != 2) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            c3i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
        if (c4p != 2) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            c4i.alpha = animationIntensity;
            
            [UIView commitAnimations];
        }
    }
}

-(void)finishKnight {
    creatingKnight = false;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationSpeed];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    skipButton.alpha = 1;
    generateButton.alpha = 1;
    helpLabel.alpha = 0;
    
    [UIView commitAnimations];
}

-(void)gameOver {
    [moveTimer invalidate];
    
    if (gamemode == 2) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationSpeed];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        skipButton.alpha = 0;
        scoreLabel.alpha = 0;
        menuButton.alpha = 0;
        
        [UIView commitAnimations];
    }
    
    else {
        if (zombiesDefeated == true) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            [deadScreen setImage:[UIImage imageNamed:[NSString stringWithFormat:@"win-screen-large.png"]]];
            deadScreen.alpha = 1;
            tweetButton.alpha = 1;
            skipButton.alpha = 0;
            
            [UIView commitAnimations];
            
            //show updated score, multiplied for winning
            scoreLabel.text = [NSString stringWithFormat: @"Score: %i", score];
        }
        
        else {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationSpeed];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            [deadScreen setImage:[UIImage imageNamed:[NSString stringWithFormat:@"dead-screen-large.png"]]];
            deadScreen.alpha = 1;
            tweetButton.alpha = 1;
            skipButton.alpha = 0;
            
            [UIView commitAnimations];
        }
    }
    
    gameOver = false;
}

-(void)animateGridAway {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationSpeed];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    [UIView commitAnimations];
    
    //fancy game over animation, animates pieces away one row at a time
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationSpeed];
    [UIView setAnimationDelay:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    a1i.alpha = 0;
    a2i.alpha = 0;
    a3i.alpha = 0;
    a4i.alpha = 0;
    
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationSpeed];
    [UIView setAnimationDelay:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    b1i.alpha = 0;
    b2i.alpha = 0;
    b3i.alpha = 0;
    b4i.alpha = 0;
    
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationSpeed];
    [UIView setAnimationDelay:1.5];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    c1i.alpha = 0;
    c2i.alpha = 0;
    c3i.alpha = 0;
    c4i.alpha = 0;
    
    [UIView commitAnimations];
}

-(void)countZombies {
    //if there is one zombie that is not touching a pawn or king, the next zombie move will be an attack
    loneZombies = 0;
    
    if (a1p == 3) {
        if (a2p == 4 || a2p == 2 || a2p == 1 || b1p == 4 || b1p == 2 || b1p == 1) {
            loneZombies++;
        }
    }
    if (a2p == 3) {
        if (a1p == 4 || a1p == 2 || a1p == 1 || a3p == 4 || a3p == 2 || a3p == 1 || b2p == 4 || b2p == 2 || b2p == 1) {
            loneZombies++;
        }
    }
    if (a3p == 3) {
        if (a2p == 4 || a2p == 2 || a2p == 1 || a4p == 4 || a4p == 2 || a4p == 1 || b3p == 4 || b3p == 2 || b3p == 1) {
            loneZombies++;
        }
    }
    if (a4p == 3) {
        if (a3p == 4 || a3p == 2 || a3p == 1 || b4p == 4 || b4p == 4 || b4p == 2 || b4p == 1) {
            loneZombies++;
        }
    }
    if (b1p == 3) {
        if (a1p == 4 || a1p == 2 || a1p == 1 || b2p == 4 || b2p == 2 || b2p == 1 || c1p == 4 || c1p == 2 || c1p == 1) {
            loneZombies++;
        }
    }
    if (b2p == 3) {
        if (a2p == 4 || a2p == 2 || a2p == 1 || b1p == 4 || b1p == 2 || b1p == 1 || b3p == 4 || b3p == 2 || b3p == 1 || c2p == 4 || c2p == 2 || c2p == 1) {
            loneZombies++;
        }
    }
    if (b3p == 3) {
        if (a3p == 4 || a3p == 2 || a3p == 1 || b2p == 4 || b2p == 2 || b2p == 1 || b4p == 4 || b4p == 4 || b4p == 2 || b4p == 1 || c3p == 4 || c3p == 2 || c3p == 1) {
            loneZombies++;
        }
    }
    if (b4p == 3) {
        if (a4p == 4 || a4p == 2 || a4p == 1 || b3p == 4 || b3p == 2 || b3p == 1 || c4p == 4 || c4p == 2 || c4p == 1) {
            loneZombies++;
        }
    }
    if (c1p == 3) {
        if (b1p == 4 || b1p == 2 || b1p == 1 || c2p == 4 || c2p == 2 || c2p == 1) {
            loneZombies++;
        }
    }
    if (c2p == 3) {
        if (b2p == 4 || b2p == 2 || b2p == 1 || c1p == 4 || c1p == 2 || c1p == 1 || c3p == 4 || c3p == 2 || c3p == 1) {
            loneZombies++;
        }
    }
    if (c3p == 3) {
        if (b3p == 4 || b3p == 2 || b3p == 1 || c2p == 4 || c2p == 2 || c2p == 1 || c4p == 4 || c4p == 2 || c4p == 1) {
            loneZombies++;
        }
    }
    if (c4p == 3) {
        if (b4p == 4 || b4p == 4 || b4p == 2 || b4p == 1 || c3p == 4 || c3p == 2 || c3p == 1) {
            loneZombies++;
        }
    }
}

-(void)zombieAttack {
    //randomly chooses a zombie to attack, but doesn't randomly choose a target (will fix later)
    int column = arc4random() % 4;
    int row = arc4random() % 3;
    
    if (row == 0) {
        if (column == 0) {
            if (a1p == 3) {
                if (a2p != 0 && a2p != 3) {
                    a2p = 3;
                    
                    zombiesMoved++;
                }
                else if (b1p != 0 && b1p != 3) {
                    b1p = 3;
                    
                    zombiesMoved++;
                }
            }
        }
        if (column == 1) {
            if (a2p == 3) {
                if (a1p != 0 && a1p != 3) {
                    a1p = 3;
                    
                    zombiesMoved++;
                }
                else if (a3p != 0 && a3p != 3) {
                    a3p = 3;
                    
                    zombiesMoved++;
                }
                else if (b2p != 0 && b2p != 3) {
                    b2p = 3;
                    
                    zombiesMoved++;
                }
            }
        }
        if (column == 2) {
            if (a3p == 3) {
                if (a2p != 0 && a2p != 3) {
                    a2p = 3;
                    
                    zombiesMoved++;
                }
                else if (a4p != 0 && a4p != 3) {
                    a4p = 3;
                    
                    zombiesMoved++;
                }
                else if (b3p != 0 && b3p != 3) {
                    b3p = 3;
                    
                    zombiesMoved++;
                }
            }
        }
        if (column == 3) {
            if (a4p == 3) {
                if (a3p != 0 && a3p != 3) {
                    a3p = 3;
                    
                    zombiesMoved++;
                }
                else if (b4p != 0 && b4p != 3) {
                    b4p = 3;
                    
                    zombiesMoved++;
                }
            }
        }
    }
    else if (row == 1) {
        if (column == 0) {
            if (b1p == 3) {
                if (a1p != 0 && a1p != 3) {
                    a1p = 3;
                    
                    zombiesMoved++;
                }
                else if (b2p != 0 && b2p != 3) {
                    b2p = 3;
                    
                    zombiesMoved++;
                }
                else if (c1p != 0 && c1p != 3) {
                    c1p = 3;
                    
                    zombiesMoved++;
                }
            }
        }
        if (column == 1) {
            if (b2p == 3) {
                if (a2p != 0 && a2p != 3) {
                    a2p = 3;
                    
                    zombiesMoved++;
                }
                else if (b1p != 0 && b1p != 3) {
                    b1p = 3;
                    
                    zombiesMoved++;
                }
                else if (b3p != 0 && b3p != 3) {
                    b3p = 3;
                    
                    zombiesMoved++;
                }
                else if (c2p != 0 && c2p != 3) {
                    c2p = 3;
                    
                    zombiesMoved++;
                }
            }
        }
        if (column == 2) {
            if (b3p == 3) {
                if (a3p != 0 && a3p != 3) {
                    a3p = 3;
                    
                    zombiesMoved++;
                }
                else if (b2p != 0 && b2p != 3) {
                    b2p = 3;
                    
                    zombiesMoved++;
                }
                else if (b4p != 0 && b4p != 3) {
                    b4p = 3;
                    
                    zombiesMoved++;
                }
                else if (c3p != 0 && c3p != 3) {
                    c3p = 3;
                    
                    zombiesMoved++;
                }
            }
        }
        if (column == 3) {
            if (b4p == 3) {
                if (a4p != 0 && a4p != 3) {
                    a4p = 3;
                    
                    zombiesMoved++;
                }
                else if (b3p != 0 && b3p != 3) {
                    b3p = 3;
                    
                    zombiesMoved++;
                }
                else if (c4p != 0 && c4p != 3) {
                    c4p = 3;
                    
                    zombiesMoved++;
                }
            }
        }
    }
    else if (row == 2) {
        if (column == 0) {
            if (c1p == 3) {
                if (b1p != 0 && b1p != 3) {
                    b1p = 3;
                    
                    zombiesMoved++;
                }
                else if (c2p != 0 && c2p != 3) {
                    c2p = 3;
                    
                    zombiesMoved++;
                }
            }
        }
        if (column == 1) {
            if (c2p == 3) {
                if (b2p != 0 && b2p != 3) {
                    b2p = 3;
                    
                    zombiesMoved++;
                }
                else if (c1p != 0 && c1p != 3) {
                    c1p = 3;
                    
                    zombiesMoved++;
                }
                else if (c3p != 0 && c3p != 3) {
                    c3p = 3;
                    
                    zombiesMoved++;
                }
            }
        }
        if (column == 2) {
            if (c3p == 3) {
                if (b3p != 0 && b3p != 3) {
                    b3p = 3;
                    
                    zombiesMoved++;
                }
                else if (c2p != 0 && c2p != 3) {
                    c2p = 3;
                    
                    zombiesMoved++;
                }
                else if (c4p != 0 && c4p != 3) {
                    c4p = 3;
                    
                    zombiesMoved++;
                }
            }
        }
        if (column == 3) {
            if (c4p == 3) {
                if (b4p != 0 && b4p != 3) {
                    b4p = 3;
                    
                    zombiesMoved++;
                }
                else if (c3p != 0 && c3p != 3) {
                    c3p = 3;
                    
                    zombiesMoved++;
                }
            }
        }
    }
}

-(void)zombieMove {
    //similar to level generation, random row and column to decide which zombie piece will be moved
    int column = arc4random() % 4;
    int row = arc4random() % 3;
    
    if (row == 0) {
        if (column == 0) {
            if (a1p == 3) {
                int zTemp = arc4random() % 2;
                
                if (zTemp == 0) {
                    if (a2p == 0) {
                        a2p = 3;
                        a1p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 1) {
                    if (b1p == 0) {
                        b1p = 3;
                        a1p = 0;
                        
                        zombiesMoved++;
                    }
                }
            }
        }
        if (column == 1) {
            if (a2p == 3) {
                int zTemp = arc4random() % 3;
                
                if (zTemp == 0) {
                    if (a1p == 0) {
                        a1p = 3;
                        a2p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 1) {
                    if (a3p == 0) {
                        a3p = 3;
                        a2p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 2) {
                    if (b2p == 0) {
                        b2p = 3;
                        a2p = 0;
                        
                        zombiesMoved++;
                    }
                }
            }
        }
        if (column == 2) {
            if (a3p == 3) {
                int zTemp = arc4random() % 3;
                
                if (zTemp == 0) {
                    if (a2p == 0) {
                        a2p = 3;
                        a3p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 1) {
                    if (a4p == 0) {
                        a4p = 3;
                        a3p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 2) {
                    if (b3p == 0) {
                        b3p = 3;
                        a3p = 0;
                        
                        zombiesMoved++;
                    }
                }
            }
        }
        if (column == 3) {
            if (a4p == 3) {
                int zTemp = arc4random() % 2;
                
                if (zTemp == 0) {
                    if (a3p == 0) {
                        a3p = 3;
                        a4p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 1) {
                    if (b4p == 0) {
                        b4p = 3;
                        a4p = 0;
                        
                        zombiesMoved++;
                    }
                }
            }
        }
    }
    else if (row == 1) {
        if (column == 0) {
            if (b1p == 3) {
                int zTemp = arc4random() % 3;
                
                if (zTemp == 0) {
                    if (a1p == 0) {
                        a1p = 3;
                        b1p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 1) {
                    if (b2p == 0) {
                        b2p = 3;
                        b1p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 2) {
                    if (c1p == 0) {
                        c1p = 3;
                        b1p = 0;
                        
                        zombiesMoved++;
                    }
                }
            }
        }
        if (column == 1) {
            if (b2p == 3) {
                int zTemp = arc4random() % 4;
                
                if (zTemp == 0) {
                    if (a2p == 0) {
                        a2p = 3;
                        b2p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 1) {
                    if (b1p == 0) {
                        b1p = 3;
                        b2p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 2) {
                    if (b3p == 0) {
                        b3p = 3;
                        b2p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 3) {
                    if (c2p == 0) {
                        c2p = 3;
                        b2p = 0;
                        
                        zombiesMoved++;
                    }
                }
            }
        }
        if (column == 2) {
            if (b3p == 3) {
                int zTemp = arc4random() % 4;
                
                if (zTemp == 0) {
                    if (a3p == 0) {
                        a3p = 3;
                        b3p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 1) {
                    if (b2p == 0) {
                        b2p = 3;
                        b3p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 2) {
                    if (b4p == 0) {
                        b4p = 3;
                        b3p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 3) {
                    if (c3p == 0) {
                        c3p = 3;
                        b3p = 0;
                        
                        zombiesMoved++;
                    }
                }
            }
        }
        if (column == 3) {
            if (b4p == 3) {
                int zTemp = arc4random() % 3;
                
                if (zTemp == 0) {
                    if (a4p == 0) {
                        a4p = 3;
                        b4p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 1) {
                    if (b3p == 0) {
                        b3p = 3;
                        b4p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 2) {
                    if (c4p == 0) {
                        c4p = 3;
                        b4p = 0;
                        
                        zombiesMoved++;
                    }
                }
            }
        }
    }
    else if (row == 2) {
        if (column == 0) {
            if (c1p == 3) {
                int zTemp = arc4random() % 2;
                
                if (zTemp == 0) {
                    if (b1p == 0) {
                        b1p = 3;
                        c1p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 1) {
                    if (c2p == 0) {
                        c2p = 3;
                        c1p = 0;
                        
                        zombiesMoved++;
                    }
                }
            }
        }
        if (column == 1) {
            if (c2p == 3) {
                int zTemp = arc4random() % 3;
                
                if (zTemp == 0) {
                    if (b2p == 0) {
                        b2p = 3;
                        c2p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 1) {
                    if (c1p == 0) {
                        c1p = 3;
                        c2p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 2) {
                    if (c3p == 0) {
                        c3p = 3;
                        c2p = 0;
                        
                        zombiesMoved++;
                    }
                }
            }
        }
        if (column == 2) {
            if (c3p == 3) {
                int zTemp = arc4random() % 3;
                
                if (zTemp == 0) {
                    if (b3p == 0) {
                        b3p = 3;
                        c3p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 1) {
                    if (c2p == 0) {
                        c2p = 3;
                        c3p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 2) {
                    if (c4p == 0) {
                        c4p = 3;
                        c3p = 0;
                        
                        zombiesMoved++;
                    }
                }
            }
        }
        if (column == 3) {
            if (c4p == 3) {
                int zTemp = arc4random() % 2;
                
                if (zTemp == 0) {
                    if (b4p == 0) {
                        b4p = 3;
                        c4p = 0;
                        
                        zombiesMoved++;
                    }
                }
                else if (zTemp == 1) {
                    if (c3p == 0) {
                        c3p = 3;
                        c4p = 0;
                        
                        zombiesMoved++;
                    }
                }
            }
        }
    }
}

-(void)cancelGrid {
    //enable all buttons when canceling an action, so that you aren't locked into the selected piece anymore
    [self enableAllButtons];
    
    //mark all of the pieces as unselected
    a1if = false;
    a2if = false;
    a3if = false;
    a4if = false;
    b1if = false;
    b2if = false;
    b3if = false;
    b4if = false;
    c1if = false;
    c2if = false;
    c3if = false;
    c4if = false;
    
    //if any of the pieces were faded out, they will fade back in
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationSpeed];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    a1i.alpha = 1;
    a2i.alpha = 1;
    a3i.alpha = 1;
    a4i.alpha = 1;
    b1i.alpha = 1;
    b2i.alpha = 1;
    b3i.alpha = 1;
    b4i.alpha = 1;
    c1i.alpha = 1;
    c2i.alpha = 1;
    c3i.alpha = 1;
    c4i.alpha = 1;
    [UIView commitAnimations];
}

-(void)loadLevel {
    //honestly not sure why this line is here, might be important
    zombiesMoved = 0;
    
    if (score == 0) {
        //if a level is not being played, show the highest score
        [self showDisplayedScore];
    }
    else {
        //if the game is active, show the current score
        scoreLabel.text = [NSString stringWithFormat: @"Score: %i", score];
        skipButton.alpha = 1;
    }
    
    //important for game over: animates pieces in, but animates tweet button and dead screen out
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationSpeed];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    deadScreen.alpha = 0;
    //progressView.alpha = 1;
    tweetButton.alpha = 0;
    a1i.alpha = 1;
    a2i.alpha = 1;
    a3i.alpha = 1;
    a4i.alpha = 1;
    b1i.alpha = 1;
    b2i.alpha = 1;
    b3i.alpha = 1;
    b4i.alpha = 1;
    c1i.alpha = 1;
    c2i.alpha = 1;
    c3i.alpha = 1;
    c4i.alpha = 1;
    [self disableTheFaded];
    [UIView commitAnimations];
    
    if (selectedTheme == 1) {
        kingImage = [UIImage imageNamed:@"king-large.png"];
        pawnImage = [UIImage imageNamed:@"pawn-large.png"];
        zombieImage = [UIImage imageNamed:@"zombie-large.png"];
        knightImage = [UIImage imageNamed:@"knight-large.png"];
    }
    else if (selectedTheme == 2) {
        kingImage = [UIImage imageNamed:@"king-xl-large.png"];
        pawnImage = [UIImage imageNamed:@"pawn-xl-large.png"];
        zombieImage = [UIImage imageNamed:@"zombie-xl-large.png"];
        knightImage = [UIImage imageNamed:@"knight-xl-large.png"];
    }
    else if (selectedTheme == 3) {
        kingImage = [UIImage imageNamed:@"king-alpha-large.png"];
        pawnImage = [UIImage imageNamed:@"pawn-alpha-large.png"];
        zombieImage = [UIImage imageNamed:@"zombie-alpha-large.png"];
        knightImage = [UIImage imageNamed:@"knight-alpha-large.png"];
    }
    else if (selectedTheme == 4) {
        kingImage = [UIImage imageNamed:@"king-outline-large.png"];
        pawnImage = [UIImage imageNamed:@"pawn-outline-large.png"];
        zombieImage = [UIImage imageNamed:@"zombie-outline-large.png"];
        knightImage = [UIImage imageNamed:@"knight-outline-large.png"];
    }
    else if (selectedTheme == 5) {
        kingImage = [UIImage imageNamed:@"king-doge-large.png"];
        pawnImage = [UIImage imageNamed:@"pawn-doge-large.png"];
        zombieImage = [UIImage imageNamed:@"zombie-doge-large.png"];
        knightImage = [UIImage imageNamed:@"knight-doge-large.png"];
    }
    else {
        kingImage = [UIImage imageNamed:@"king-large.png"];
        pawnImage = [UIImage imageNamed:@"pawn-large.png"];
        zombieImage = [UIImage imageNamed:@"zombie-large.png"];
        knightImage = [UIImage imageNamed:@"knight-large.png"];
    }
    
    //checks for blanks, loads images accordingly
    if (a1p == 0) {
        [a1i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    }
    if (a2p == 0) {
        [a2i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    }
    if (a3p == 0) {
        [a3i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    }
    if (a4p == 0) {
        [a4i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    }
    if (b1p == 0) {
        [b1i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    }
    if (b2p == 0) {
        [b2i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    }
    if (b3p == 0) {
        [b3i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    }
    if (b4p == 0) {
        [b4i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    }
    if (c1p == 0) {
        [c1i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    }
    if (c2p == 0) {
        [c2i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    }
    if (c3p == 0) {
        [c3i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    }
    if (c4p == 0) {
        [c4i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    }
    
    //checks for kings, loads images accordingly
    if (a1p == 1) {
        [a1i setImage:[UIImage imageWithCGImage:kingImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (a2p == 1) {
        [a2i setImage:[UIImage imageWithCGImage:kingImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (a3p == 1) {
        [a3i setImage:[UIImage imageWithCGImage:kingImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (a4p == 1) {
        [a4i setImage:[UIImage imageWithCGImage:kingImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (b1p == 1) {
        [b1i setImage:[UIImage imageWithCGImage:kingImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (b2p == 1) {
        [b2i setImage:[UIImage imageWithCGImage:kingImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (b3p == 1) {
        [b3i setImage:[UIImage imageWithCGImage:kingImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (b4p == 1) {
        [b4i setImage:[UIImage imageWithCGImage:kingImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (c1p == 1) {
        [c1i setImage:[UIImage imageWithCGImage:kingImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (c2p == 1) {
        [c2i setImage:[UIImage imageWithCGImage:kingImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (c3p == 1) {
        [c3i setImage:[UIImage imageWithCGImage:kingImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (c4p == 1) {
        [c4i setImage:[UIImage imageWithCGImage:kingImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    
    //checks for pawns, loads images accordingly
    if (a1p == 2) {
        [a1i setImage:[UIImage imageWithCGImage:pawnImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (a2p == 2) {
        [a2i setImage:[UIImage imageWithCGImage:pawnImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (a3p == 2) {
        [a3i setImage:[UIImage imageWithCGImage:pawnImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (a4p == 2) {
        [a4i setImage:[UIImage imageWithCGImage:pawnImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (b1p == 2) {
        [b1i setImage:[UIImage imageWithCGImage:pawnImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (b2p == 2) {
        [b2i setImage:[UIImage imageWithCGImage:pawnImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (b3p == 2) {
        [b3i setImage:[UIImage imageWithCGImage:pawnImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (b4p == 2) {
        [b4i setImage:[UIImage imageWithCGImage:pawnImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (c1p == 2) {
        [c1i setImage:[UIImage imageWithCGImage:pawnImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (c2p == 2) {
        [c2i setImage:[UIImage imageWithCGImage:pawnImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (c3p == 2) {
        [c3i setImage:[UIImage imageWithCGImage:pawnImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (c4p == 2) {
        [c4i setImage:[UIImage imageWithCGImage:pawnImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    
    //checks for zombies, loads images accordingly
    if (a1p == 3) {
        [a1i setImage:[UIImage imageWithCGImage:zombieImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (a2p == 3) {
        [a2i setImage:[UIImage imageWithCGImage:zombieImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (a3p == 3) {
        [a3i setImage:[UIImage imageWithCGImage:zombieImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (a4p == 3) {
        [a4i setImage:[UIImage imageWithCGImage:zombieImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (b1p == 3) {
        [b1i setImage:[UIImage imageWithCGImage:zombieImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (b2p == 3) {
        [b2i setImage:[UIImage imageWithCGImage:zombieImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (b3p == 3) {
        [b3i setImage:[UIImage imageWithCGImage:zombieImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (b4p == 3) {
        [b4i setImage:[UIImage imageWithCGImage:zombieImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (c1p == 3) {
        [c1i setImage:[UIImage imageWithCGImage:zombieImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (c2p == 3) {
        [c2i setImage:[UIImage imageWithCGImage:zombieImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (c3p == 3) {
        [c3i setImage:[UIImage imageWithCGImage:zombieImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (c4p == 3) {
        [c4i setImage:[UIImage imageWithCGImage:zombieImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    
    //checks for knights, loads images accordingly
    if (a1p == 4) {
        [a1i setImage:[UIImage imageWithCGImage:knightImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (a2p == 4) {
        [a2i setImage:[UIImage imageWithCGImage:knightImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (a3p == 4) {
        [a3i setImage:[UIImage imageWithCGImage:knightImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (a4p == 4) {
        [a4i setImage:[UIImage imageWithCGImage:knightImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (b1p == 4) {
        [b1i setImage:[UIImage imageWithCGImage:knightImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (b2p == 4) {
        [b2i setImage:[UIImage imageWithCGImage:knightImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (b3p == 4) {
        [b3i setImage:[UIImage imageWithCGImage:knightImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (b4p == 4) {
        [b4i setImage:[UIImage imageWithCGImage:knightImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (c1p == 4) {
        [c1i setImage:[UIImage imageWithCGImage:knightImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (c2p == 4) {
        [c2i setImage:[UIImage imageWithCGImage:knightImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (c3p == 4) {
        [c3i setImage:[UIImage imageWithCGImage:knightImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    if (c4p == 4) {
        [c4i setImage:[UIImage imageWithCGImage:knightImage.CGImage scale:1.0 orientation: UIImageOrientationUp]];
    }
    
    //checks for necromancers, loads images accordingly
    if (a1p == 5) {
        [a1i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"necromancer-large.png"]]];
    }
    if (a2p == 5) {
        [a2i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"necromancer-large.png"]]];
    }
    if (a3p == 5) {
        [a3i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"necromancer-large.png"]]];
    }
    if (a4p == 5) {
        [a4i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"necromancer-large.png"]]];
    }
    if (b1p == 5) {
        [b1i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"necromancer-large.png"]]];
    }
    if (b2p == 5) {
        [b2i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"necromancer-large.png"]]];
    }
    if (b3p == 5) {
        [b3i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"necromancer-large.png"]]];
    }
    if (b4p == 5) {
        [b4i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"necromancer-large.png"]]];
    }
    if (c1p == 5) {
        [c1i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"necromancer-large.png"]]];
    }
    if (c2p == 5) {
        [c2i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"necromancer-large.png"]]];
    }
    if (c3p == 5) {
        [c3i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"necromancer-large.png"]]];
    }
    if (c4p == 5) {
        [c4i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"necromancer-large.png"]]];
    }
}

-(void)disableTheFaded {
    //important: enable all buttons first to ensure that ONLY faded pieces are disabled
    [self enableAllButtons];
    
    //this code will check for pieces that have their alpha reduced, then disable the associated buttons
    if (a1i.alpha != 1) {
        a1b.enabled = false;
    }
    if (a2i.alpha != 1) {
        a2b.enabled = false;
    }
    if (a3i.alpha != 1) {
        a3b.enabled = false;
    }
    if (a4i.alpha != 1) {
        a4b.enabled = false;
    }
    if (b1i.alpha != 1) {
        b1b.enabled = false;
    }
    if (b2i.alpha != 1) {
        b2b.enabled = false;
    }
    if (b3i.alpha != 1) {
        b3b.enabled = false;
    }
    if (b4i.alpha != 1) {
        b4b.enabled = false;
    }
    if (c1i.alpha != 1) {
        c1b.enabled = false;
    }
    if (c2i.alpha != 1) {
        c2b.enabled = false;
    }
    if (c3i.alpha != 1) {
        c3b.enabled = false;
    }
    if (c4i.alpha != 1) {
        c4b.enabled = false;
    }
}

-(void)disableAllButtons {
    //disables all grid buttons
    a1b.enabled = false;
    a2b.enabled = false;
    a3b.enabled = false;
    a4b.enabled = false;
    b1b.enabled = false;
    b2b.enabled = false;
    b3b.enabled = false;
    b4b.enabled = false;
    c1b.enabled = false;
    c2b.enabled = false;
    c3b.enabled = false;
    c4b.enabled = false;
}

-(void)enableAllButtons {
    //enables all grid buttons
    a1b.enabled = true;
    a2b.enabled = true;
    a3b.enabled = true;
    a4b.enabled = true;
    b1b.enabled = true;
    b2b.enabled = true;
    b3b.enabled = true;
    b4b.enabled = true;
    c1b.enabled = true;
    c2b.enabled = true;
    c3b.enabled = true;
    c4b.enabled = true;
}

-(void)clearLevel {
    //sets all piece values to blank
    a1p = 0;
    a2p = 0;
    a3p = 0;
    a4p = 0;
    b1p = 0;
    b2p = 0;
    b3p = 0;
    b4p = 0;
    c1p = 0;
    c2p = 0;
    c3p = 0;
    c4p = 0;
    
    //also sets every piece image to blank
    [a1i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    [a2i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    [a3i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    [a4i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    [b1i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    [b2i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    [b3i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    [b4i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    [c1i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    [c2i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    [c3i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
    [c4i setImage:[UIImage imageNamed:[NSString stringWithFormat:@"empty-large.png"]]];
}

-(void)generateLevel {
    //this code is called until it is no longer needed
    //pieces are generated randomly by choosing a random column and row on the grid
    int column = arc4random() % 4;
    int row = arc4random() % 3;
    
    if (row == 0) {
        if (column == 0) {
            if (a1p == 0) {
                if (pieces == kingGeneratePriority) {
                    a1p = 1;
                }
                else if (pieces == zombieGeneratePriority) {
                    a1p = 3;
                }
                else {
                    a1p = 2;
                }
                pieces--;
            }
        }
        if (column == 1) {
            if (a2p == 0) {
                if (pieces == kingGeneratePriority) {
                    a2p = 1;
                }
                else if (pieces == zombieGeneratePriority) {
                    a2p = 3;
                }
                else {
                    a2p = 2;
                }
                pieces--;
            }
        }
        if (column == 2) {
            if (a3p == 0) {
                if (pieces == kingGeneratePriority) {
                    a3p = 1;
                }
                else if (pieces == zombieGeneratePriority) {
                    a3p = 3;
                }
                else {
                    a3p = 2;
                }
                pieces--;
            }
        }
        if (column == 3) {
            if (a4p == 0) {
                if (pieces == kingGeneratePriority) {
                    a4p = 1;
                }
                else if (pieces == zombieGeneratePriority) {
                    a4p = 3;
                }
                else {
                    a4p = 2;
                }
                pieces--;
            }
        }
    }
    else if (row == 1) {
        if (column == 0) {
            if (b1p == 0) {
                if (pieces == kingGeneratePriority) {
                    b1p = 1;
                }
                else if (pieces == zombieGeneratePriority) {
                    b1p = 3;
                }
                else {
                    b1p = 2;
                }
                pieces--;
            }
        }
        if (column == 1) {
            if (b2p == 0) {
                if (pieces == kingGeneratePriority) {
                    b2p = 1;
                }
                else if (pieces == zombieGeneratePriority) {
                    b2p = 3;
                }
                else {
                    b2p = 2;
                }
                pieces--;
            }
        }
        if (column == 2) {
            if (b3p == 0) {
                if (pieces == kingGeneratePriority) {
                    b3p = 1;
                }
                else if (pieces == zombieGeneratePriority) {
                    b3p = 3;
                }
                else {
                    b3p = 2;
                }
                pieces--;
            }
        }
        if (column == 3) {
            if (b4p == 0) {
                if (pieces == kingGeneratePriority) {
                    b4p = 1;
                }
                else if (pieces == zombieGeneratePriority) {
                    b4p = 3;
                }
                else {
                    b4p = 2;
                }
                pieces--;
            }
        }
    }
    else if (row == 2) {
        if (column == 0) {
            if (c1p == 0) {
                if (pieces == kingGeneratePriority) {
                    c1p = 1;
                }
                else if (pieces == zombieGeneratePriority) {
                    c1p = 3;
                }
                else {
                    c1p = 2;
                }
                pieces--;
            }
        }
        if (column == 1) {
            if (c2p == 0) {
                if (pieces == kingGeneratePriority) {
                    c2p = 1;
                }
                else if (pieces == zombieGeneratePriority) {
                    c2p = 3;
                }
                else {
                    c2p = 2;
                }
                pieces--;
            }
        }
        if (column == 2) {
            if (c3p == 0) {
                if (pieces == kingGeneratePriority) {
                    c3p = 1;
                }
                else if (pieces == zombieGeneratePriority) {
                    c3p = 3;
                }
                else {
                    c3p = 2;
                }
                pieces--;
            }
        }
        if (column == 3) {
            if (c4p == 0) {
                if (pieces == kingGeneratePriority) {
                    c4p = 1;
                }
                else if (pieces == zombieGeneratePriority) {
                    c4p = 3;
                }
                else {
                    c4p = 2;
                }
                pieces--;
            }
        }
    }
    
    [self loadLevel];
}

-(void)debugPieces {
    //this is srictly dev code, used to print out each piece that is not blank on level generation
    if (a1p != 0) {
        NSLog(@"a1p: %i", a1p);
    }
    if (a2p != 0) {
        NSLog(@"a2p: %i", a2p);
    }
    if (a3p != 0) {
        NSLog(@"a3p: %i", a3p);
    }
    if (a4p != 0) {
        NSLog(@"a4p: %i", a4p);
    }
    if (b1p != 0) {
        NSLog(@"b1p: %i", b1p);
    }
    if (b2p != 0) {
        NSLog(@"b2p: %i", b2p);
    }
    if (b3p != 0) {
        NSLog(@"b3p: %i", b3p);
    }
    if (b4p != 0) {
        NSLog(@"b4p: %i", b4p);
    }
    if (c1p != 0) {
        NSLog(@"c1p: %i", c1p);
    }
    if (c2p != 0) {
        NSLog(@"c2p: %i", c2p);
    }
    if (c3p != 0) {
        NSLog(@"c3p: %i", c3p);
    }
    if (c4p != 0) {
        NSLog(@"c4p: %i", c4p);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    animationSpeed = 0.25;
    animationIntensity = 0.1;
    kingGeneratePriority = 6;
    zombieGeneratePriority = 5;
    gamemode = 1;
    timerCount = 1;
    displayedScore = 0;
    defaultLevel = false;
    creatingKnight = false;
    zombiesDefeated = false;
    necromancerSpawned = false;
    
    newDate = [[NSUserDefaults standardUserDefaults]
               stringForKey:@"savedNewDate"];
    currentDate = [[NSUserDefaults standardUserDefaults]
                   stringForKey:@"savedCurrentDate"];
    selectedTheme = [[NSUserDefaults standardUserDefaults] floatForKey:@"savedTheme"];
    
    //loads your highest score and displays it in the label
    topScore = [[NSUserDefaults standardUserDefaults] floatForKey:@"savedScore"];
    dailyScore = [[NSUserDefaults standardUserDefaults] floatForKey:@"savedDaily"];
    
    [self showDisplayedScore];
    
    [self getDate];
    
    //loads your total wins to display in the label
    wins = [[NSUserDefaults standardUserDefaults] floatForKey:@"savedWins"];
    
    //without these lines of code, Kings & Corpses cannot use the Asap font for labels
    [scoreLabel setFont: [UIFont fontWithName: @"Asap-Italic" size: scoreLabel.font.pointSize]];
    [helpLabel setFont: [UIFont fontWithName: @"Asap-Italic" size: helpLabel.font.pointSize]];
    
    //sets alpha to 0 for buttons that are hidden on start
    deadScreen.alpha = 0;
    tweetButton.alpha = 0;
    skipButton.alpha = 0;
    helpLabel.alpha = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
