//
//  SectionedArrayDataSource.m
//  SCTestClient
//
//  Created by Joan Romano on 3/15/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import "SectionedArrayDataSource.h"

#import <UIKit/UIKit.h>

@interface SectionedArrayDataSource () <UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) id <CellAdapterProtocol> cellAdapter;

@end

@implementation SectionedArrayDataSource

#pragma mark - Public

- (instancetype)initWithTableView:(UITableView *)tableView cellAdapter:(id <CellAdapterProtocol>)cellAdapter
{
    if (self = [super init])
    {
        _tableView = tableView;
        _cellAdapter = cellAdapter;
        _tableView.dataSource = self;
        
        [_cellAdapter registerClassOrNibForTableView:_tableView];
    }
    
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.items[indexPath.section] count] > indexPath.row ? self.items[indexPath.section][indexPath.row] : nil;
}

- (void)setItems:(NSArray *)items
{
    _items = [items copy];
    
    [self.tableView reloadData];
}

#pragma mark - UITableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.items count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellAdapter cellForTableView:tableView item:[self itemAtIndexPath:indexPath] atIndexPath:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Group %@", @(section)];
}

@end
