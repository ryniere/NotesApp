//
//  ColorPickerViewController.m
//  NotesApp
//
//  Created by Ryniere S Silva on 29/08/15.
//  Copyright (c) 2015 Ryniere S Silva. All rights reserved.
//

#import "ColorPickerViewController.h"
#import "HRColorPickerView.h"

@interface ColorPickerViewController (){
    id <ColorPickerViewControllerDelegate> __weak delegate;
}


@property (nonatomic, weak) IBOutlet HRColorPickerView *colorPickerView;

@end

@implementation ColorPickerViewController{
    UIColor *_color;
}

@synthesize delegate;

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.colorPickerView addTarget:self
                             action:@selector(colorDidChange:)
                   forControlEvents:UIControlEventValueChanged];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.colorPickerView.color = _color;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.delegate) {
        [self.delegate setSelectedColor:self.color];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)colorDidChange:(HRColorPickerView *)colorPickerView {
    _color = colorPickerView.color;
}

- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
