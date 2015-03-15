//
//  ResultsViewController.m
//  SCTestClient
//
//  Created by Joan Romano on 3/15/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import "ResultsViewController.h"

#import "ResultsViewModel.h"
#import "SectionedArrayDataSource.h"
#import "ArtistCellAdapter.h"

#import <RACEXTScope.h>
#import <RACSignal.h>

@interface ResultsViewController ()

@property (nonatomic, strong) ResultsViewModel *viewModel;
@property (nonatomic, strong) SectionedArrayDataSource *dataSource;

@property (nonatomic, weak) IBOutlet UITableView *resultsTableView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end

@implementation ResultsViewController

- (instancetype)init
{
    return [self initWithViewModel:[[ResultsViewModel alloc] initWithInput:@""]];
}

- (instancetype)initWithViewModel:(ResultsViewModel *)viewModel
{
    if (self = [super init])
    {
        _viewModel = viewModel;
        
        self.title = @"Results";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupBindingsAndSubviews];
}

#pragma mark - Private

- (void)setupBindingsAndSubviews
{
    @weakify(self)
    
    self.dataSource = [[SectionedArrayDataSource alloc] initWithTableView:self.resultsTableView cellAdapter:[[ArtistCellAdapter alloc] init]];
    
    [self.viewModel.artists subscribeNext:^(id items) {
        @strongify(self)
        self.dataSource.items = items;
        [self.activityIndicatorView stopAnimating];
    }];
}

@end
