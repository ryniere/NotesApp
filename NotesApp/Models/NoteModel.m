//
//  NoteModel.m
//  NotesApp
//
//  Created by Ryniere S Silva on 29/08/15.
//  Copyright (c) 2015 Ryniere S Silva. All rights reserved.
//

#import "NoteModel.h"

@interface NoteModel()

@property NSDate *initialDate;

@end

@implementation NoteModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.initialDate = [NSDate date];
        self.updatedAt = self.initialDate;
    }
    return self;
}

+ (NSDictionary *)defaultPropertyValues {
    return @{@"textFont" : @"", @"textColor": @"", @"backgroundColor": @"", @"text": @""};
}

-(NSDate *) createdAt{
    return self.initialDate;
}

@end
