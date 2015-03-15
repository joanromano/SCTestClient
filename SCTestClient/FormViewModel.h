//
//  FormViewModel.h
//  SCTestClient
//
//  Created by Joan Romano on 3/15/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACCommand;

@interface FormViewModel : NSObject

/**
 The current form input. Should be updated for the view model to make its logic.
 */
@property (nonatomic, copy) NSString *formInput;

/**
 A command which when enabled will invoke a signal which will send a new results view model on next event and complete.
 */
@property (nonatomic, strong, readonly) RACCommand *formCommand;

@end
