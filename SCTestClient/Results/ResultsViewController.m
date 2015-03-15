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

@interface ResultsViewController ()

@property (nonatomic, strong) ResultsViewModel *viewModel;
@property (nonatomic, strong) SectionedArrayDataSource *dataSource;

@property (nonatomic, weak) IBOutlet UITableView *resultsTableView;

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
    
    self.dataSource = [[SectionedArrayDataSource alloc] initWithTableView:self.resultsTableView cellAdapter:[[ArtistCellAdapter alloc] init]];
    self.dataSource.items = @[@[@"asd",@"asd",@"asd",@"asd",@"asd"], @[@"asd",@"asd",@"asd",@"asd",@"asd"]];
}

@end
