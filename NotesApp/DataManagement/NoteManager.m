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
    // Get the default Realm
    
    // Add to Realm with transaction
    [self.realm beginWriteTransaction];
    [self.realm addObject:note];
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
