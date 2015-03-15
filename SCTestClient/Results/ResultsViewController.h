//
//  ResultsViewController.h
//  SCTestClient
//
//  Created by Joan Romano on 3/15/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ResultsViewModel;

@interface ResultsViewController : UIViewController

@property (nonatomic, strong, readonly) ResultsViewModel *viewModel;

- (instancetype)initWithViewModel:(ResultsViewModel *)viewModel NS_DESIGNATED_INITIALIZER;

@end
