//
//  ViewController.m
//  PsychologicalExpert
//
//  Created by 翟永胜 on 2018/4/9.
//  Copyright © 2018年 翟永胜. All rights reserved.
//

#import "PsyViewController.h"
#import "HappinessViewController.h"

@interface PsyViewController ()
@property (nonatomic) int diagmosis;
@end

@implementation PsyViewController

@synthesize diagmosis = _diagmosis;

- (void) setAndShowDiagrosis:(int) diagrosis {
    self.diagmosis = diagrosis;
    // segue
    [self performSegueWithIdentifier:@"ShowDiagnosis" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowDiagnosis"]){
        [segue.destinationViewController setHappiness:self.diagmosis];
    }
}

- (IBAction) flying {
    [self setAndShowDiagrosis:85];
}

- (IBAction) steel {
    [self setAndShowDiagrosis:100];
}

- (IBAction) chased {
    [self setAndShowDiagrosis:20];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
