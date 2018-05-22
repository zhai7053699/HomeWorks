//
//  ViewController.m
//  TableViewShow
//
//  Created by 翟永胜 on 2018/4/11.
//  Copyright © 2018年 翟永胜. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)flying {
    [self antherView];
}

- (void) antherView {
    [self performSegueWithIdentifier:@"showthe" sender:self];
    
}

// 系统api，
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showthe"]){
        NSLog(@"调用成功了");
    }
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


@end
