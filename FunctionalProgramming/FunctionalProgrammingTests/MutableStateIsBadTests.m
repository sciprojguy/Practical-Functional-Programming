//
//  FunctionalProgrammingTests.m
//  FunctionalProgrammingTests
//
//  Created by james c Woodard on 1/10/15.
//  Copyright (c) 2015 TBCocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "NSArray+Functional.h"

typedef enum {
    Unknown = 0,
    Verb = 1,
    Noun = 2,
    Adjective = 3
} WordType;

Boolean numberIsEven( int number );
WordType wordType( char *word );

Boolean numberIsEven( int number ) {
    int remainder = number % 2;
    if(remainder==0)
        return TRUE;
    else
        return FALSE;
}

WordType wordType( char *word ) {
    WordType wType = Unknown;
    char *verbs[] = { "hop", "skip", "stumble", "throw", "catch" };
    char *nouns[] = { "exception", "variable", "bean", "energy drink" };
    char *adjectives[] = { "green", "large", "beautiful" };
    
    // check verbs
    for( int i=0; i<5; i++ ) {
        if(!strcmp(word, verbs[i])) {
            wType = Verb;
            break;
        }
    }
    
    // check nouns
    for( int i=0; i<4; i++ ) {
        if(!strcmp(word, nouns[i])) {
            wType = Noun;
            break;
        }
    }
    
    // check adjectives
    for( int i=0; i<3; i++ ) {
        if(!strcmp(word, adjectives[i])) {
            wType = Adjective;
            break;
        }
    }
    
    return wType;
}

/***********************************************************************
Example code for shared mutable state and why it's not a good idea.
these are two simple functions that you'd think are supposed to do
nested loops, but they don't work.  Both functions are using the
same interator variable (i) to run their loops.  But the inner loop
is changing that iterator variable so that when the outer loop is
run, the second time through it'll stop.  *THIS IS NOT WHAT IS SUPPOSED
TO HAPPEN.*
 ***********************************************************************/

int i = 0;              // shared mutable state.  yech.

void innerLoop(int M);  // C prototypes, or what interfaces looked like before Objective C or C++
void outerLoop(int N);

void innerLoop(int M) {
    for( i=0; i<M; i++ ) {
        printf("------> Inner loop iteration number %d\n", i);
    }
}

void outerLoop(int N) {
    for( i=0; i<N; i++ ) {
        printf("\nOuter loop iteration number %d\n", i);
        innerLoop(12);
    }
}

// in the ObjC world (and the OO world in general) this happens in classes where you
// have an object property that's shared and modified by multiple methods

@interface BozoClass : NSObject
@property (nonatomic, assign) int i;

-(void)outerLoop;
-(void)innerLoop;

@end

@implementation BozoClass

-(void)outerLoop {
    for( _i=0; _i<10; _i++ ) {
        printf("Bozo Outer Loop: %d\n", _i);
    }
}

-(void)innerLoop {
    for( _i=0; _i<10; _i++ ) {
        printf("Bozo Inner Loop: %d\n", _i);
    }
}

-(void)betterOuterLoop {
    for( int i=0; i<10; i++ ) {
        printf("Better Bozo Outer Loop: %d\n", i);
        [self betterInnerLoop];
    }
}

-(void)betterInnerLoop {
    for( int i=0; i<10; i++ ) {
        printf("Better Bozo Inner Loop: %d\n", i);
    }
}

@end

@interface MutableStateIsBadTests : XCTestCase

@end

@implementation MutableStateIsBadTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testSampleFunction1 {
    if(numberIsEven(2)) {
        NSLog(@"yes, 2 is even");
    }
    if(numberIsEven(3)) {
        NSLog(@"Something is bad wrong here, kemosabe");
    }
}

-(void)testSampleFunction2 {
    XCTAssertTrue( Verb == wordType("hop"), "hop is a verb");
}

-(void)testSharedMutableStateNoNo {
    outerLoop(5);
}

-(void)testBozoLoops {
    BozoClass *clown = [[BozoClass alloc] init];
    [clown outerLoop];
}

-(void)testBetterBozoLoops {
    BozoClass *clown = [[BozoClass alloc] init];
    [clown betterOuterLoop];
}


@end
