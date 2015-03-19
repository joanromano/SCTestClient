//
//  MockFetcher.h
//  SCTestClient
//
//  Created by Joan Romano on 3/19/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import "Fetcher.h"

@interface MockFetcher : Fetcher

@property (nonatomic, copy) NSArray *response;

@end
