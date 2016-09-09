//
//  BackCarouselView.h
//  CarouselCardDemo
//
//  Created by Anand Patel on 06/09/16.
//  Copyright © 2016 Anand Patel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrontCarouselView.h"


@interface BackCarouselView : UIView

@property (nonatomic, strong) FrontCarouselView *frontView;
@property (nonatomic, strong) IBOutlet UIView *containerView;
@property (nonatomic, assign) CGFloat currentContainerViewScaleX;
@property (nonatomic, assign) CGFloat currentContainerViewScaleY;




@end
