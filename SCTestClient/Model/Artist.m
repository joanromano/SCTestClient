//
//  Artist.m
//  SCTestClient
//
//  Created by Joan Romano on 3/17/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import "Artist.h"

@interface Artist ()

@property (nonatomic, copy) NSString *displayName, *username;
@property (nonatomic, strong) NSURL *iconURL;
@property (nonatomic) NSUInteger uploadTrackCount;

@end

@implementation Artist

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _displayName = dictionary[@"display_name"];
        _username = dictionary[@"username"];
        _iconURL = [NSURL URLWithString:dictionary[@"icon_url"]];
        _uploadTrackCount = [dictionary[@"upload_track_count"] unsignedIntegerValue];
    }
    
    return self;
}

@end
