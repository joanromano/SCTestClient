//
//  MockAdapter.m
//  SCTestClient
//
//  Created by Joan Romano on 3/19/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import "MockCellAdapter.h"

@implementation MockCellAdapter

- (id)cellForTableView:(UITableView *)tableView item:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

- (void)registerClassOrNibForTableView:(UITableView *)tableView
{
    
}

@end
