//
//  ViewController.m
//  CarouselCardDemo
//
//  Created by Anand Patel on 06/09/16.
//  Copyright © 2016 Anand Patel. All rights reserved.
//
#define UPCARD_UPTO 60

#define BACKVIEW_WIDTH 200
#define BACKVIEW_HIGHT 280

#define FRONTVIEW_WIDTH 160
#define FRONTVIEW_HIGHT 240

#define ANIMATION_DURATION 0.3


#import "ViewController.h"
#import "UIView+MyExtensions.h"

typedef enum : NSUInteger {
    CarouselCardAnimationStateDefault,
    CarouselCardAnimationStateHalf,
    CarouselCardAnimationStateFull,
} CarouselCardAnimationState;

@interface ViewController ()<UIGestureRecognizerDelegate> {
    
    CarouselCardAnimationState state;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    state = CarouselCardAnimationStateDefault;
    self.carousel.type  = iCarouselTypeRotary;
    self.pageControl.currentPage= 0;
    self.pageControl.numberOfPages = 10;
    self.title = @"Carousel Card";
    
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.carousel.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:206.0/255.0 green:214.0/255.0 blue:222.0/255.0 alpha:1] CGColor], (id)[[UIColor colorWithRed:156.0/255.0 green:173.0/255.0 blue:190.0/255.0 alpha:1] CGColor], nil];
    [self.carousel.layer insertSublayer:gradient atIndex:0];

}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return 10;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    
    if (view == nil) {
        view = [[[NSBundle mainBundle] loadNibNamed:@"BackCarouselView" owner:self options:nil] objectAtIndex:0];

    }
    BackCarouselView *backView      = (BackCarouselView *)view;
    NSString *strImage = [NSString stringWithFormat:@"Image%ld",index+1];
    backView.frontView.imgBack.image = [UIImage imageNamed:strImage];
    
    // Add Gesture
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.delegate = self;
    [backView addGestureRecognizer:panGesture];

    
    return backView;
}
#pragma mark -
#pragma mark iCarousel methods

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return NO;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.15f;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return 0.0f;
            return value;
        }
        case iCarouselOptionVisibleItems:  {
            return 3;
        }
        case iCarouselOptionFadeMin: {
            return 0;

        }
        case iCarouselOptionFadeMinAlpha: {
            return 0;

        }
        case iCarouselOptionFadeRange: {
            return 2;

        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionOffsetMultiplier:
        {
            return value;
        }
    }
}
#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    //NSLog(@"Tapped view number: %ld", (long)index);
    [self didTapOnCard];
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
   // NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
    self.pageControl.currentPage = self.carousel.currentItemIndex;
}
- (void)carouselWillBeginDragging:(iCarousel *)carousel {
    [self collapseHalfAnimation];
}

#pragma mark -
#pragma mark Expansion and Collapse Animation

- (void)expandHalfAnimation {
    
    state = CarouselCardAnimationStateHalf;
    BackCarouselView *backView = (BackCarouselView *)self.carousel.currentItemView;
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        backView.containerView.alpha = 1;
        [backView.frontView setOriginY:-UPCARD_UPTO];
        backView.containerView.transform = CGAffineTransformMakeScale(1, 1);
        
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)expandFullAnimation {
    state = CarouselCardAnimationStateFull;
}
- (void)collapseHalfAnimation {
    state = CarouselCardAnimationStateDefault;
    
    BackCarouselView *backView = (BackCarouselView *)self.carousel.currentItemView;
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        
        backView.containerView.alpha = 0;
        [backView.frontView setOriginY:0];
        backView.containerView.transform = CGAffineTransformMakeScale(backView.currentContainerViewScaleX, backView.currentContainerViewScaleY);
        
    } completion:^(BOOL finished) {
        
    }];
}
- (void)collapseFullAnimation {
    state = CarouselCardAnimationStateHalf;
    
}
#pragma mark -
#pragma mark Gesture Methos
- (void)didTapOnCard {
    if (state == CarouselCardAnimationStateDefault) {
        [self expandHalfAnimation];
    } else if (state == CarouselCardAnimationStateHalf) {
        [self collapseHalfAnimation];
    }
}
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint velocity = [panGestureRecognizer velocityInView:self.carousel.currentItemView];
    return fabs(velocity.y) > fabs(velocity.x);
}
- (void)handlePanGesture:(UIPanGestureRecognizer *)pgr {
    
    CGPoint translation = [pgr translationInView:pgr.view];
    
    BackCarouselView *backView = (BackCarouselView *)self.carousel.currentItemView;
    UIView *frontView = [backView frontView];
    
    CGRect newFrame = frontView.frame;
    newFrame.origin.y = newFrame.origin.y + translation.y;

    if (pgr.state==UIGestureRecognizerStateChanged){
    
        if (newFrame.origin.y>=-UPCARD_UPTO && newFrame.origin.y <= 0) {
            frontView.frame = newFrame;
            
            float alpha = newFrame.origin.y /UPCARD_UPTO;
            backView.containerView.alpha = fabsf(alpha);
            
            float totalScaleDifferenceX = 1 - backView.currentContainerViewScaleX;
            float totalScaleDifferenceY = 1 - backView.currentContainerViewScaleY;

            float scaleX = ((totalScaleDifferenceX/UPCARD_UPTO) *  fabs(newFrame.origin.y)) + backView.currentContainerViewScaleX;
            float scaleY = ((totalScaleDifferenceY/UPCARD_UPTO) *  fabs(newFrame.origin.y)) + backView.currentContainerViewScaleY;

            backView.containerView.transform = CGAffineTransformMakeScale(scaleX, scaleY);


            if (fabs(newFrame.origin.y) < UPCARD_UPTO/2) {
                state = CarouselCardAnimationStateHalf;
            } else {
                state = CarouselCardAnimationStateDefault;
            }
        }
        [pgr setTranslation:CGPointZero inView:pgr.view];
    }
    else if ( pgr.state == UIGestureRecognizerStateEnded) {
        if (!(backView.frontView.origin.y == 0 &&  backView.frontView.origin.y == -UPCARD_UPTO)) {
            [self didTapOnCard];
        }
    }
}

@end
