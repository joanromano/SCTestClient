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
#import "MockFetcher.h"
#import "Artist.h"

#import <RACSignal.h>
#import <RACSignal+Operations.h>
#import <RACEXTScope.h>

@interface ResultsViewModelTests : XCTestCase

@property (nonatomic, copy) NSString *userInput;
@property (nonatomic, strong) MockFetcher *fetcher;
@property (nonatomic, strong) ResultsViewModel *sut;

@end

@implementation ResultsViewModelTests

- (void)setUp
{
    [super setUp];
    
    self.userInput = @"username";
    self.fetcher = [[MockFetcher alloc] init];
    self.sut = [[ResultsViewModel alloc] initWithUserInput:self.userInput fetcher:self.fetcher];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSameInputs
{
    XCTAssertEqualObjects(self.userInput, self.sut.userInput, @"Both inputs should be equal");
}

- (void)testTwoArtistsResponse
{
    __block NSArray *artists = nil;
    self.fetcher.response = @{@"first_degree" : @[@{@"username" : @"user1"}],
                              @"second_degree" : @[@{@"username" : @"user2"}]};
    XCTestExpectation *expectation = [self expectationWithDescription:self.name];
    
    [self.sut.nextArtistsSignal subscribeNext:^(id x) {
        artists = x;
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:1.0 handler:^(NSError *error) {
        XCTAssertNotNil(artists, @"Artists array shouldn't be nil");
        XCTAssertTrue(artists.count == 2, @"Artists array should have two inner arrays");
        XCTAssertTrue([artists.firstObject count] == 1, @"First inner array should have one artist");
    }];
}

- (void)testTwoArtistsResponseTwoRequests
{
    @weakify(self)
    __block NSArray *artists = nil;
    self.fetcher.response = @{@"first_degree" : @[@{@"username" : @"user1"}],
                              @"second_degree" : @[@{@"username" : @"user2"}]};
    XCTestExpectation *expectation = [self expectationWithDescription:self.name];
    
    [[self.sut.nextArtistsSignal
        flattenMap:^RACStream *(id value) {
            @strongify(self)
            return self.sut.nextArtistsSignal;
    }]
        subscribeNext:^(id x) {
            artists = x;
            [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:1.0 handler:^(NSError *error) {
        XCTAssertTrue(artists.count == 2, @"Artists array should have two inner arrays");
        XCTAssertTrue([artists.lastObject count] == 2, @"Second inner array should have two artists");
        XCTAssertTrue([artists.firstObject count] == 2, @"First inner array should have two artists");
    }];
}

- (void)testThreeAndNoneArtistsResponseThreeRequests
{
    @weakify(self)
    __block NSArray *artists = nil;
    self.fetcher.response = @{@"first_degree" : @[@{@"username" : @"user1"}, @{@"username" : @"user2"}, @{@"username" : @"user3"}],
                              @"second_degree" : @[]};
    XCTestExpectation *expectation = [self expectationWithDescription:self.name];
    
    [[[self.sut.nextArtistsSignal
        flattenMap:^RACStream *(id value) {
            @strongify(self)
            return self.sut.nextArtistsSignal;
    }]
        flattenMap:^RACStream *(id value) {
            @strongify(self)
            return self.sut.nextArtistsSignal;
    }]
        subscribeNext:^(id x) {
            artists = x;
            [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:1.0 handler:^(NSError *error) {
        XCTAssertTrue([artists.firstObject count] == 9, @"First inner array should have nine artists");
        XCTAssertTrue([artists.lastObject count] == 0, @"Second inner array should have no artists");
    }];
}

- (void)testNoArtistsResponseFourRequests
{
    @weakify(self)
    __block NSArray *artists = nil;
    self.fetcher.response = @{@"first_degree" : @[],
                              @"second_degree" : @[]};
    XCTestExpectation *expectation = [self expectationWithDescription:self.name];
    
    [[[self.sut.nextArtistsSignal
        flattenMap:^RACStream *(id value) {
            @strongify(self)
            return self.sut.nextArtistsSignal;
    }]
        flattenMap:^RACStream *(id value) {
            @strongify(self)
            return self.sut.nextArtistsSignal;
    }]
        subscribeNext:^(id x) {
            artists = x;
            [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:1.0 handler:^(NSError *error) {
        XCTAssertTrue(artists.count == 2, @"Artists array should have two inner arrays");
        XCTAssertTrue([artists.firstObject count] == 0, @"First inner array should have no artists");
        XCTAssertTrue([artists.firstObject count] == [artists.lastObject count], @"First and second inner array should have no artists");
    }];
}

@end
