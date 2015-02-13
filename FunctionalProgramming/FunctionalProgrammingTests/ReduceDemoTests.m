//
//  ReduceDemoTests.m
//  FunctionalProgramming
//
//  Created by Chris Woodard on 1/18/15.
//  Copyright (c) 2015 TBCocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ArrayFunctions.h"
#import "NSArray+Functional.h"

@interface ReduceDemoTests : XCTestCase

@end

@implementation ReduceDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testReduceArrayFunctionCommaSeparatedStrings {
    NSArray *myInArray = @[ @"One", @"Two", @"Three", @"Four" ];
    NSString *concatenatedString = reduceArray2(myInArray, @"", ^(NSString *accumStr, NSString *elStr, BOOL firstElement, BOOL lastElement) {
        NSString *str = nil;
        if(YES == firstElement) {
            str = elStr;
        }
        else {
            str = [NSString stringWithFormat:@"%@, %@", accumStr, elStr];
        }
        return str;
    });
    NSLog(@"%@", concatenatedString);
}

-(void)testReduceArrayFunctionCommaSeparatedStringsWithAnd {
    NSArray *myInArray = @[ @"One", @"Two", @"Three", @"Four" ];
    NSString *concatenatedString = reduceArray2(myInArray, @"", ^(NSString *accumStr, NSString *elStr, BOOL firstElement, BOOL lastElement) {
        NSString *str = nil;
        if(YES == firstElement) {
            str = elStr;
        }
        else
        if(YES == lastElement) {
            str = [NSString stringWithFormat:@"%@ and %@", accumStr, elStr];
        }
        else
        if(NO == lastElement) {
            str = [NSString stringWithFormat:@"%@, %@", accumStr, elStr];
        }
        return str;
    });
    NSLog(@"%@", concatenatedString);
}

-(void)testReduceArrayFunctionSum {
    NSArray *myInArray = @[ @(12.5), @(15.6), @(50.0) ];
    NSNumber *sum = reduceArray(myInArray, @(0), ^(NSNumber *accum, NSNumber *element) {
        NSNumber *number;
        number = @( [element doubleValue] + [accum doubleValue] );
        return number;
    });
    NSLog(@"sum is: %.4f", [sum doubleValue]);
}

-(void)testReduceArrayFunctionAvg {
    NSArray *myInArray = @[ @(12.5), @(15.6), @(50.0) ];
    NSDictionary *tuple = reduceArray2(myInArray, @(0), ^(NSDictionary *accum, NSNumber *element, BOOL firstNum, BOOL lastNum) {
        NSDictionary *tuple;
        if(firstNum) {
            tuple = @{@"N":@(1), @"Sum":element};
        }
        else
        {
            tuple = @{@"N":@([accum[@"N"] intValue]+1), @"Sum":@([accum[@"Sum"] doubleValue] + [element doubleValue])};
            if(lastNum) {
                tuple = @{@"N":tuple[@"N"], @"Avg":@([tuple[@"Sum"] doubleValue]/[tuple[@"N"] integerValue])};
            }
        }
        return tuple;
    });
    NSLog(@"Average of %@ number(s) is: %@", tuple[@"N"], tuple[@"Avg"]);
}

-(void)testReduceArrayFunctionCommaSeparatedStringsMethod {
    NSArray *myInArray = @[ @"One", @"Two", @"Three", @"Four" ];
    NSString *concatenatedString = [myInArray reduce2:@""  reductor:^(NSString *accumStr, NSString *elStr, BOOL firstElement, BOOL lastElement) {
        NSString *str = nil;
        if(YES == firstElement) {
            str = elStr;
        }
        else {
            str = [NSString stringWithFormat:@"%@, %@", accumStr, elStr];
        }
        return str;
    }];
    NSLog(@"%@", concatenatedString);
}

-(void)testReduceArrayFunctionCommaSeparatedStringsWithAndMethod {
    NSArray *myInArray = @[ @"One", @"Two", @"Three", @"Four" ];
    NSString *concatenatedString = [myInArray reduce2:@"" reductor:^(NSString *accumStr, NSString *elStr, BOOL firstElement, BOOL lastElement) {
        NSString *str = nil;
        if(YES == firstElement) {
            str = elStr;
        }
        else
        if(YES == lastElement) {
            str = [NSString stringWithFormat:@"%@ and %@", accumStr, elStr];
        }
        else
        if(NO == lastElement) {
            str = [NSString stringWithFormat:@"%@, %@", accumStr, elStr];
        }
        return str;
    }];
    NSLog(@"%@", concatenatedString);
}

-(void)testReduceArrayFunctionSumMethod {
    NSArray *myInArray = @[ @(12.5), @(15.6), @(50.0) ];
    NSNumber *sum = [myInArray reduce:@(0) reductor:^(NSNumber *accum, NSNumber *element) {
        NSNumber *number;
        number = @( [element doubleValue] + [accum doubleValue] );
        return number;
    }];
    NSLog(@"sum is: %.4f", [sum doubleValue]);
}

-(void)testReduceArrayFunctionAvgMethod {
    NSArray *myInArray = @[ @(12.5), @(15.6), @(50.0) ];
    NSDictionary *tuple = [myInArray reduce2:@(0) reductor:^(NSDictionary *accum, NSNumber *element, BOOL firstNum, BOOL lastNum) {
        NSDictionary *tuple;
        if(firstNum) {
            tuple = @{@"N":@(1), @"Sum":element};
        }
        else
        {
            tuple = @{@"N":@([accum[@"N"] intValue]+1), @"Sum":@([accum[@"Sum"] doubleValue] + [element doubleValue])};
            if(lastNum) {
                tuple = @{@"N":tuple[@"N"], @"Avg":@([tuple[@"Sum"] doubleValue]/[tuple[@"N"] integerValue])};
            }
        }
        return tuple;
    }];
    NSLog(@"Average of %@ number(s) is: %@", tuple[@"N"], tuple[@"Avg"]);
}

@end
