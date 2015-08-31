//
//  NoteSettingsViewController.m
//  NotesApp
//
//  Created by Ryniere S Silva on 29/08/15.
//  Copyright (c) 2015 Ryniere S Silva. All rights reserved.
//

#import "NoteSettingsViewController.h"

@interface NoteSettingsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *fontColorButton;
@property (weak, nonatomic) IBOutlet UIButton *backgroundColorButton;
@property (strong, nonatomic)  ColorPickerViewController *colorPickerView;
@property (weak, nonatomic) IBOutlet UITextField *textSizeField;

@end

@implementation NoteSettingsViewController

bool isFontColor;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textSizeField.delegate = self;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.fontColorButton.backgroundColor = [UIColor colorWithCSS:self.note.textColor];
    self.backgroundColorButton.backgroundColor = [UIColor colorWithCSS:self.note.backgroundColor];
    self.textSizeField.text = [NSString stringWithFormat:@"%ld", (long)self.note.textSize];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self changeTextSize:self.textSizeField];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSelectedColor:(UIColor *)color{
    
    if (isFontColor) {
        [[NoteManager sharedManager] updateNote:self.note withTextColor:[color cssString]];
    }
    else{
        [[NoteManager sharedManager] updateNote:self.note withBackgroundColor:[color cssString]];
    }
    
}

- (void)changeTextSize:(UITextField *)textField {
    NSString *textSizeStr = textField.text;
    
    NSInteger textSize = [textSizeStr integerValue];
    
    if (textSize > 0 && textSize < 50) {
        [[NoteManager sharedManager] updateNote:self.note withFontSize:textSize];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self changeTextSize:textField];
    
}

- (void)openColorPickerView {
    
    if (self.colorPickerView == nil) {
        UIStoryboard *storybrd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.colorPickerView = [storybrd instantiateViewControllerWithIdentifier:@"ColorPickerViewController"];
        self.colorPickerView.delegate = self;
    }
    
    
    if (isFontColor) {
        self.colorPickerView.color = self.fontColorButton.backgroundColor;
    }
    else{
        self.colorPickerView.color = self.backgroundColorButton.backgroundColor;
    }
    
    [self presentViewController:self.colorPickerView animated:true completion:nil];
}

- (IBAction)changeFontColor:(id)sender {
    
    isFontColor = true;
    
    [self openColorPickerView];
    
}

- (IBAction)changeBackgroundColor:(id)sender {
    
    isFontColor = false;
    [self openColorPickerView];
}


@end
