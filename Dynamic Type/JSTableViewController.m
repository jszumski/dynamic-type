//
//  JSTableViewController.m
//  Dynamic Type
//
//  Created by John Szumski
//  Copyright (c) 2013 CapTech Consulting. All rights reserved.
//

#import "JSTableViewController.h"
#import "UIFont+AvenirContentSize.h"

@interface JSTableViewController()

@property (nonatomic,strong) NSArray *codenames;
@property (nonatomic,strong) UISegmentedControl *fontSelector;

@end

@implementation JSTableViewController

- (id)init {
    self = [super initWithStyle:UITableViewStylePlain];
	
    if (self) {
		self.title = @"Table View";
		self.tabBarItem.image = [UIImage imageNamed:@"icon-table"];
		
        self.codenames = @[@"iOS 1.0 - Alpine",
						   @"iOS 1.0.x - Heavenly",
						   @"iOS 1.1 - Little Bear",
						   @"iOS 1.1.1 - Snowbird",
						   @"iOS 1.1.2 - Oktoberfest (additional text to make this wrap to new lines)",
						   @"iOS 2.0 - Big Bear",
						   @"iOS 2.1 - Sugarbowl",
						   @"iOS 2.2 - Timberline",
						   @"iOS 3.0 - Kirkwood",
						   @"iOS 3.1 - Northstar",
						   @"iOS 3.2 - Wildcat",
						   @"iOS 4.0 - Apex",
						   @"iOS 4.1 - Baker",
						   @"iOS 4.2 - Jasper",
						   @"iOS 4.3 - Durango",
						   @"iOS 5.0 - Telluride",
						   @"iOS 5.1 - Hoodoo",
						   @"iOS 6.0 - Sundance",
						   @"iOS 7.0 - Innsbruck"];
    }
	
    return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.fontSelector = [[UISegmentedControl alloc] initWithItems:@[@"System Font", @"Custom Font"]];
	self.fontSelector.selectedSegmentIndex = 0;
	[self.fontSelector addTarget:self action:@selector(userTextSizeDidChange) forControlEvents:UIControlEventValueChanged];

	self.navigationItem.titleView = self.fontSelector;
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(userTextSizeDidChange)
												 name:UIContentSizeCategoryDidChangeNotification
											   object:nil];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)userTextSizeDidChange {
	[self.tableView reloadData];
}


#pragma mark - UI response

- (void)fontSelectorDidChange:(UISegmentedControl*)segmentedControl {
	[self userTextSizeDidChange];
}


#pragma mark - Helpers

- (UIFont*)fontForBodyTextStyle {
	if (self.fontSelector.selectedSegmentIndex == 0) {
		return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
		
	} else {
		return [UIFont preferredAvenirFontForTextStyle:UIFontTextStyleBody];
	}
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.codenames count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *codename = self.codenames[indexPath.row];
	CGRect codenameRect = [codename boundingRectWithSize:CGSizeMake(CGRectGetWidth(tableView.bounds) - 40, MAXFLOAT) // 40 = 20pt horizontal padding on each side
												 options:NSStringDrawingUsesLineFragmentOrigin
											  attributes:@{NSFontAttributeName: [self fontForBodyTextStyle]}
												 context:nil];
	
	return MAX(44.0f, CGRectGetHeight(CGRectIntegral(codenameRect)) + 20); // 20 = 10pt vertical padding on each end
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CodenameCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.textLabel.numberOfLines = 0;
	}
	
	cell.textLabel.text = self.codenames[indexPath.row];
	cell.textLabel.font = [self fontForBodyTextStyle];
	
	return cell;
}

@end