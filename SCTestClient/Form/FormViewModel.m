//
//  FormViewModel.m
//  SCTestClient
//
//  Created by Joan Romano on 3/15/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import "FormViewModel.h"

#import <RACCommand.h>
#import <NSObject+RACPropertySubscribing.h>
#import <RACSignal.h>
#import <RACEXTScope.h>

#import "ResultsViewModel.h"

@interface FormViewModel ()

@property (nonatomic, strong) RACCommand *formCommand;

@end

@implementation FormViewModel

- (RACCommand *)formCommand
{
    if (!_formCommand)
    {
        @weakify(self)
        
        _formCommand =
        [[RACCommand alloc]
         initWithEnabled:
         [RACObserve(self, formInput) map:^id(NSString *inputValue) {
            return @(inputValue.length > 0);
        }]
         signalBlock:^RACSignal *(id input) {
             @strongify(self)
             return [RACSignal return:[[ResultsViewModel alloc] initWithUserInput:self.formInput]];
         }];
    }
    
    return _formCommand;
}

@end
