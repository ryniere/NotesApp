//
//  DetailViewController.m
//  NotesApp
//
//  Created by Ryniere S Silva on 29/08/15.
//  Copyright (c) 2015 Ryniere S Silva. All rights reserved.
//

#import "DetailViewController.h"
#import "NoteSettingsViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(NoteModel *)newNote {
    if (_note != newNote) {
        _note = newNote;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    self.noteTextView.delegate = self;
    if (self.note) {
        self.noteTextView.text = self.note.text;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.view setBackgroundColor:[UIColor colorWithCSS:self.note.backgroundColor]];
    self.noteTextView.textColor = [UIColor colorWithCSS:self.note.textColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma TextView Delegate
- (void)textViewDidChange:(UITextView *)textView{

    [[NoteManager sharedManager] updateNote:self.note withText:textView.text];
    
}
- (IBAction)openSettings:(id)sender {
    
    UIStoryboard *storybrd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NoteSettingsViewController *noteSettings = [storybrd instantiateViewControllerWithIdentifier:@"NoteSettingsViewController"];
    noteSettings.note = self.note;
    
    [[self navigationController] pushViewController:noteSettings animated:true];
}

@end
