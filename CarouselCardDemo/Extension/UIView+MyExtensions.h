//
//  UIView+MyExtensions.h
//  ItzFun

//  Created by Anand Patel.
//  Copyright © 2016 Anand Patel. All rights reserved.


#import <UIKit/UIKit.h>

@interface UIView (MyExtensions)

@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;

@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, assign) CGFloat sizeWidth;
@property (nonatomic, assign) CGFloat sizeHeight;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;



@end
