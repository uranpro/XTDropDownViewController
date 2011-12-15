//
//  XTDropDownViewController.m
//
//  Created by Mikhail Bushuev on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "XTDropDownViewController.h"

#define kAnimateDuration .35

@interface XTDropDownViewController(private)
- (void)XTDropDownViewControllerInit;

// ui
- (void)setViewsVisibility:(BOOL)visible animated:(BOOL)animated;
- (void)showViewsAnimated:(BOOL)animated;
- (void)hideViewsAnimated:(BOOL)animated;
- (void)commitViewVisibility:(BOOL)visible;
- (void)moveWindowElementsDown:(BOOL)down;

// user iteractions
- (void)shadowViewClick:(UITapGestureRecognizer *)gr;

// helpers

@end

@implementation XTDropDownViewController

@synthesize headView = _headView;
@synthesize shadowView = _shadowView;

@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self XTDropDownViewControllerInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self XTDropDownViewControllerInit];
    }
    return self;
}

- (void)XTDropDownViewControllerInit {
    _viewsIsVisible = NO;
}

- (void)dealloc {
    [_shadowView release];
    [_headView release];
    _delegate = nil;
    
    [super dealloc];
}

#pragma mark - ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(shadowViewClick:)] autorelease];
    [_shadowView addGestureRecognizer:tap];
    
    _headFrame = _headView.frame;
    _shadowFrame = _shadowView.frame;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return toInterfaceOrientation == [[UIApplication sharedApplication] statusBarOrientation];
}

#pragma mark - Public
#pragma mark - Methods

- (void)show {
    [self showViewsAnimated:YES];
}

- (void)hide {
    [self hideViewsAnimated:YES];
}

#pragma mark - Private
#pragma mark - User iteractions

- (void)shadowViewClick:(UITapGestureRecognizer *)gr {
    [self hideViewsAnimated:YES];
}

#pragma mark - UI

- (void)moveWindowElementsDown:(BOOL)down {
    
    CGFloat sign = down ? 1.0 : -1.0;
    CGFloat x = 0.0;
    CGFloat y = 0.0;
    UIInterfaceOrientation o = [[UIApplication sharedApplication] statusBarOrientation];
    
    switch (o) {
        case UIInterfaceOrientationPortrait:
            y = _headFrame.size.height * sign;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            x = _headFrame.size.height * sign;
            break;
        case UIInterfaceOrientationLandscapeRight:
            x = _headFrame.size.height * sign * -1.0;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            y = _headFrame.size.height * sign * -1.0;
            break;
    }
    
    UIWindow *w = [[UIApplication sharedApplication] keyWindow];
    
    for (UIView *v in w.subviews) {
        
        if ([v isEqual:self.view])
            continue;
        
        CGRect vf = v.frame;
        v.frame = CGRectMake(vf.origin.x + x,
                             vf.origin.y + y,
                             vf.size.width,
                             vf.size.height);;
    }
}

- (void)commitViewVisibility:(BOOL)visible {
    
    CGRect hf = _headView.frame;
    _headView.frame = CGRectMake(hf.origin.x,
                                 hf.origin.y,
                                 hf.size.width,
                                 visible ? _headFrame.size.height : 0);
    
    CGRect sf = _shadowView.frame;
//    _shadowView.frame = CGRectMake(sf.origin.x,
//                                   visible ? _shadowFrame.origin.y : (_shadowFrame.origin.y + sf.size.height),
//                                   sf.size.width,
//                                   sf.size.height);
    _shadowView.frame = CGRectMake(sf.origin.x,
                                   visible ? _shadowFrame.origin.y : 0,
                                   sf.size.width,
                                   visible ?
                                   _shadowFrame.size.height :
                                   _shadowFrame.size.height + _shadowFrame.origin.y);
    _shadowView.alpha = visible ? 1 : 0;
    
}

- (void)setViewsVisibility:(BOOL)visible animated:(BOOL)animated {
    
    if (_viewsIsVisible == visible)
        return;
    
    if (animated && visible)
        [self commitViewVisibility:NO];
    
    [UIView animateWithDuration:animated ? kAnimateDuration : 0
                     animations:^(void) {
                         
                         [self moveWindowElementsDown:visible];
                         
                         [self commitViewVisibility:visible];
                         
                     }
                     completion:^(BOOL finished) {
                         
                         _viewsIsVisible = visible;
                         
                         if (!visible && _delegate && [_delegate respondsToSelector:@selector(dropDownViewControllerDidDisappear:)])
                             [_delegate dropDownViewControllerDidDisappear:self];
                         
                     }];
}

- (void)showViewsAnimated:(BOOL)animated {
    [self setViewsVisibility:YES
                    animated:animated];
}

- (void)hideViewsAnimated:(BOOL)animated {
    [self setViewsVisibility:NO
                    animated:animated];
}

@end
