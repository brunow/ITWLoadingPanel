//
//  ViewController.m
//  ITWLoadingPanelExample
//
//  Created by Bruno Wernimont on 11/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#import "ITWLoadingPanel.h"

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (IBAction)showPanel:(id)sender {
    [ITWLoadingPanel showPanelInView:self.view title:@"Title" cancelTitle:@"Cancel"];
    
    [NSTimer scheduledTimerWithTimeInterval:0.05
                                     target:self
                                   selector:@selector(updatePanelProgress:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)updatePanelProgress:(NSTimer *)timer {
    UIProgressView *progressView = [[ITWLoadingPanel sharedInstance] progressView];
    [ITWLoadingPanel setProgress:(progressView.progress + 0.02) animated:YES];
    
    if (1 == progressView.progress) {
        [timer invalidate];
        [ITWLoadingPanel showSuccess];
    }
}

@end
