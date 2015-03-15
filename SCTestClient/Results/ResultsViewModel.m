//
//  ResultsViewModel.m
//  SCTestClient
//
//  Created by Joan Romano on 3/15/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import "ResultsViewModel.h"

#import <RACSignal.h>
#import <RACDisposable.h>
#import <RACSubscriber.h>
#import <RACSignal+Operations.h>

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

- (RACSignal *)artists
{
    return
    [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task =
        [session dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:3000/users?username=%@", self.input]]
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    if (!error)
                    {
                        [subscriber sendNext:@[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil], [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]]];
                        [subscriber sendCompleted];
                    }
                    else
                    {
                        [subscriber sendError:error];
                    }
                        
                }];
        [task resume];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }] deliverOnMainThread];
}

@end
