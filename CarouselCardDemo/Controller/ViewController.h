//
//  ViewController.h
//  CarouselCardDemo
//
//  Created by Anand Patel on 06/09/16.
//  Copyright © 2016 Anand Patel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "FrontCarouselView.h"
#import "BackCarouselView.h"

@interface ViewController : UIViewController <iCarouselDataSource,iCarouselDelegate>

@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;


@end

