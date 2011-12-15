//
//  XTDropDownViewController.h
//
//  Created by Mikhail Bushuev on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XTDropDownViewControllerDelegate;

@interface XTDropDownViewController : UIViewController {
@private
    BOOL _viewsIsVisible;
    
    // initial head height
    CGFloat _headHeight;
    
    UIInterfaceOrientation _orientation;
}

@property (nonatomic, retain) IBOutlet UIView *headView;
@property (nonatomic, retain) IBOutlet UIView *shadowView;

@property (nonatomic, assign) id<XTDropDownViewControllerDelegate> delegate;

// Show controller with animation
// in parent of this viewController you need to set
// modalPresentationStyle = UIModalPresentationCurrentContext
// then [yourViewController presentModalViewController:dropDownVC animated:NO]
// and [dropDownVC show]
// dissmiss when you received dropDownViewControllerDidDisappear:
// dont forget to set delegate =)
- (void)show;
// Hide animated
- (void)hide;

@end

@protocol XTDropDownViewControllerDelegate <NSObject>
@optional
// when headView and shadowView is hidden
// now you can dissmiss this controller
- (void)dropDownViewControllerDidDisappear:(id)sender;
@end