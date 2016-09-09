
//
//  UIView+MyExtensions.m
//  ItzFun

//  Created by Anand Patel.
//  Copyright © 2016 Anand Patel. All rights reserved.


#import "UIView+MyExtensions.h"

@implementation UIView (MyExtensions)

@dynamic borderColor,borderWidth,cornerRadius;
@dynamic originX,originY,sizeWidth,sizeHeight,origin,size;


-(void)setBorderColor:(UIColor *)borderColor{
    [self.layer setBorderColor:borderColor.CGColor];
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    [self.layer setBorderWidth:borderWidth];
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    [self.layer setCornerRadius:cornerRadius];
    [self.layer setMasksToBounds:YES];
}
- (void)setOriginX:(CGFloat)originX {
    CGRect rect = self.frame;
    rect.origin.x = originX;
    self.frame = rect;
}
- (void)setOriginY:(CGFloat)originY {
    CGRect rect = self.frame;
    rect.origin.y = originY;
    self.frame = rect;
}
- (void)setSizeWidth:(CGFloat)sizeWidth {
    CGRect rect = self.frame;
    rect.size.width = sizeWidth;
    self.frame = rect;
}
- (void)setSizeHeight:(CGFloat)sizeHeight {
    CGRect rect = self.frame;
    rect.size.height = sizeHeight;
    self.frame = rect;
}
- (void)setOrigin:(CGPoint)origin {
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}
- (void)setSize:(CGSize)size {
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}
@end
