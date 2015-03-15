//
//  ResultsViewModel.m
//  SCTestClient
//
//  Created by Joan Romano on 3/15/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import "ResultsViewModel.h"

@interface ResultsViewModel ()

@property (nonatomic, copy) NSString *input;

@end

@implementation ResultsViewModel

- (instancetype)initWithInput:(NSString *)input
{
    if (self = [super init])
    {
        _input = [input copy];
    }
    
    return self;
}

@end
