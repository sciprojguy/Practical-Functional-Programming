//
//  FirstClassFunctionTests.m
//  FunctionalProgramming
//
//  Created by Chris Woodard on 1/18/15.
//  Copyright (c) 2015 TBCocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ArrayFunctions.h"

typedef BOOL(^NumericPredicate)(NSNumber *number);
typedef BOOL(^StringPredicate)(NSString *string);
typedef NSString *(^BleeperBlock)(NSString *string);

@interface FirstClassFunctionTests : XCTestCase

@end

@implementation FirstClassFunctionTests

-(void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

-(void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/***
    "first class function" means you can declare a variable to point to
    an executable block of code, point the variable *at* such a block of
    code and then call it just as if it were a regular function.
 ***/

-(void)testCallingFirstClassFunctions1 {

    // write a mapping block to bleep out the French words voila! and
    // merde! - all others are passed back as-is.
    
    BleeperBlock bleepFrenchWords = ^(NSString *word) {
    
        NSString *bleepedWord = [word copy];
        if([@"voila!" isEqualToString:word]) {
            bleepedWord = [@"****" copy];
        }
        else
        if([@"merde!" isEqualToString:word]) {
            bleepedWord = [@"****" copy];
        }
        return bleepedWord;
    };
    
    NSString *bleepedWord = bleepFrenchWords(@"good");
    XCTAssertTrue([@"good" isEqualToString:bleepedWord]);
    
    NSString *bleepedWord2 = bleepFrenchWords(@"merde!");
    XCTAssertTrue([@"****" isEqualToString:bleepedWord2]);
}

-(void)testCallingFirstClassFunctions2 {

    NumericPredicate isPositive = ^(NSNumber *number) {
        if([number doubleValue] > 0.0)
            return YES;
        else
            return NO;
    };
    
    NumericPredicate isNegative = ^(NSNumber *number) {
        if([number doubleValue] > 0.0)
            return NO;
        else
            return YES;
    };

    // note that we can call these just like functions we declared in a
    // .m file
    
    XCTAssertTrue( isPositive(@(5.0)), @"should have said that 5.0 is positive");
    XCTAssertFalse( isPositive(@(-5.0)), @"should not have said that -5.0 is positive");
    
    XCTAssertTrue( isNegative(@(-5.0)), @"should have said that -5.0 is negative");
    XCTAssertFalse( isNegative(@(5.0)), @"should not have said that 5.0 is negative");
}

-(void)testFilterUsingTwoDifferentNumericPredicates {

    // the useful part is that we can use FCF's as predicates in
    // a filter operation
    
    NSArray *inArrayOfNumbers = @[ @(10.1), @(5.0), @(0.0), @(-1.1), @(-12.1)];
    
    NumericPredicate isPositive = ^(NSNumber *number) {
        if([number doubleValue] > 0.0)
            return YES;
        else
            return NO;
    };
    
    NumericPredicate isNegative = ^(NSNumber *number) {
        if([number doubleValue] < 0.0)
            return YES;
        else
            return NO;
    };
    
    NSArray *filtered1 = filterArray(inArrayOfNumbers, isPositive);
    XCTAssertTrue(2 == [filtered1 count], @"should be two elements");
    
    NSArray *filtered2 = filterArray(inArrayOfNumbers, isNegative);
    XCTAssertTrue(2 == [filtered2 count], @"should be two elements");
}

-(void)testMapUsingTwoDifferentBlocks {

    BleeperBlock bleepFrenchWords = ^(NSString *word) {
        NSString *bleepedWord = [word copy];
        if([@"voila!" isEqualToString:word]) {
            bleepedWord = [@"****" copy];
        }
        else
        if([@"merde!" isEqualToString:word]) {
            bleepedWord = [@"****" copy];
        }
        return bleepedWord;
    };

    BleeperBlock bleepGermanWords = ^(NSString *word) {
        NSString *bleepedWord = [word copy];
        if([@"nein" isEqualToString:word]) {
            bleepedWord = [@"****" copy];
        }
        else
        if([@"schnitzel" isEqualToString:word]) {
            bleepedWord = [@"****" copy];
        }
        return bleepedWord;
    };

    NSArray *inArrayOfString = @[
        @"cheeseburger", @"freedom fries", @"voila", @"merde!",
        @"nein", @"schnitzel", @"beer", @"vodka"
    ];
    
    NSArray *bleepedGermanWords = mapArray(inArrayOfString, bleepGermanWords);
    NSLog(@"german words bleeped: %@", bleepedGermanWords);
    
    NSArray *bleepedFrenchWords = mapArray(inArrayOfString, bleepFrenchWords);
    NSLog(@"french words bleeped: %@", bleepedFrenchWords);
    
    NSArray *bleepedFrenchAndGermanWords = mapArray( mapArray(inArrayOfString, bleepGermanWords), bleepFrenchWords );
    NSLog(@"french and german words bleeped: %@", bleepedFrenchAndGermanWords);
}

-(void)testMapUsingTwoDifferentBlocksUsingMethods {

    BleeperBlock bleepFrenchWords = ^(NSString *word) {
        NSString *bleepedWord = [word copy];
        if([@"voila!" isEqualToString:word]) {
            bleepedWord = [@"****" copy];
        }
        else
        if([@"merde!" isEqualToString:word]) {
            bleepedWord = [@"****" copy];
        }
        return bleepedWord;
    };

    BleeperBlock bleepGermanWords = ^(NSString *word) {
        NSString *bleepedWord = [word copy];
        if([@"nein" isEqualToString:word]) {
            bleepedWord = [@"****" copy];
        }
        else
        if([@"schnitzel" isEqualToString:word]) {
            bleepedWord = [@"****" copy];
        }
        return bleepedWord;
    };

    NSArray *inArrayOfString = @[
        @"cheeseburger", @"freedom fries", @"voila", @"merde!",
        @"nein", @"schnitzel", @"beer", @"vodka"
    ];
    
    NSArray *bleepedGermanWords = mapArray( inArrayOfString,  bleepGermanWords );
    
    NSLog(@"german words bleeped: %@", bleepedGermanWords);
    
    NSArray *bleepedFrenchWords = mapArray(inArrayOfString, bleepFrenchWords);
    NSLog(@"french words bleeped: %@", bleepedFrenchWords);
    
    NSArray *bleepedFrenchAndGermanWords = mapArray( mapArray(inArrayOfString, bleepGermanWords), bleepFrenchWords );
    NSLog(@"french and german words bleeped: %@", bleepedFrenchAndGermanWords);
}

@end
