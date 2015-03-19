//
//  ResultsViewModel.h
//  SCTestClient
//
//  Created by Joan Romano on 3/15/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal, Fetcher;

@interface ResultsViewModel : NSObject

@property (nonatomic, copy, readonly) NSString *userInput;

- (instancetype)initWithUserInput:(NSString *)input fetcher:(Fetcher *)fetcher NS_DESIGNATED_INITIALIZER;

/**
 Retrieves the next page of artists, returning a signal that sends the acumulated artist array on next event and completes, or error if the fetch failed.
 
 NOTE: The artist array will be conformed of two inner arrays: a first degree artists array and a second degree artist array.
 */
- (RACSignal *)nextArtistsSignal;

@end
