//
// Created by Bruno Wernimont on 2012
// Copyright 2012 Intotheweb
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "ITWLoadingPanel.h"

#import <QuartzCore/QuartzCore.h>

static id _sharedObject = nil;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ITWLoadingPanel ()

- (void)animateAppearing;

@end


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ITWLoadingPanel

@synthesize cancelBtn;
@synthesize progressView;
@synthesize activityView;
@synthesize successImageView;
@synthesize cancelLabel;
@synthesize titleLabel;
@synthesize onDisappearBlock;
@synthesize onCancelBlock;


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)panel {
    id panel = [[[UINib nibWithNibName:@"ITWLoadingPanel" bundle:nil] 
                instantiateWithOwner:self options:nil] objectAtIndex:0];
    
    return panel;
    
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    self.cancelBtn = nil;
    self.progressView = nil;
    self.activityView = nil;
    self.successImageView = nil;
    self.cancelLabel = nil;
    self.titleLabel = nil;
    self.onCancelBlock = nil;
    self.onDisappearBlock = nil;
    
#ifdef ILP_USE_ARC
    // Do nothing
#else
    [super dealloc];
#endif
}


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)sharedInstance {
    if (_sharedObject == nil) {
        _sharedObject = ILP_RETAIN([self panel]);
    }
    
    return _sharedObject;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (CFTimeInterval)animationDuration {
    return 0.25;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (CFTimeInterval)animationDuration {
    return [[self class] animationDuration];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (CFTimeInterval)disappearWaitTime {
    return 2;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (CFTimeInterval)disappearWaitTime {
    return [[self class] disappearWaitTime];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Setter and Getter


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (void)setProgress:(float)progress animated:(BOOL)animated {
    UIProgressView *progressView = [[self sharedInstance] progressView];
    [progressView setProgress:progress];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (float)progress {
    UIProgressView *progressView = [[self sharedInstance] progressView];
    return progressView.progress;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Show - Hide


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (ITWLoadingPanel *)showPanelInView:(UIView *)view
                               title:(NSString *)title
                         cancelTitle:(NSString *)cancelTitle
                              cancel:(ITWLoadingPanelBasicBlock)cancel
                           disappear:(ITWLoadingPanelBasicBlock)disappear {
    
    ITWLoadingPanel *panel = _sharedObject;
    
    if (panel == nil) {
        panel = [self sharedInstance];
        
        panel.titleLabel.text = title;
        panel.cancelLabel.text = cancelTitle;
        panel.onCancelBlock = cancel;
        panel.onDisappearBlock = disappear;
        [panel.progressView setProgress:0];
        
        panel.frame = CGRectMake(0, 0, view.bounds.size.width, panel.frame.size.height);
        [view addSubview:panel];
        
        [panel animateAppearing];
    }
    
    return panel;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (ITWLoadingPanel *)showPanelInView:(UIView *)view
                               title:(NSString *)title
                         cancelTitle:(NSString *)cancelTitle
                              cancel:(ITWLoadingPanelBasicBlock)cancel {
    
    return [self showPanelInView:view title:title cancelTitle:cancelTitle cancel:cancel disappear:nil];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (ITWLoadingPanel *)showPanelInView:(UIView *)view
                               title:(NSString *)title
                         cancelTitle:(NSString *)cancelTitle {

    return [self showPanelInView:view title:title cancelTitle:cancelTitle cancel:nil disappear:nil];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (void)showSuccess {
    [[self sharedInstance] showSuccess];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showSuccess {
    self.successImageView.hidden = NO;
    self.successImageView.alpha = 0;
    
    [UIView animateWithDuration:0.6 animations:^{
        self.activityView.alpha = 0;
        self.successImageView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:[self disappearWaitTime]
                                     target:self
                                   selector:@selector(hidePanel)
                                   userInfo:nil
                                    repeats:NO];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (void)hidePanel {
    [[self sharedInstance] hidePanel];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)hidePanel {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    CATransition *transition = [CATransition animation];
	transition.duration = [self animationDuration];
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;
	transition.subtype = kCATransitionFromTop;
	[self.layer addAnimation:transition forKey:nil];
    self.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height); 
    
    if (self.onDisappearBlock) {
        self.onDisappearBlock();
    }
    
    [self performSelector:@selector(removePanelFromView) withObject:nil afterDelay:0.25];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removePanelFromView {
    [self removeFromSuperview];
    ILP_RELEASE(_sharedObject);
    _sharedObject = nil;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)didPressCancel:(id)sender {
    if (self.onCancelBlock) {
        self.onCancelBlock();
    }
    
    [self hidePanel];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)animateAppearing {
    CATransition *transition = [CATransition animation];
	transition.duration = [self animationDuration];
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;	
	transition.subtype = kCATransitionFromBottom;
	[self.layer addAnimation:transition forKey:nil];
}


@end
