//
//  UIFont+AvenirContentSize.m
//  Dynamic Type
//
//  Created by John Szumski on 9/12/13.
//  Copyright (c) 2013 CapTech Consulting. All rights reserved.
//

#import "UIFont+AvenirContentSize.h"

@implementation UIFont (AvenirContentSize)

+ (UIFont *)preferredAvenirFontForTextStyle:(NSString *)textStyle
{
	// choose the font size
	CGFloat fontSize = 16.f;
	NSString *contentSize = [UIApplication sharedApplication].preferredContentSizeCategory;
    
    static NSString *FONT_NAME_REGULAR = @"Avenir-Book";
    static NSString *FONT_NAME_MEDIUM = @"Avenir-Medium";
    
    static dispatch_once_t onceToken;
    static NSDictionary *fontSizeOffsetDictionary;
    dispatch_once(&onceToken, ^{
        
        fontSizeOffsetDictionary = @{ UIContentSizeCategoryExtraSmall     :     @{ UIFontTextStyleBody : @(-2),
                                                                                   UIFontTextStyleHeadline : @(-2),
                                                                                   UIFontTextStyleSubheadline : @(-4),
                                                                                   UIFontTextStyleCaption1 : @(-5),
                                                                                   UIFontTextStyleCaption2 : @(-5),
                                                                                   UIFontTextStyleFootnote : @(-4) },
                                      
                                      UIContentSizeCategorySmall          :   @{ UIFontTextStyleBody : @(-1),
                                                                                 UIFontTextStyleHeadline : @(-1),
                                                                                 UIFontTextStyleSubheadline : @(-3),
                                                                                 UIFontTextStyleCaption1 : @(-5),
                                                                                 UIFontTextStyleCaption2 : @(-5),
                                                                                 UIFontTextStyleFootnote : @(-4) },
                                      
                                      UIContentSizeCategoryMedium         :   @{ UIFontTextStyleBody : @(0),
                                                                                 UIFontTextStyleHeadline : @(0),
                                                                                 UIFontTextStyleSubheadline : @(-2),
                                                                                 UIFontTextStyleCaption1 : @(-5),
                                                                                 UIFontTextStyleCaption2 : @(-5),
                                                                                 UIFontTextStyleFootnote : @(-4) },
                                      
                                      UIContentSizeCategoryLarge          :   @{ UIFontTextStyleBody : @(1),
                                                                                 UIFontTextStyleHeadline : @(1),
                                                                                 UIFontTextStyleSubheadline : @(-1),
                                                                                 UIFontTextStyleCaption1 : @(-4),
                                                                                 UIFontTextStyleCaption2 : @(-5),
                                                                                 UIFontTextStyleFootnote : @(-3) },
                                      
                                      UIContentSizeCategoryExtraLarge     :   @{ UIFontTextStyleBody : @(2),
                                                                                 UIFontTextStyleHeadline : @(2),
                                                                                 UIFontTextStyleSubheadline : @(0),
                                                                                 UIFontTextStyleCaption1 : @(-3),
                                                                                 UIFontTextStyleCaption2 : @(-4),
                                                                                 UIFontTextStyleFootnote : @(-2) },
                                      
                                      UIContentSizeCategoryExtraExtraLarge :  @{ UIFontTextStyleBody : @(3),
                                                                                 UIFontTextStyleHeadline : @(3),
                                                                                 UIFontTextStyleSubheadline : @(1),
                                                                                 UIFontTextStyleCaption1 : @(-2),
                                                                                 UIFontTextStyleCaption2 : @(-3),
                                                                                 UIFontTextStyleFootnote : @(-1) },
                                      
                                      UIContentSizeCategoryExtraExtraExtraLarge : @{ UIFontTextStyleBody : @(4),
                                                                                     UIFontTextStyleHeadline : @(4),
                                                                                     UIFontTextStyleSubheadline : @(2),
                                                                                     UIFontTextStyleCaption1 : @(-1),
                                                                                     UIFontTextStyleCaption2 : @(-2),
                                                                                     UIFontTextStyleFootnote : @(0) }
                                      };
    });
    
    // adjust the default font size based on what the User has set in Settings
    CGFloat fontSizeOffset = [fontSizeOffsetDictionary[contentSize][textStyle] doubleValue];
    fontSize += fontSizeOffset;
    
    // choose the font weight
	if ([textStyle isEqualToString:UIFontTextStyleHeadline] ||
		[textStyle isEqualToString:UIFontTextStyleSubheadline]) {
        
		return [UIFont fontWithName:FONT_NAME_MEDIUM size:fontSize];
        
	} else {
		return [UIFont fontWithName:FONT_NAME_REGULAR size:fontSize];
	}
}

@end