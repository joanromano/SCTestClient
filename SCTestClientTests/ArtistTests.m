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
    Artist *sut = [[Artist alloc] initWithDictionary:@{}];
    
    XCTAssertNotNil(sut, @"Artist shouldn't be nil");
    XCTAssertNil(sut.displayName, @"Display name should be nil");
    XCTAssertNil(sut.username, @"Artist username should be nil");
}

- (void)testEmptyJustUsername
{
    Artist *sut = [[Artist alloc] initWithDictionary:@{@"username" : @"user_4"}];
    
    XCTAssertNotNil(sut.username, @"Artist username shouldn't be nil");
    XCTAssertEqual(sut.username, @"user_4", @"Both usernames should be equal");
    XCTAssertNil(sut.displayName, @"Display name should be nil");
}

- (void)testFullArtist
{
    Artist *sut = [[Artist alloc] initWithDictionary:@{@"username" : @"user_4",
                                                    @"display_name" : @"user_4",
                                                    @"icon_url" : @"https://robohash.org/user_4",
                                                    @"upload_track_count" : @40}];
    
    XCTAssertNotNil(sut.username, @"Artist username shouldn't be nil");
    XCTAssertNotNil(sut.displayName, @"Display name should be nil");
    XCTAssertNotNil(sut.iconURL, @"Icon url username shouldn't be nil");
    XCTAssertTrue(sut.uploadTrackCount == 40, @"Upload track count souldn' be nil");
}

- (void)testInvalidDictionaryParams
{
    Artist *sut = [[Artist alloc] initWithDictionary:@{@"username" : @"user_4",
                                                       @"display_name" : @"user_4",
                                                       @"icon_url" : @"https://robohash.org/user_4",
                                                       @"upload_track_count" : @24,
                                                       @"not" : @"whatever",
                                                       @"foo" : @"bar"}];
    
    XCTAssertNotNil(sut.username, @"Artist username shouldn't be nil");
    XCTAssertNotNil(sut.displayName, @"Display name should be nil");
    XCTAssertNotNil(sut.iconURL, @"Icon url username shouldn't be nil");
    XCTAssertTrue(sut.uploadTrackCount == 24, @"Upload track count souldn' be nil");
}


@end
