//
//  ArtistCellAdapter.m
//  SCTestClient
//
//  Created by Joan Romano on 3/15/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import "ArtistCellAdapter.h"

static NSString *const kCellIdentifier = @"CellIdentifier";

@implementation ArtistCellAdapter

- (UITableViewCell *)cellForTableView:(UITableView *)tableView item:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = item;
    
    return cell;
}

- (void)registerClassOrNibForTableView:(UITableView *)tableView
{
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
}

@end
