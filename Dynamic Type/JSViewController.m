//
//  JSViewController.m
//  Dynamic Type
//
//  Created by John Szumski
//  Copyright (c) 2013 CapTech Consulting. All rights reserved.
//

#import "JSViewController.h"
#import "UIFont+AvenirContentSize.h"


@interface JSViewController()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *messageLabel;

@end



@implementation JSViewController

- (id)init {
	self = [super init];
	
	self.title = @"View";
	self.tabBarItem.image = [UIImage imageNamed:@"icon-view"];
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];

	self.titleLabel = [[UILabel alloc] init];
	self.titleLabel.numberOfLines = 0;
	self.titleLabel.preferredMaxLayoutWidth = 280;
	self.titleLabel.textAlignment = NSTextAlignmentCenter;
	self.titleLabel.text = @"This is a plain ol' UIView layout";
	self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.titleLabel];
	
	self.messageLabel = [[UILabel alloc] init];
	self.messageLabel.numberOfLines = 0;
	self.messageLabel.preferredMaxLayoutWidth = 280;
	self.messageLabel.text = @"It doesn't do anything except adjust to content size changes.";
	self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.messageLabel];
	
	[self applyConstraints];
	[self applyFonts];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(userTextSizeDidChange)
												 name:UIContentSizeCategoryDidChangeNotification
											   object:nil];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)userTextSizeDidChange {
	[self applyFonts];
}

- (void)applyConstraints {
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[titleLabel(==width)]-|"
																	  options:kNilOptions
																	  metrics:@{@"width": @(self.titleLabel.preferredMaxLayoutWidth)}
																		views:@{@"titleLabel": self.titleLabel}]];
	
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[messageLabel(==titleLabel)]-|"
																	  options:kNilOptions
																	  metrics:nil
																		views:@{@"messageLabel": self.messageLabel,
																				@"titleLabel": self.titleLabel}]];
	
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[titleLabel]-100-[messageLabel]"
																	  options:kNilOptions
																	  metrics:nil
																		views:@{@"titleLabel": self.titleLabel,
																				@"messageLabel": self.messageLabel}]];
}

- (void)applyFonts {
	self.titleLabel.font = [UIFont preferredAvenirFontForTextStyle:UIFontTextStyleHeadline];
	self.messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

@end