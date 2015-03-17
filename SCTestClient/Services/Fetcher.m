//
//  Fetcher.m
//  SCTestClient
//
//  Created by Joan Romano on 3/17/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import "Fetcher.h"

#import <RACSignal.h>
#import <RACDisposable.h>
#import <RACSubscriber.h>
#import <RACSignal+Operations.h>
#import <UIKit/UIImage.h>

@implementation Fetcher

+ (RACSignal *)GET:(NSString *)path
{
    return
    [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task =
        [NSURLSession.sharedSession dataTaskWithURL:[NSURL URLWithString:path]
               completionHandler:^(NSData *data,
                                   NSURLResponse *response,
                                   NSError *error) {
                   if (!error)
                   {
                       [subscriber sendNext:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]];
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

+ (void)imageWithURL:(NSURL *)imageURL completionBlock:(void(^)(UIImage *))completion
{
    [[NSURLSession.sharedSession dataTaskWithURL:imageURL
           completionHandler:^(NSData *data,
                               NSURLResponse *response,
                               NSError *error) {
               if (!error && completion)
               {
                   dispatch_async(dispatch_get_main_queue(), ^{
                       completion([UIImage imageWithData:data]);
                   });
               }
               
           }] resume];
}

@end
