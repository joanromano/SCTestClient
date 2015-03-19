//
//  ResultsViewModelTests.m
//  SCTestClient
//
//  Created by Joan Romano on 3/18/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ResultsViewModel.h"

@interface ResultsViewModelTests : XCTestCase

@property (nonatomic, strong) ResultsViewModel *sut;

@end

@implementation ResultsViewModelTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testViewModelSameInputs
{
    NSString *userInput = @"input";
    self.sut = [[ResultsViewModel alloc] initWithUserInput:userInput];

    XCTAssertEqualObjects(userInput, self.sut.userInput, @"Both inputs should be equal");
}

- (void)testViewModelInvalidUsername
{
    NSString *userInput = @"invalidusername";
    self.sut = [[ResultsViewModel alloc] initWithUserInput:userInput];
    
    
}

@end
