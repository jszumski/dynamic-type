//
//  UIFont+AvenirContentSize.m
//  Dynamic Type
//
//  Created by John Szumski on 9/12/13.
//  Copyright (c) 2013 CapTech Consulting. All rights reserved.
//

#import "UIFont+AvenirContentSize.h"

@implementation UIFont (AvenirContentSize)

+ (UIFont *)preferredAvenirFontForTextStyle:(NSString *)textStyle {
	// choose the font size
	CGFloat fontSize = 16.0;
	NSString *contentSize = [UIApplication sharedApplication].preferredContentSizeCategory;
	
	if ([contentSize isEqualToString:UIContentSizeCategoryExtraSmall]) {
		fontSize = 12.0;
		
	} else if ([contentSize isEqualToString:UIContentSizeCategorySmall]) {
		fontSize = 14.0;
		
	} else if ([contentSize isEqualToString:UIContentSizeCategoryMedium]) {
		fontSize = 16.0;
		
	} else if ([contentSize isEqualToString:UIContentSizeCategoryLarge]) {
		fontSize = 18.0;
		
	} else if ([contentSize isEqualToString:UIContentSizeCategoryExtraLarge]) {
		fontSize = 20.0;
		
	} else if ([contentSize isEqualToString:UIContentSizeCategoryExtraExtraLarge]) {
		fontSize = 22.0;
		
	} else if ([contentSize isEqualToString:UIContentSizeCategoryExtraExtraExtraLarge]) {
		fontSize = 24.0;
	}
	
	
	// choose the font weight
	if ([textStyle isEqualToString:UIFontTextStyleHeadline] ||
		[textStyle isEqualToString:UIFontTextStyleSubheadline]) {
		
		return [UIFont fontWithName:@"Avenir-Black" size:fontSize];
		
	} else {
		return [UIFont fontWithName:@"Avenir-Medium" size:fontSize];
	}
}

@end