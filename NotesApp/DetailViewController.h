//
//  DetailViewController.h
//  NotesApp
//
//  Created by Ryniere S Silva on 29/08/15.
//  Copyright (c) 2015 Ryniere S Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteModel.h"

@interface DetailViewController : UIViewController

@property (strong,nonatomic) NoteModel *note;
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

