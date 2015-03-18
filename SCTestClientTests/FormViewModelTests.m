//
//  FormViewModelTests.m
//  SCTestClient
//
//  Created by Joan Romano on 3/18/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "FormViewModel.h"
#import "ResultsViewModel.h"
#import <RACCommand.h>
#import <RACSignal.h>

@interface FormViewModelTests : XCTestCase

@property (nonatomic, strong) FormViewModel *sut;

@end

@implementation FormViewModelTests

- (void)setUp
{
    [super setUp];
    
    self.sut = [[FormViewModel alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testNoFormInputCommandDisabled
{
    __block NSNumber *enabled = nil;
    XCTestExpectation *espectation = [self expectationWithDescription:self.name];
    
    [self.sut.formCommand.enabled subscribeNext:^(id x) {
        enabled = x;
        [espectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.0 handler:^(NSError *error) {
        XCTAssertFalse(enabled.boolValue, @"Command shouldn't be enabled");
    }];
}

- (void)testEmptyFormInputCommandDisabled
{
    __block NSNumber *enabled = nil;
    self.sut.formInput = @"";
    XCTestExpectation *espectation = [self expectationWithDescription:self.name];
    
    [self.sut.formCommand.enabled subscribeNext:^(id x) {
        enabled = x;
        [espectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.0 handler:^(NSError *error) {
        XCTAssertFalse(enabled.boolValue, @"Command shouldn't be enabled");
    }];
}

- (void)testFormInputCommandEnabled
{
    __block NSNumber *enabled = nil;
    self.sut.formInput = @"user_1";
    XCTestExpectation *expectation = [self expectationWithDescription:self.name];
    
    [self.sut.formCommand.enabled subscribeNext:^(id x) {
        enabled = x;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.0 handler:^(NSError *error) {
        XCTAssertTrue(enabled.boolValue, @"Command should be enabled");
    }];
}

- (void)testFormInputCommandEnabledResultsViewModel
{
    __block ResultsViewModel *resultsViewModel = nil;
    self.sut.formInput = @"user_1";
    XCTestExpectation *expectation = [self expectationWithDescription:self.name];
    
    [[self.sut.formCommand execute:@YES] subscribeNext:^(id x) {
        resultsViewModel = x;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:2.0 handler:^(NSError *error) {
         XCTAssertTrue(resultsViewModel != nil, @"View model shouldn't be nil");
         XCTAssertTrue([resultsViewModel isKindOfClass:ResultsViewModel.class], @"View model should be of ResultsViewModel class");
         XCTAssertEqualObjects(self.sut.formInput, resultsViewModel.userInput, @"Both view models should have same input");
    }];
}

@end
