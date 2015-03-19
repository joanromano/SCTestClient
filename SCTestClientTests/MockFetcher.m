//
//  MockFetcher.m
//  SCTestClient
//
//  Created by Joan Romano on 3/19/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import "MockFetcher.h"

#import <RACSignal.h>
#import <RACSubscriber.h>
#import <RACSignal+Operations.h>

@implementation MockFetcher

- (RACSignal *)GET:(NSString *)path
{
    return
    [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:self.response];
        [subscriber sendCompleted];
        
        return nil;
    }] deliverOnMainThread];
}

@end
