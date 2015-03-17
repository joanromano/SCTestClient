//
//  ResultsViewModel.h
//  SCTestClient
//
//  Created by Joan Romano on 3/15/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface ResultsViewModel : NSObject

@property (nonatomic, copy, readonly) NSString *userInput;

- (instancetype)initWithUserInput:(NSString *)input;

- (RACSignal *)artistsSignal;

@end
