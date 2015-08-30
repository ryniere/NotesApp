//
//  NoteSettingsViewController.h
//  NotesApp
//
//  Created by Ryniere S Silva on 29/08/15.
//  Copyright (c) 2015 Ryniere S Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorPickerViewController.h"
#import "NoteModel.h"

@interface NoteSettingsViewController : UIViewController<ColorPickerViewControllerDelegate>

@property (strong,nonatomic) NoteModel *note;

@end
