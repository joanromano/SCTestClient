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
    XCTAssertEqualObjects(self.sut, self.mockTableView.dataSource, @"Both data sources should be equal");
}

- (void)testNoItemsNoSectionsNoRows
{
    XCTAssertEqual([self.sut numberOfSectionsInTableView:self.mockTableView], 0, @"There should not be sections if no items");
    XCTAssertEqual([self.sut tableView:self.mockTableView numberOfRowsInSection:0], 0, @"There should not be rows if no items");
}

- (void)testOneArrayOfItemsOneSectionThreeItemsInSection
{
    self.sut.items = @[@[@"one", @"two", @"three"]];
    
    XCTAssertEqual([self.sut numberOfSectionsInTableView:self.mockTableView], 1, @"Should have one section");
    XCTAssertEqual([self.sut tableView:self.mockTableView numberOfRowsInSection:0], 3, @"Should have three rows in first section");
}

- (void)testTwoArrayTwoSections
{
    self.sut.items = @[@[@"one", @"two", @"three"], @[@"one", @"two", @"three"]];
    
    XCTAssertEqual([self.sut numberOfSectionsInTableView:self.mockTableView], 2, @"Should have two sections");
    XCTAssertEqual([self.sut tableView:self.mockTableView numberOfRowsInSection:0], 3, @"Should have three rows in first section");
    XCTAssertEqual([self.sut tableView:self.mockTableView numberOfRowsInSection:1], 3, @"Should have three rows in second section");
}

- (void)testTwoArrayTwoSectionsDifferentItems
{
    self.sut.items = @[@[@"one", @"two"], @[@"one", @"two", @"three", @"four", @"five", @"six"]];
    
    XCTAssertEqual([self.sut numberOfSectionsInTableView:self.mockTableView], 2, @"Should have two sections");
    XCTAssertEqual([self.sut tableView:self.mockTableView numberOfRowsInSection:0], 2, @"Should have two rows in first section");
    XCTAssertNotEqual([self.sut tableView:self.mockTableView numberOfRowsInSection:1], 3, @"Should not have three rows in second section");
    XCTAssertEqual([self.sut tableView:self.mockTableView numberOfRowsInSection:1], 6, @"Should have six rows in second section");
}

- (void)testChangeItemsUpdateRows
{
    self.sut.items = @[@[@"one", @"two"], @[@"one", @"two"]];
    
    XCTAssertEqual([self.sut tableView:self.mockTableView numberOfRowsInSection:0], 2, @"Should have two rows in first section");
    XCTAssertEqual([self.sut tableView:self.mockTableView numberOfRowsInSection:1], 2, @"Should have two rows in second section");
    
    self.sut.items = @[@[@"one"], @[@"one", @"two", @"three"]];
    
    XCTAssertEqual([self.sut tableView:self.mockTableView numberOfRowsInSection:0], 1, @"Should have one row in first section");
    XCTAssertEqual([self.sut tableView:self.mockTableView numberOfRowsInSection:1], 3, @"Should have three rows in second section");
    
    self.sut.items = @[@[@"one", @"two", @"three", @"four", @"five", @"six"], @[]];
    
    XCTAssertEqual([self.sut tableView:self.mockTableView numberOfRowsInSection:0], 6, @"Should have six row in first section");
    XCTAssertEqual([self.sut tableView:self.mockTableView numberOfRowsInSection:1], 0, @"Should have no rows in second section");
}

- (void)testOneArrayOfItemsValidIndexPath
{
    self.sut.items = @[@[@"one", @"two", @"three"]];
    
    XCTAssertNotNil([self.sut itemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]], @"Should give a non nil item for a valid index path");
}

- (void)testOneArrayOfItemsInvalidIndexPath
{
    self.sut.items = @[@[@"one", @"two", @"three"]];
    
    XCTAssertNil([self.sut itemAtIndexPath:[NSIndexPath indexPathForItem:4 inSection:0]], @"Should give a nil item for an invalid index path");
}

- (void)testInvalidItemsParamException
{
    NSArray *invalidItems = @[@"one", @"two", @"three"];
    
    XCTAssertThrowsSpecificNamed([self.sut setItems:invalidItems], NSException, NSInvalidArgumentException, @"Should throw NSInvalidArgumentException for an invalid items argument");
}

@end
