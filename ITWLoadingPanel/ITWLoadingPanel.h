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

#import <UIKit/UIKit.h>

#ifndef ILP_USE_ARC
    #define ILP_USE_ARC __has_feature(objc_arc)
#endif

#if ILP_USE_ARC
    #define ILP_RETAIN(xx)           xx
    #define ILP_RELEASE(xx)
    #define ILP_AUTORELEASE(xx)      xx
#else
    #define ILP_RETAIN(xx)           [xx retain];
    #define ILP_RELEASE(xx)          [xx release];
    #define ILP_AUTORELEASE(xx)      [xx autorelease];
#endif

typedef void(^ITWLoadingPanelBasicBlock)(void);

@interface ITWLoadingPanel : UIView

@property (nonatomic, strong) IBOutlet UIButton *cancelBtn;
@property (nonatomic, strong) IBOutlet UIProgressView *progressView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, strong) IBOutlet UIImageView *successImageView;
@property (nonatomic, strong) IBOutlet UILabel *cancelLabel;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, readonly) CFTimeInterval animationDuration;
@property (nonatomic, copy) ITWLoadingPanelBasicBlock onDisappearBlock;
@property (nonatomic, copy) ITWLoadingPanelBasicBlock onCancelBlock;

+ (id)sharedInstance;

+ (id)panel;

+ (ITWLoadingPanel *)showPanelInView:(UIView *)view
                               title:(NSString *)title
                         cancelTitle:(NSString *)cancelTitle
                              cancel:(ITWLoadingPanelBasicBlock)cancel
                           disappear:(ITWLoadingPanelBasicBlock)disappear;


+ (ITWLoadingPanel *)showPanelInView:(UIView *)view
                               title:(NSString *)title
                         cancelTitle:(NSString *)cancelTitle
                              cancel:(ITWLoadingPanelBasicBlock)cancel;

+ (ITWLoadingPanel *)showPanelInView:(UIView *)view
                               title:(NSString *)title
                         cancelTitle:(NSString *)cancelTitle;

+ (void)showSuccess;

- (void)showSuccess;

+ (void)hidePanel;

- (void)hidePanel;

+ (void)setProgress:(float)progress animated:(BOOL)animated;

+ (float)progress;

+ (CFTimeInterval)animationDuration;

- (CFTimeInterval)animationDuration;

+ (CFTimeInterval)disappearWaitTime;

- (CFTimeInterval)disappearWaitTime;

@end
