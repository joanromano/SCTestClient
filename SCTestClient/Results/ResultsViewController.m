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
#import "UIBarButtonItem+SCAdditions.h"

#import <RACEXTScope.h>
#import <RACSignal.h>

@interface ResultsViewController ()

@property (nonatomic, strong) ResultsViewModel *viewModel;
@property (nonatomic, strong) SectionedArrayDataSource *dataSource;

@property (nonatomic, weak) IBOutlet UITableView *resultsTableView;
@property (nonatomic, weak) IBOutlet UILabel *noUserFoundLabel;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end

@implementation ResultsViewController

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
    
    [self toggleRightNavigationItem];
    
    [self.viewModel.nextArtistsSignal subscribeNext:^(id items) {
        @strongify(self)
        self.dataSource.items = items;
        [self toggleSubviews];
    } error:^(NSError *error) {
        @strongify(self)
        [self toggleSubviews];
    }];
}

- (void)toggleSubviews
{
    BOOL artistsAvailable = [self.dataSource itemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] != nil;
    
    [self.activityIndicatorView stopAnimating];
    [self toggleRightNavigationItem];
    self.noUserFoundLabel.hidden = artistsAvailable;
    self.resultsTableView.hidden = !artistsAvailable;
}

- (void)toggleRightNavigationItem
{
    if (self.navigationItem.rightBarButtonItem.enabled)
    {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem activityIndicatorBarButtonItem];
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBarButtonItemPressed)];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

- (void)setupBindingsAndSubviews
{
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"No user with username %@ is found", self.viewModel.userInput]];
    [mutableAttributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.0] range:[mutableAttributedString.string rangeOfString:self.viewModel.userInput]];
    
    self.noUserFoundLabel.attributedText = [mutableAttributedString copy];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBarButtonItemPressed)];
    self.dataSource = [[SectionedArrayDataSource alloc] initWithTableView:self.resultsTableView cellAdapter:[[ArtistCellAdapter alloc] init]];
    
    [self loadNextArtists];
}

@end
