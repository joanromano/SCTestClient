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
    return [self initWithViewModel:[[ResultsViewModel alloc] initWithUserInput:@""]];
}

- (instancetype)initWithViewModel:(ResultsViewModel *)viewModel
{
    if (self = [super init])
    {
        _viewModel = viewModel;
        
        self.title = viewModel.userInput;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupBindingsAndSubviews];
}

#pragma mark - Actions

- (void)addBarButtonItemPressed
{
    [self loadNextArtists];
}

#pragma mark - Private

- (void)loadNextArtists
{
    @weakify(self)
    
    [self.viewModel.nextArtistsSignal subscribeNext:^(id items) {
        @strongify(self)
        self.dataSource.items = items;
        [self.activityIndicatorView stopAnimating];
    }];
}

- (RACSignal *)loadNextArtistsSignal
{
    return self.viewModel.nextArtistsSignal;
}

- (void)setupBindingsAndSubviews
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBarButtonItemPressed)];
    self.dataSource = [[SectionedArrayDataSource alloc] initWithTableView:self.resultsTableView cellAdapter:[[ArtistCellAdapter alloc] init]];
    
    [self loadNextArtists];
}

@end
