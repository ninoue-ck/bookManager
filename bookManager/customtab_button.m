//
//  customtab_button.m
//  bookManager
//
//  Created by inouenaoto on 2016/07/05.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//

#import "customtab_button.h"

@implementation customtab_button

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) return self;
    _border_color = [UIColor blackColor];
    _border_wideth = 0;
    _cornerradius = 0;
    return self;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _border_color = borderColor;
    self.layer.borderColor = _border_color.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _border_wideth = borderWidth;
    self.layer.borderWidth = _border_wideth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerradius = cornerRadius;
    self.layer.cornerRadius = _cornerradius;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
