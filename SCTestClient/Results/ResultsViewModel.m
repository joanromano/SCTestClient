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
#import <RACSignal+Operations.h>
#import <NSArray+RACSequenceAdditions.h>
#import <NSObject+RACPropertySubscribing.h>

#import "Artist.h"
#import "Fetcher.h"

static NSString *const kUsersGetFormattedPath = @"https://scartists.herokuapp.com/artists?username=%@&page=%@";

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

- (instancetype)initWithUserInput:(NSString *)input fetcher:(Fetcher *)fetcher
{
    if (self = [super init])
    {
        _userInput = [input copy];
        _fetcher = fetcher;
        _loadedArtists = @[@[], @[]];
    }
    
    return self;
}

- (RACSignal *)nextArtistsSignal
{
    @weakify(self)
    
    self.currentPage += 1;
    
    return
    [[RACSignal
      combineLatest:
  @[[RACSignal return:self.loadedArtists],
    [self.fetcher GET:[NSString stringWithFormat:kUsersGetFormattedPath, self.userInput, @(self.currentPage)]]]
      reduce:^id(NSArray *loadedArtists, NSDictionary *newArtists){
          NSMutableArray *mutableFirstDegree = [loadedArtists.firstObject mutableCopy],
                         *mutableSecondDegree = [loadedArtists.lastObject mutableCopy];
                          
          [mutableFirstDegree addObjectsFromArray:[newArtists[@"first_degree"] artistArray]];
          [mutableSecondDegree addObjectsFromArray:[newArtists[@"second_degree"] artistArray]];
                          
          return @[[mutableFirstDegree copy], [mutableSecondDegree copy]];
      }]
     doNext:^(NSArray *loadedArtists) {
         @strongify(self)
         self.loadedArtists = loadedArtists;
     }];
}

@end
