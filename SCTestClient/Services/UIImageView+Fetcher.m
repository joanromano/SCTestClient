//
//  UIImageView+Fetcher.m
//  SCTestClient
//
//  Created by Joan Romano on 3/18/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import "UIImageView+Fetcher.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (Fetcher)

- (void)setImageWithURL:(NSURL *)imageURL
{
    [self sd_setImageWithURL:imageURL];
}

@end
