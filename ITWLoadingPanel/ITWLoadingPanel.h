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

typedef void(^ITWLoadingPanelBasicBlock)(void);

@interface ITWLoadingPanel : UIView

@property (nonatomic, retain) IBOutlet UIButton *cancelBtn;
@property (nonatomic, retain) IBOutlet UIProgressView *progressView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, retain) IBOutlet UIImageView *successImageView;
@property (nonatomic, retain) IBOutlet UILabel *cancelLabel;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
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
