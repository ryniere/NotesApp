//
//  DetailViewController.m
//  NotesApp
//
//  Created by Ryniere S Silva on 29/08/15.
//  Copyright (c) 2015 Ryniere S Silva. All rights reserved.
//

#import "DetailViewController.h"
#import "NoteSettingsViewController.h"
#import <FTFontSelector/FTFontSelectorController.h>


@interface DetailViewController ()<UIPopoverControllerDelegate, FTFontSelectorControllerDelegate>


@property (strong)  UITextView *noteTextView;
@property (strong) UIBarButtonItem *changeFontButton;
@property (strong) UIPopoverController *currentPopoverController;
@property (strong) FTFontSelectorController *fontSelectorController;

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
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[UILabel class]]){
            [array addObject:view];
        }
        
    }
    
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    self.noteTextView = [[UITextView alloc] initWithFrame:frame];
    self.noteTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.noteTextView.textAlignment = NSTextAlignmentLeft;
    
    self.changeFontButton = [[UIBarButtonItem alloc] initWithTitle:@"Font"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(changeFont:)];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 44)];
    toolbar.tintColor = [UIColor lightGrayColor];
    toolbar.translucent = YES;
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    toolbar.items = @[self.changeFontButton];
    self.noteTextView.inputAccessoryView = toolbar;
    self.view = self.noteTextView;
    [self configureView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.view setBackgroundColor:[UIColor colorWithCSS:self.note.backgroundColor]];
    self.noteTextView.textColor = [UIColor colorWithCSS:self.note.textColor];
    self.noteTextView.font = [UIFont fontWithName:self.note.textFont size:self.note.textSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (FTFontSelectorController *)createFontController;
{
    NSString *postscriptfontName = self.note.textFont;
    FTFontSelectorController *controller;
    controller = [[FTFontSelectorController alloc] initWithSelectedFontName:postscriptfontName];
    controller.fontDelegate = self;
    return controller;
}

- (void)changeFont:(id)sender;
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.currentPopoverController) {
            [self.currentPopoverController dismissPopoverAnimated:YES];
            self.currentPopoverController = nil;
        } else {
            self.currentPopoverController = [[UIPopoverController alloc] initWithContentViewController:[self createFontController]];
            self.currentPopoverController.delegate = self;
            [self.currentPopoverController presentPopoverFromBarButtonItem:self.changeFontButton
                                                  permittedArrowDirections:UIPopoverArrowDirectionDown
                                                                  animated:YES];
        }
    } else {
        if (self.noteTextView.inputView == nil) {
            self.fontSelectorController = [self createFontController];
            // self.fontSelectorController.showsDismissButton = NO;
            
            self.fontSelectorController.navigationBar.barStyle = UIBarStyleDefault;
            // UIColor *cherryBlossomPink = [UIColor colorWithRed:1 green:197.0/255.0 blue:183.0/255.0 alpha:1];
            // self.fontSelectorController.navigationBar.tintColor = cherryBlossomPink;
            
            // HACK: To ensure the toolbar is still shown:
            //
            // 1. hide the keyboard (which is the text view’s inputView)
            // 2. assign the font selector to the UITextView’s inputView
            // 3. make the text view show the inputView again
            [self.noteTextView resignFirstResponder];
            self.noteTextView.inputView = self.fontSelectorController.view;
            [self.noteTextView becomeFirstResponder];
            // 4. finally do the proper child container dance, but not before
            //    assigning as the inputView, because iOS will complain
            [self addChildViewController:self.fontSelectorController];
            [self.fontSelectorController didMoveToParentViewController:self];
        } else {
            [self dismissInputViews];
            [self.noteTextView becomeFirstResponder];
        }
    }
}

- (void)dismissInputViews;
{
    [self.noteTextView resignFirstResponder];
    if (self.noteTextView.inputView) {
        [self.fontSelectorController willMoveToParentViewController:nil];
        self.noteTextView.inputView = nil;
        [self.fontSelectorController removeFromParentViewController];
        self.fontSelectorController = nil;
    }
}

#pragma mark -
#pragma mark UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController;
{
    self.currentPopoverController = nil;
}

#pragma mark -
#pragma mark FTUIFontSelectorController

- (void)fontSelectorController:(FTFontSelectorController *)controller
     didChangeSelectedFontName:(NSString *)fontName;
{
    [[NoteManager sharedManager] updateNote:self.note withTextFont:fontName];
    self.noteTextView.font = [UIFont fontWithName:fontName size:self.note.textSize];
}

- (void)fontSelectorControllerShouldBeDismissed:(FTFontSelectorController *)controller;
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self.currentPopoverController dismissPopoverAnimated:YES];
        self.currentPopoverController = nil;
    } else {
        [self dismissInputViews];
    }
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
