//
//  BackCarouselView.m
//  CarouselCardDemo
//
//  Created by Anand Patel on 06/09/16.
//  Copyright © 2016 Anand Patel. All rights reserved.
//

#import "BackCarouselView.h"

@implementation BackCarouselView


- (void)awakeFromNib {
    self.frontView    = [[[NSBundle mainBundle] loadNibNamed:@"FrontCarouselView" owner:self options:nil] objectAtIndex:0];
    self.frontView.frame = CGRectMake(20, 0, self.frontView.frame.size.width, self.frontView.frame.size.height);
    [self addSubview:self.frontView];
    
    
    self.containerView.layer.cornerRadius = 6;
    self.containerView.alpha = 0;
    self.currentContainerViewScaleX = 0.8;
    self.currentContainerViewScaleY = 0.7;
    
    self.containerView.transform = CGAffineTransformMakeScale(self.currentContainerViewScaleX, self.currentContainerViewScaleY);

}

@end
