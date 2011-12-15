//
//  ViewController.h
//  DropDownViewControllerDemo
//
//  Created by Mikhail Bushuev on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTDropDownViewController;

@interface ViewController : UIViewController {
@private
    XTDropDownViewController *_dropDownViewController;
}

- (IBAction)showDropDownViewController:(id)sender;

@end
