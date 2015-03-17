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
#import <SDWebImage/UIImageView+WebCache.h>

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

+ (void)imageWithURL:(NSURL *)imageURL imageView:(UIImageView *)imageView
{
    [imageView sd_setImageWithURL:imageURL];
}

@end
