//
//  Artist.h
//  SCTestClient
//
//  Created by Joan Romano on 3/17/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Artist : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy, readonly) NSString *displayName, *username;
@property (nonatomic, strong, readonly) NSURL *iconURL;
@property (nonatomic, readonly) NSUInteger uploadTrackCount;

@end
