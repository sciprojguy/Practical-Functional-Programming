//
//  MapDemoTests.m
//  FunctionalProgramming
//
//  Created by Chris Woodard on 1/18/15.
//  Copyright (c) 2015 TBCocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ArrayFunctions.h"
#import "NSArray+Functional.h"

@interface MapDemoTests : XCTestCase

@end

@implementation MapDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testMapArrayFunction1 {
    NSArray *myInArray = @[ @"How", @"Now", @"Brown", @"Cow" ];
    NSArray *myOutArray = mapArray( myInArray, ^(NSString *element) {
        NSString *outElement = [element isEqualToString:@"Cow"]?[element uppercaseString]:element;
        return outElement;
    });
        
    NSLog(@"%@", myOutArray);
    XCTAssertTrue(4 == myOutArray.count, @"Should be 4 items in out array");
    XCTAssertTrue([@"COW" isEqualToString:myOutArray[3]], @"last element should be COW");
}

-(void)testMapArrayFunction2 {
    NSArray *myInArray = @[ @(12.5), @(15.6), @(0.0) ];
    NSArray *myOutArray = mapArray( myInArray, ^(NSNumber *element) {
        NSNumber *outNumber = nil;
        if([element doubleValue] < 10.0)
            outNumber = @(10.0);
        else
            outNumber = [element copy];
        return outNumber;
    });
    NSLog(@"input: %@", myInArray);
    NSLog(@"output: %@", myOutArray);
    XCTAssertTrue(3 == myOutArray.count, @"Should be 3 items in out array");
    XCTAssertTrue([@10.0 isEqualToNumber:myOutArray[2]], @"last element should be 10.0");
}

-(void)testMapArrayFunction3 {
    NSArray *myInArray = @[
        @{@"Status":@"Active", @"Name":@"Joey K"},
        @{@"Status":@"Active", @"Name":@"Billy W"},
        @{@"Status":@"Inactive", @"Name":@"Wanda L"},
        @{@"Status":@"Inactive", @"Name":@"Jimmy M"},
        @{@"Status":@"Active", @"Name":@"Mia W"},
        @{@"Status":@"Active", @"Name":@"Ella F"},
    ];

    NSArray *myOutArray = mapArray( myInArray, ^(NSDictionary *element) {
        NSString *outName = nil;
        if([@"Inactive" isEqualToString:element[@"Status"]]) {
            outName = [element[@"Name"] uppercaseString];
        }
        else {
            outName = [element[@"Name"] copy];
        }
        return outName;
    });
    NSLog(@"out Array: %@", myOutArray);
}

-(void)testMapArrayFunction4 {

    NSArray *myInArray = @[
        @{@"Status":@"Active", @"Name":@"Joey K"},
        @{@"Status":@"Active", @"Name":@"Billy W"},
        @{@"Status":@"Inactive", @"Name":@"Wanda L"},
        @{@"Status":@"Inactive", @"Name":@"Jimmy M"},
        @{@"Status":@"Active", @"Name":@"Mia W"},
        @{@"Status":@"Active", @"Name":@"Ella F"},
    ];
    
    NSArray *myOutArray = mapArray( myInArray, ^(NSDictionary *element) {
        NSString *outName = nil;
        if([@"Inactive" isEqualToString:element[@"Status"]]) {
            outName = [element[@"Name"] uppercaseString];
        }
        else {
            outName = [element[@"Name"] copy];
        }
        return outName;
    });
    
    NSLog(@"out Array: %@", myOutArray);
}

//***** OBJECT ORIENTED *****

-(void)testMapArrayMethod1 {
    NSArray *myInArray = @[ @"How", @"Now", @"Brown", @"Cow" ];
    NSArray *myOutArray = [myInArray map:^(NSString *element) {
        NSString *outElement = [element isEqualToString:@"Cow"]?[element uppercaseString]:element;
        return outElement;
    }];
    NSLog(@"%@", myOutArray);
    XCTAssertTrue(4 == myOutArray.count, @"Should be 4 items in out array");
    XCTAssertTrue([@"COW" isEqualToString:myOutArray[3]], @"last element should be COW");
}

-(void)testMapArrayMethod2 {
    NSArray *myInArray = @[ @(12.5), @(15.6), @(0.0) ];
    NSArray *myOutArray = [myInArray map:^(NSNumber *element) {
        NSNumber *outNumber = nil;
        if([element doubleValue] < 10.0)
            outNumber = @(10.0);
        else
            outNumber = [element copy];
        return outNumber;
    }];
    
    NSLog(@"input: %@", myInArray);
    NSLog(@"output: %@", myOutArray);
    XCTAssertTrue(3 == myOutArray.count, @"Should be 3 items in out array");
    XCTAssertTrue([@10.0 isEqualToNumber:myOutArray[2]], @"last element should be 10.0");
}

-(void)testMapArrayMethod3 {
    NSArray *myInArray = @[
        @{@"Status":@"Active", @"Name":@"Joey K"},
        @{@"Status":@"Active", @"Name":@"Billy W"},
        @{@"Status":@"Inactive", @"Name":@"Wanda L"},
        @{@"Status":@"Inactive", @"Name":@"Jimmy M"},
        @{@"Status":@"Active", @"Name":@"Mia W"},
        @{@"Status":@"Active", @"Name":@"Ella F"},
    ];

    NSArray *myOutArray = [myInArray map:^(NSDictionary *element) {
        NSString *outName = nil;
        if([@"Inactive" isEqualToString:element[@"Status"]]) {
            outName = [element[@"Name"] uppercaseString];
        }
        else {
            outName = [element[@"Name"] copy];
        }
        return outName;
    }];
    NSLog(@"out Array: %@", myOutArray);
}

-(void)testMapArrayMethod4 {

    NSArray *myInArray = @[
        @{@"Status":@"Active", @"Name":@"Joey K"},
        @{@"Status":@"Active", @"Name":@"Billy W"},
        @{@"Status":@"Inactive", @"Name":@"Wanda L"},
        @{@"Status":@"Inactive", @"Name":@"Jimmy M"},
        @{@"Status":@"Active", @"Name":@"Mia W"},
        @{@"Status":@"Active", @"Name":@"Ella F"},
    ];
    
    NSArray *myOutArray = [myInArray map:^(NSDictionary *element) {
            NSString *outName = nil;
            if([@"Inactive" isEqualToString:element[@"Status"]]) {
                outName = [element[@"Name"] uppercaseString];
            }
            else {
                outName = [element[@"Name"] copy];
            }
            return outName;
        }];
    
    NSLog(@"out Array: %@", myOutArray);
}
@end
