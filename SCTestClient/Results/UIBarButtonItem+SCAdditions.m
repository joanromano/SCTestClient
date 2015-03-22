//
//  UIBarButtonItem+SCAdditions.m
//  SCTestClient
//
//  Created by Joan Romano on 3/22/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import "UIBarButtonItem+SCAdditions.h"

@implementation UIBarButtonItem (SCAdditions)

+ (UIBarButtonItem *)activityIndicatorBarButtonItem
{
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem *activityBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:activityView];
    [activityView startAnimating];
    
    return activityBarButtonItem;
}

@end
