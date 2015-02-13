//
//  CurriedFunctionTests.m
//  FunctionalProgramming
//
//  Created by Chris Woodard on 1/18/15.
//  Copyright (c) 2015 TBCocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

/***

"Function Currying" is a way to split up a function into two
partial functions.  Swift supports it as a first-order syntax,
while Objective C makes you simulate it by generating functions.
There are ways to get close to the real compiler-supported one

(http://blog.lukhnos.org/post/17270947434/currying-objective-c-methods)

but IMO the pain is not worth the gain.  Mostly the same effects
can be had with much clearer code by parameterizing the generation
of a block.

The following example generates one of three word test blocks - one
to test if the provided word is "coffee", one if it is "cafe" and
one if it is "raktajino" (Klingon coffee according to Start Trek
Deep Space Nine).  Which specific word gets tested depends on which
block is generated, which depends on the generator function's 
parameters when it gets called.
 ***/

typedef BOOL(^WordTest)(NSString *);

WordTest testForCoffee( NSString *language ) {
    WordTest wordTestBlock = nil;
    if([@"English" isEqualToString:language]){
        wordTestBlock = ^(NSString *word) {
            return [@"coffee" isEqualToString:word];
        };
    }
    else
    if([@"Spanish" isEqualToString:language]) {
        wordTestBlock = ^(NSString *word) {
            return [@"cafe" isEqualToString:word];
        };
    }
    else
    if([@"Klingon" isEqualToString:language]) {
        wordTestBlock = ^(NSString *word) {
            return [@"raktajino" isEqualToString:word];
        };
    }
    return wordTestBlock;
}

@interface FauxCurriedFunctionTests : XCTestCase

@end

@implementation FauxCurriedFunctionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testFauxCurriedFunction1 {
    WordTest klingonCoffee = testForCoffee(@"Klingon");
    XCTAssertFalse(klingonCoffee(@"coffee"), @"should be false");
    XCTAssertFalse(klingonCoffee(@"cafe"), @"should be false");
    XCTAssertTrue(klingonCoffee(@"raktajino"), @"should be true");
}

-(void)testFauxCurriedFunction2 {
    WordTest spanishCoffee = testForCoffee(@"Spanish");
    XCTAssertFalse( spanishCoffee(@"coffee"), @"should be false");
    XCTAssertTrue( spanishCoffee(@"cafe"), @"should be false");
    XCTAssertFalse( spanishCoffee(@"raktajino"), @"should be false");
}

-(void)testFauxCurriedFunction3 {
    WordTest englishCoffee = testForCoffee(@"English");
    XCTAssertTrue(englishCoffee(@"coffee"), @"should be false");
    XCTAssertFalse(englishCoffee(@"cafe"), @"should be false");
    XCTAssertFalse(englishCoffee(@"raktajino"), @"should be false");
}

@end
