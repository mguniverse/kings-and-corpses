//
//  Tutorial_iPhone.m
//  Kings & Corpses
//
//  Created by Danny Perski on 1/2/15.
//  Copyright (c) 2015 Danny Perski. All rights reserved.
//

#import "Tutorial_iPhone.h"

@interface Tutorial_iPhone ()

@end

@implementation Tutorial_iPhone

-(IBAction)tutorial {
    [self buttonSound];
    tutorialPage++;
    
    if (tutorialPage == 1) {
        tutorialScreen.hidden = true;
        tutorialLabel.text = [NSString stringWithFormat:@"Introduction"];
        tutorialText.text = [NSString stringWithFormat:@"The goal of Kings & Corpses is to defend your king for as long as possible. Do this by swapping pieces around and not letting your pawns turn into zombies."];
    }
    else if (tutorialPage == 2) {
        tutorialScreen.hidden = false;
        [tutorialScreen setImage:[UIImage imageNamed:[NSString stringWithFormat:@"king.png"]]];
        tutorialLabel.text = [NSString stringWithFormat:@""];
        tutorialText.text = [NSString stringWithFormat:@"Your king is the most important piece on the grid. If your king goes down, the game is over. Keep your king alive even if it means sacrificing some pawns."];
    }
    else if (tutorialPage == 3) {
        tutorialLabel.text = [NSString stringWithFormat:@""];
        [tutorialScreen setImage:[UIImage imageNamed:[NSString stringWithFormat:@"zombie.png"]]];
        tutorialText.text = [NSString stringWithFormat:@"Zombies are dangerous.\nIf they are touching another piece, they will turn that piece into a zombie. One zombie can become five if you're not too careful."];
    }
    else if (tutorialPage == 4) {
        tutorialLabel.text = [NSString stringWithFormat:@""];
        [tutorialScreen setImage:[UIImage imageNamed:[NSString stringWithFormat:@"pawn.png"]]];
        tutorialText.text = [NSString stringWithFormat:@"The pawns serve the king and can become knights. Each pawn that turns into a zombie makes the grid more unsafe for the king, so keep them alive for as long as possible."];
    }
    else if (tutorialPage == 5) {
        tutorialLabel.text = [NSString stringWithFormat:@""];
        [tutorialScreen setImage:[UIImage imageNamed:[NSString stringWithFormat:@"knight.png"]]];
        tutorialText.text = [NSString stringWithFormat:@"If any pawns are alive after ten turns, you will have the option to turn one into a knight. You can cure zombies by pushing a knight on them."];
    }
    else if (tutorialPage == 6) {
        tutorialScreen.hidden = true;
        tutorialLabel.text = [NSString stringWithFormat:@"Try it yourself!"];
        tutorialText.text = [NSString stringWithFormat:@"Pieces cannot move diagonally, and it's much easier to save the king if all your pawns are alive. Keep practicing, and it'll get easier."];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationSpeed];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        tutorialNextButton.alpha = 0;
        tutorialPlayButton.alpha = 1;
        
        [UIView commitAnimations];
    }
}

-(IBAction)done {
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
    tutorialPage = 1;
    animationSpeed = 0.25;
    animationIntensity = 0.1;
    
    //without these lines of code, Kings & Corpses cannot use the Asap font for labels
    [tutorialLabel setFont: [UIFont fontWithName: @"Asap-Italic" size: tutorialLabel.font.pointSize]];
    [tutorialText setFont: [UIFont fontWithName: @"Asap-Italic" size: tutorialText.font.pointSize]];
    
    tutorialPlayButton.alpha = 0;
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
