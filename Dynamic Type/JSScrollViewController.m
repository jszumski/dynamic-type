//
//  JSScrollViewController.m
//  Dynamic Type
//
//  Created by John Szumski
//  Copyright (c) 2013 CapTech Consulting. All rights reserved.
//

#import "JSScrollViewController.h"


@interface JSScrollViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *bodyLabel;

@end


@implementation JSScrollViewController

- (id)init {
	self = [super init];
	
	self.title = @"Scroll View";
	self.tabBarItem.image = [UIImage imageNamed:@"icon-scroll"];
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.scrollView = [[UIScrollView alloc] init];
	self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.scrollView];

	self.titleLabel = [[UILabel alloc] init];
	self.titleLabel.text = @"Mountain Lion (Puma concolor)";
	self.titleLabel.numberOfLines = 0;
	self.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.view.bounds) - 40; // 40 = 20pts horizontal padding on each side
	self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;

	[self.scrollView addSubview:self.titleLabel];
	
	self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mountain_lion.jpg"]];
	self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.scrollView addSubview:self.imageView];
	
	self.bodyLabel = [[UILabel alloc] init];
	self.bodyLabel.numberOfLines = 0;
	self.bodyLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.view.bounds) - 40; // 40 = 20pts horizontal padding on each side
	self.bodyLabel.text = [self bodyText];
	self.bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self.scrollView addSubview:self.bodyLabel];
	
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
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[scrollView]|"
																	  options:kNilOptions
																	  metrics:nil
																		views:@{@"scrollView": self.scrollView}]];
	
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|"
																	  options:kNilOptions
																	  metrics:nil
																		views:@{@"scrollView": self.scrollView}]];
	
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[titleLabel(==width)]-|"
																	  options:kNilOptions
																	  metrics:@{@"width": @(self.titleLabel.preferredMaxLayoutWidth)}
																		views:@{@"titleLabel": self.titleLabel,
																				@"scrollView": self.scrollView}]];
	
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[imageView(==titleLabel)]-|"
																	  options:kNilOptions
																	  metrics:nil
																		views:@{@"imageView": self.imageView,
																				@"titleLabel": self.titleLabel}]];
	
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[bodyLabel(==titleLabel)]-|"
																	  options:kNilOptions
																	  metrics:nil
																		views:@{@"bodyLabel": self.bodyLabel,
																				@"titleLabel": self.titleLabel}]];
	
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[titleLabel]-[imageView]-[bodyLabel]-|"
																	  options:kNilOptions
																	  metrics:nil
																		views:@{@"titleLabel": self.titleLabel,
																				@"imageView" : self.imageView,
																				@"bodyLabel": self.bodyLabel}]];
}

- (void)applyFonts {
	self.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
	self.bodyLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}



#pragma mark - Helpers

- (NSString*)bodyText {
	// from http://en.wikipedia.org/wiki/Mountain_lion
	return @"The cougar (Puma concolor), also known as the mountain lion, puma, panther, mountain cat, or catamount, is a large cat of the family Felidae native to the Americas. Its range, from the Canadian Yukon to the southern Andes of South America, is the greatest of any large wild terrestrial mammal in the Western Hemisphere. An adaptable, generalist species, the cougar is found in most American habitat types. It is the second heaviest cat in the Western Hemisphere, after the jaguar. Solitary by nature and nocturnal, the cougar is most closely related to smaller felines and is nearer genetically to the domestic cat than true lions.\n\
\n\
An excellent stalk-and-ambush predator, the cougar pursues a wide variety of prey. Primary food sources include ungulates such as deer, elk, moose, and bighorn sheep, as well as domestic cattle, horses and sheep, particularly in the northern part of its range. It will also hunt species as small as insects and rodents. This cat prefers habitats with dense underbrush and rocky areas for stalking, but can also live in open areas. The cougar is territorial and survives at low population densities. Individual territory sizes depend on terrain, vegetation, and abundance of prey. While large, it is not always the apex predator in its range, yielding to the jaguar, grey wolf, American black bear, and grizzly bear. It is reclusive and usually avoids people. Fatal attacks on humans are rare, but have been trending upward in recent years as more people enter their territory.\n\
\n\
Excessive hunting following European colonization of the Americas and the ongoing human development of cougar habitat has caused populations to drop in most parts of its historical range. In particular, the cougar was extirpated in eastern North America in the beginning of the 20th century, except for an isolated subpopulation in Florida. However, in recent decades, breeding populations have moved east into the far western parts of the Dakotas, Nebraska, and Oklahoma. Transient males have been verified in Minnesota, Wisconsin, Iowa, the Upper Peninsula of Michigan, and Illinois, where a cougar was shot in the city limits of Chicago and, in at least one instance, observed as far east as Connecticut.";
}

@end