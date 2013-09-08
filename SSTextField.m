//
//  SSTextField.m
//  SSToolkit
//
//  Created by Sam Soffes on 3/11/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSTextField.h"

@interface SSTextField ()
- (void)_initialize;
@end

@implementation SSTextField

#pragma mark - Accessors

@synthesize textEdgeInsets = _textEdgeInsets;
@synthesize placeholderTextColor = _placeholderTextColor;

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
	_placeholderTextColor = placeholderTextColor;    
	if (!self.text && self.placeholder) {
		[self setNeedsDisplay];
	}
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self _initialize];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self _initialize];
    }
    return self;
}


#pragma mark - UITextField

- (CGRect)textRectForBounds:(CGRect)bounds {
	return UIEdgeInsetsInsetRect([super textRectForBounds:bounds], _textEdgeInsets);
}


- (CGRect)editingRectForBounds:(CGRect)bounds {
	return [self textRectForBounds:bounds];
}

- (void)drawPlaceholderInRect:(CGRect)rect {
//    Hack for iOS 7
    if ([[UIDevice currentDevice].systemVersion hasPrefix:@"7"]) {
        rect.origin.y += 12;
    }

  if (!_placeholderTextColor) {
    [super drawPlaceholderInRect:rect];
    return;
  }
  
    [_placeholderTextColor setFill];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_6_0
    [self.placeholder drawInRect:rect withFont:self.font lineBreakMode:NSLineBreakByTruncatingTail alignment:self.textAlignment];
#else
    [self.placeholder drawInRect:rect withFont:self.font lineBreakMode:UILineBreakModeTailTruncation alignment:self.textAlignment];
#endif
}



#pragma mark - Private

- (void)_initialize {
	_textEdgeInsets = UIEdgeInsetsMake(10.0, 7.0, 10.0, 10.0);;
}

@end
