//
//  CalculatorBrain.h
//  TableViewShow
//
//  Created by 翟永胜 on 2018/4/11.
//  Copyright © 2018年 翟永胜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void) pushOperand:(id) operand;
- (double) performOperation:(NSString*) operation;

- (void) clear;
- (void) undo;

// program is always guaranteed to be a Property List
@property (readonly) id program;

+ (NSString*) descriptionOfProgram:(id)program;
+ (double) runProgram:(id) program;
+ (double) runPorgram:(id) program suingVariableValues:(NSDictionary*) variableValues;

+ (NSSet*) variablesUsedInProgram:(id) program;

@end
