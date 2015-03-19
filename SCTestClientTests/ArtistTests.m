//
//  ArtistTests.m
//  SCTestClient
//
//  Created by Joan Romano on 3/19/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Artist.h"

@interface ArtistTests : XCTestCase

@property (nonatomic, strong) Artist *sut;

@end

@implementation ArtistTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testEmptyDictionary
{
    self.sut = [[Artist alloc] initWithDictionary:@{}];
    
    XCTAssertNotNil(self.sut, @"Artist shouldn't be nil");
    XCTAssertNil(self.sut.displayName, @"Display name should be nil");
    XCTAssertNil(self.sut.username, @"Display name should be nil");
}

- (void)testEmptyJustUsername
{
    self.sut = [[Artist alloc] initWithDictionary:@{@"username" : @"user_4"}];
    
    XCTAssertNotNil(self.sut.username, @"Artist username shouldn't be nil");
    XCTAssertEqual(self.sut.username, @"user_4", @"Both usernames should be equal");
    XCTAssertNil(self.sut.displayName, @"Display name should be nil");
}

- (void)testFullUser
{
    self.sut = [[Artist alloc] initWithDictionary:@{@"username" : @"user_4",
                                                    @"display_name" : @"user_4",
                                                    @"icon_url" : @"https://robohash.org/user_4",
                                                    @"upload_track_count" : @40}];
    
    XCTAssertNotNil(self.sut.username, @"Artist username shouldn't be nil");
    XCTAssertNotNil(self.sut.displayName, @"Display name should be nil");
    XCTAssertNotNil(self.sut.iconURL, @"Icon url username shouldn't be nil");
    XCTAssertTrue(self.sut.uploadTrackCount == 40, @"Upload track count souldn' be nil");
}


@end
