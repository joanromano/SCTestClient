//
//  SectionedArrayDataSource.h
//  SCTestClient
//
//  Created by Joan Romano on 3/15/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CellAdapterProtocol.h"

@interface SectionedArrayDataSource : NSObject

@property (nonatomic, copy) NSArray *items;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

- (instancetype)initWithTableView:(UITableView *)tableView cellAdapter:(id <CellAdapterProtocol>)cellAdapter NS_DESIGNATED_INITIALIZER;

@end
