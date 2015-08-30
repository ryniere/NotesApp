//
//  ColorPickerViewController.h
//  NotesApp
//
//  Created by Ryniere S Silva on 29/08/15.
//  Copyright (c) 2015 Ryniere S Silva. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorPickerViewControllerDelegate
- (void)setSelectedColor:(UIColor *)color;
@end

@interface ColorPickerViewController : UIViewController

@property (nonatomic, strong) UIColor* color;
@property (nonatomic, weak) id <ColorPickerViewControllerDelegate> delegate;

@end
