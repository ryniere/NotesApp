//
//  NoteManager.m
//  NotesApp
//
//  Created by Ryniere S Silva on 29/08/15.
//  Copyright (c) 2015 Ryniere S Silva. All rights reserved.
//

#import "NoteManager.h"

@interface NoteManager()

@property RLMRealm *realm;

@end

@implementation NoteManager

+ (id)sharedManager {
    static NoteManager *sharedNoteManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNoteManager = [[self alloc] init];
        sharedNoteManager.realm = [RLMRealm defaultRealm];
    });
    return sharedNoteManager;
}

- (void) addNote:(NoteModel *) note{
    
    // Add to Realm with transaction
    [self.realm beginWriteTransaction];
    [self.realm addObject:note];
    [self.realm commitWriteTransaction];
    
}

- (void) updateNote:(NoteModel *)note withText:(NSString *) text{
    
    [self.realm beginWriteTransaction];
    note.text = text;
    note.updatedAt = [NSDate date];
    [self.realm commitWriteTransaction];
}

- (void) updateNote:(NoteModel *)note withBackgroundColor:(NSString *) color{
    
    [self.realm beginWriteTransaction];
    note.backgroundColor = color;
    note.updatedAt = [NSDate date];
    [self.realm commitWriteTransaction];
    
}
- (void) updateNote:(NoteModel *)note withTextColor:(NSString *) color{
    
    [self.realm beginWriteTransaction];
    note.textColor = color;
    note.updatedAt = [NSDate date];
    [self.realm commitWriteTransaction];
    
}

- (void) updateNote:(NoteModel *)note withTextFont:(NSString *) fontName{
    
    [self.realm beginWriteTransaction];
    note.textFont = fontName;
    note.updatedAt = [NSDate date];
    [self.realm commitWriteTransaction];
    
}

- (void) updateNote:(NoteModel *)note withFontSize:(NSInteger) fontSize{
    
    [self.realm beginWriteTransaction];
    note.textSize = fontSize;
    note.updatedAt = [NSDate date];
    [self.realm commitWriteTransaction];
    
}


- (void) removeNoteAtIndex:(NSInteger)index{
    
    NoteModel *note = [self getNoteAtIndex:index];
    
    [self.realm beginWriteTransaction];
    [self.realm deleteObject:note];
    [self.realm commitWriteTransaction];
    
}

- (NoteModel *) getNoteAtIndex:(NSInteger)index{
    
    return [[self getNotes] objectAtIndex:index];
}

- (RLMResults *) getNotes{
    
   return [[NoteModel allObjects] sortedResultsUsingProperty:@"updatedAt" ascending:false];
    
}


@end
