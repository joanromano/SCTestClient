//
//  SectionedArrayDataSourceTests.m
//  SCTestClient
//
//  Created by Joan Romano on 3/19/15.
//  Copyright (c) 2015 SoundCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "SectionedArrayDataSource.h"
#import "MockCellAdapter.h"

@interface SectionedArrayDataSourceTests : XCTestCase

@property (nonatomic, strong) SectionedArrayDataSource *sut;
@property (nonatomic, strong) MockCellAdapter *mockCellAdapter;
@property (nonatomic, strong) UITableView *mockTableView;

@end

@implementation SectionedArrayDataSourceTests

- (void)setUp
{
    [super setUp];
    
    self.mockCellAdapter = [[MockCellAdapter alloc] init];
    self.mockTableView = [[UITableView alloc] init];
    self.sut = [[SectionedArrayDataSource alloc] initWithTableView:self.mockTableView cellAdapter:self.mockCellAdapter];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testEqualDataSources
{
    XCTAssertEqualObjects(self.sut, self.mockTableView.dataSource);
}

- (void)testNoItemsNoSectionsNoRows
{
    XCTAssertEqual([self.sut numberOfSectionsInTableView:self.mockTableView], 0);
    XCTAssertEqual([self.sut tableView:self.mockTableView numberOfRowsInSection:0], 0);
}

- (void)testOneArrayOfItemsOneSectionThreeItemsInSection
{
    self.sut.items = @[@[@"one", @"two", @"three"]];
    
    XCTAssertEqual([self.sut numberOfSectionsInTableView:self.mockTableView], 1);
    XCTAssertEqual([self.sut tableView:self.mockTableView numberOfRowsInSection:0], 3);
}

- (void)testTwoArrayTwoSections
{
    self.sut.items = @[@[@"one", @"two", @"three"], @[@"one", @"two", @"three"]];
    
    XCTAssertEqual([self.sut numberOfSectionsInTableView:self.mockTableView], 2);
}

- (void)testOneArrayOfItemsValidIndexPath
{
    self.sut.items = @[@[@"one", @"two", @"three"]];
    
    XCTAssertNotNil([self.sut itemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]]);
}

- (void)testOneArrayOfItemsInvalidIndexPath
{
    self.sut.items = @[@[@"one", @"two", @"three"]];
    
    XCTAssertNil([self.sut itemAtIndexPath:[NSIndexPath indexPathForItem:4 inSection:0]]);
}

@end
