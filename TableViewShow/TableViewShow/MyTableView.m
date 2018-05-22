//
//  MyTableView.m
//  TableViewShow
//
//  Created by 翟永胜 on 2018/4/11.
//  Copyright © 2018年 翟永胜. All rights reserved.
//

#import "MyTableView.h"

@interface MyTableView()

@end

@implementation MyTableView
@synthesize  programs = _programs;

#define FAVOURTIES_KEY @"MyFavourties"
- (IBAction)AddToFavorities:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favourtis = [[defaults objectForKey:FAVOURTIES_KEY] mutableCopy];
    if (!favourtis) favourtis = [NSMutableArray array];
    
    [favourtis addObject:@""];
    [defaults setObject:favourtis forKey:FAVOURTIES_KEY];
    [defaults synchronize];
}

#pragma mark -UITableViewDataSource
- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.programs count];
}

- (UITableViewCell*) tableView:(UITableView*) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"My Table View Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    // configure the cell....
    id program = [self.programs objectAtIndex:indexPath.row];
    cell.textLabel.text = @"标签内容";
    return cell;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
