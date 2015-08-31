//
//  NoteManager.h
//  NotesApp
//
//  Created by Ryniere S Silva on 29/08/15.
//  Copyright (c) 2015 Ryniere S Silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteModel.h"

@interface NoteManager : NSObject

+ (id)sharedManager;


- (void) addNote:(NoteModel *) note;
- (void) updateNote:(NoteModel *)note withText:(NSString *) text;
- (void) updateNote:(NoteModel *)note withBackgroundColor:(NSString *) color;
- (void) updateNote:(NoteModel *)note withTextColor:(NSString *) color;
- (void) updateNote:(NoteModel *)note withTextFont:(NSString *) fontName;
- (void) updateNote:(NoteModel *)note withFontSize:(NSInteger) fontSize;
- (NoteModel *) getNoteAtIndex:(NSInteger)index;
- (void) removeNoteAtIndex:(NSInteger)index;
- (RLMResults *) getNotes;
@end
