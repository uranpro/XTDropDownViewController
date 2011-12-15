//
//  ViewController.m
//  DropDownViewControllerDemo
//
//  Created by Mikhail Bushuev on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "XTDropDownViewController.h"

@interface ViewController(private) <XTDropDownViewControllerDelegate>
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
            // iPhone
            _dropDownViewController = [[XTDropDownViewController alloc] initWithNibName:@"XTDropDownViewController_iPhone"
                                                                                 bundle:nil];
        else
            // iPad
            _dropDownViewController = [[XTDropDownViewController alloc] initWithNibName:@"XTDropDownViewController_iPad"
                                                                                 bundle:nil];
        _dropDownViewController.delegate = self;
    }
    return self;
}

- (void)dealloc {
    [_dropDownViewController release];
    
    [super dealloc];
}

#pragma mark - UIViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        // iPhone
        return (toInterfaceOrientation == UIInterfaceOrientationPortrait ||
                UIInterfaceOrientationIsLandscape(toInterfaceOrientation));
    else
        // iPad
        return YES;
}

#pragma mark - Public
#pragma mark - IB Methods

- (IBAction)showDropDownViewController:(id)sender {
    [self presentModalViewController:_dropDownViewController
                            animated:NO];
    [_dropDownViewController show];
}

#pragma mark - Private
#pragma mark - XTDropDownViewControllerDelegate

- (void)dropDownViewControllerDidDisappear:(id)sender {
    [self dismissModalViewControllerAnimated:NO];
}

@end
