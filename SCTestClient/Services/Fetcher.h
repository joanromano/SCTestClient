//
//  Fetcher.h
//  SCTestClient
//
//  Created by Joan Romano on 3/17/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal, UIImageView;

@interface Fetcher : NSObject

+ (RACSignal *)GET:(NSString *)path;

+ (void)imageWithURL:(NSURL *)imageURL imageView:(UIImageView *)imageView;

@end
