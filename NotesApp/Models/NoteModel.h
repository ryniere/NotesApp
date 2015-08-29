//
//  NoteModel.h
//  NotesApp
//
//  Created by Ryniere S Silva on 29/08/15.
//  Copyright (c) 2015 Ryniere S Silva. All rights reserved.
//

#import "RLMObject.h"
#import <UIKit/UIKit.h>

@interface NoteModel : RLMObject

@property UIFont *textFont;
@property UIColor *textColor;
@property UIColor *backgroundColor;
@property NSString *text;
@property NSDate *createdAt;
@property NSDate *updatedAt;

@end
