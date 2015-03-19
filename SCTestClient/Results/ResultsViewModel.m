//
//  ResultsViewModel.m
//  SCTestClient
//
//  Created by Joan Romano on 3/15/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import "ResultsViewModel.h"

#import <RACStream.h>
#import <RACSequence.h>
#import <RACSignal.h>
#import <RACEXTScope.h>
#import <NSArray+RACSequenceAdditions.h>

#import "Artist.h"
#import "Fetcher.h"

static NSString *const kUsersGetFormattedPath = @"http://localhost:3000/users?username=%@&page=%@";

@implementation NSArray (Users)

- (NSArray *)artistArray
{
    return [self.rac_sequence map:^id(NSDictionary *dictionary) {
        return [[Artist alloc] initWithDictionary:dictionary];
    }].array;
}

@end

@interface ResultsViewModel ()

@property (nonatomic, copy) NSString *userInput;

@property (nonatomic) NSUInteger currentPage;
@property (nonatomic, strong) Fetcher *fetcher;
@property (nonatomic, copy) NSArray *loadedArtists;

@end

@implementation ResultsViewModel

- (instancetype)initWithUserInput:(NSString *)input
{
    if (self = [super init])
    {
        _userInput = [input copy];
        _fetcher = [[Fetcher alloc] init];
        _loadedArtists = @[@[], @[]];
    }
    
    return self;
}

- (RACSignal *)nextArtistsSignal
{
    @weakify(self)
    
    self.currentPage += 1;
    
    return
    [[self.fetcher GET:[NSString stringWithFormat:kUsersGetFormattedPath, self.userInput, @(self.currentPage)]]
     map:^id(NSArray *artistsArray) {
         @strongify(self)
         
         NSMutableArray *mutableFirstDegre = [self.loadedArtists.firstObject mutableCopy],
                        *mutableSecondDegree = [self.loadedArtists.lastObject mutableCopy];
         [mutableFirstDegre addObjectsFromArray:[artistsArray.firstObject artistArray]];
         [mutableSecondDegree addObjectsFromArray:[artistsArray.lastObject artistArray]];
         
         return self.loadedArtists = @[[mutableFirstDegre copy], [mutableSecondDegree copy]];
    }];
}

@end
