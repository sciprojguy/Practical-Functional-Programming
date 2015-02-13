//
//  FilterDemoTests.m
//  FunctionalProgramming
//
//  Created by Chris Woodard on 1/18/15.
//  Copyright (c) 2015 TBCocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ArrayFunctions.h"
#import "NSArray+Functional.h"

@interface FilterDemoTests : XCTestCase

@end

@implementation FilterDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testFilterArrayFunction1 {
    NSArray *myInArray = @[ @"How", @"Now", @"Brown", @"Cow" ];
    NSArray *myOutArray = filterArray( myInArray, ^(NSString *element) {
        if( [@"H" isEqualToString:[element substringToIndex:1]])
            return YES;
        else
            return NO;
    });
    NSLog(@"input: %@", myInArray);
    NSLog(@"output: %@", myOutArray);
    XCTAssertTrue(1 == myOutArray.count, @"Should be 1 item in out array");
    XCTAssertTrue([@"How" isEqualToString:myOutArray[0]], @"last element should be How");
}

-(void)testFilterArrayFunction2 {
    NSArray *myInArray = @[ @(12.5), @(15.6), @(0.0) ];
    NSArray *myOutArray = filterArray( myInArray, ^(NSString *element) {
        if( [element doubleValue] > 5.0 )
            return YES;
        else
            return NO;
    });
    XCTAssertTrue(2 == myOutArray.count, @"Should be 2 items in out array");
    XCTAssertTrue([@12.5 isEqualToNumber:myOutArray[0]], @"1st element should be 12.5");
    XCTAssertTrue([@15.6 isEqualToNumber:myOutArray[1]], @"2nd element should be 15.6");
}

-(void)testFilterArrayWithGeneratedFunctions {

    typedef BOOL(^StatusPredicate)(NSDictionary *);
    
    NSArray *myInArray = @[
        @{@"Status":@"Active", @"Name":@"Joey K"},
        @{@"Status":@"Active", @"Name":@"Billy W"},
        @{@"Status":@"Inactive", @"Name":@"Wanda L"},
        @{@"Status":@"Inactive", @"Name":@"Jimmy M"},
        @{@"Status":@"Active", @"Name":@"Mia W"},
        @{@"Status":@"Active", @"Name":@"Ella F"},
    ];
    
    StatusPredicate activeUserPedicate = ^(NSDictionary *element) {
        return [@"active" isEqualToString:[element[@"Status"] lowercaseString]];
    };
    
    StatusPredicate inactiveUserPredicate = ^(NSDictionary *element) {
        return [@"inactive" isEqualToString:[element[@"Status"] lowercaseString]];
    };

    NSArray *myOutArray1 = filterArray( myInArray, activeUserPedicate);
    NSLog(@"out Array: %@", myOutArray1);
    
    NSArray *myOutArray2 = filterArray( myInArray, inactiveUserPredicate);
    NSLog(@"out Array: %@", myOutArray2);
}

-(void)testFilterArrayMethod1 {
    NSArray *myInArray = @[ @"How", @"Now", @"Brown", @"Cow" ];
    NSArray *myOutArray = [myInArray filter:^(NSString *element) {
        if( [@"H" isEqualToString:[element substringToIndex:1]])
            return YES;
        else
            return NO;
    }];
    NSLog(@"input: %@", myInArray);
    NSLog(@"output: %@", myOutArray);
    XCTAssertTrue(1 == myOutArray.count, @"Should be 1 item in out array");
    XCTAssertTrue([@"How" isEqualToString:myOutArray[0]], @"last element should be How");
}

-(void)testFilterArrayMethod2 {
    NSArray *myInArray = @[ @(12.5), @(15.6), @(0.0) ];
    NSArray *myOutArray = [myInArray filter:^(NSString *element) {
        if( [element doubleValue] > 5.0 )
            return YES;
        else
            return NO;
    }];
    XCTAssertTrue(2 == myOutArray.count, @"Should be 2 items in out array");
    XCTAssertTrue([@12.5 isEqualToNumber:myOutArray[0]], @"1st element should be 12.5");
    XCTAssertTrue([@15.6 isEqualToNumber:myOutArray[1]], @"2nd element should be 15.6");
}

-(void)testFilterMethodWithGeneratedFunctions {

    typedef BOOL(^StatusPredicate)(NSDictionary *);
    
    NSArray *myInArray = @[
        @{@"Status":@"Active", @"Name":@"Joey K"},
        @{@"Status":@"Active", @"Name":@"Billy W"},
        @{@"Status":@"Inactive", @"Name":@"Wanda L"},
        @{@"Status":@"Inactive", @"Name":@"Jimmy M"},
        @{@"Status":@"Active", @"Name":@"Mia W"},
        @{@"Status":@"Active", @"Name":@"Ella F"},
    ];
    
    StatusPredicate activeUserPedicate = ^(NSDictionary *element) {
        return [@"active" isEqualToString:[element[@"Status"] lowercaseString]];
    };
    
    StatusPredicate inactiveUserPredicate = ^(NSDictionary *element) {
        return [@"inactive" isEqualToString:[element[@"Status"] lowercaseString]];
    };

    NSArray *myOutArray1 = [myInArray filter:activeUserPedicate];
    NSLog(@"out Array: %@", myOutArray1);
    
    NSArray *myOutArray2 = [myInArray filter:inactiveUserPredicate];
    NSLog(@"out Array: %@", myOutArray2);
}

@end
