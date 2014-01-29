//
//  DemoViewController.m
//  SquaresLoading
//
//  Created by robin on 1/29/14.
//  Copyright (c) 2014 SquaresLoading. All rights reserved.
//

#import "DemoViewController.h"
#import "RZSquaresLoading.h"

@interface DemoViewController () {
    RZSquaresLoading *_square;
    UIColor *_red;
    UIButton *_redButton;
    UIColor *_green;
    UIButton *_greenButton;
    UIColor *_blue;
    UIButton *_blueButton;
    UIColor *_orange;
    UIButton *_orangeButton;
    UIButton *_grayButton;
}

@end

@implementation DemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _square = [[RZSquaresLoading alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 36) / 2,
                                                                 (self.view.frame.size.height - 36) / 2,
                                                                 36,
                                                                 36)];
    [self.view addSubview:_square];
    
    // Color buttons
    _red = [[UIColor alloc] initWithRed:1.0 green:65.0/255 blue:54.0/255 alpha:1.0];
    _redButton = [[UIButton alloc] initWithFrame:CGRectMake(40, _square.frame.origin.y + 144, 32, 32)];
    _redButton.backgroundColor = _red;
    _redButton.layer.cornerRadius = 3.0;
    [_redButton addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_redButton];
    
    _green = [[UIColor alloc] initWithRed:46.0/255 green:204.0/255 blue:64.0/255 alpha:1.0];
    _greenButton = [[UIButton alloc] initWithFrame:CGRectMake(92, _square.frame.origin.y + 144, 32, 32)];
    _greenButton.backgroundColor = _green;
    _greenButton.layer.cornerRadius = 3.0;
    [_greenButton addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_greenButton];
    
    _blue = [[UIColor alloc] initWithRed:0 green:116.0/255 blue:217.0/255 alpha:1.0];
    _blueButton = [[UIButton alloc] initWithFrame:CGRectMake(144, _square.frame.origin.y + 144, 32, 32)];
    _blueButton.backgroundColor = _blue;
    _blueButton.layer.cornerRadius = 3.0;
    [_blueButton addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_blueButton];
    
    _orange = [[UIColor alloc] initWithRed:1.0 green:133.0/255 blue:27.0/255 alpha:1.0];
    _orangeButton = [[UIButton alloc] initWithFrame:CGRectMake(196, _square.frame.origin.y + 144, 32, 32)];
    _orangeButton.backgroundColor = _orange;
    _orangeButton.layer.cornerRadius = 3.0;
    [_orangeButton addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_orangeButton];
    
    _grayButton = [[UIButton alloc] initWithFrame:CGRectMake(248, _square.frame.origin.y + 144, 32, 32)];
    _grayButton.backgroundColor = [UIColor darkGrayColor];
    _grayButton.layer.cornerRadius = 3.0;
    [_grayButton addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_grayButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeColor:(id)sender
{
    if (sender == _redButton)
        _square.color = _red;
    else if (sender == _greenButton)
        _square.color = _green;
    else if (sender == _blueButton)
        _square.color = _blue;
    else if (sender == _orangeButton)
        _square.color = _orange;
    else if (sender == _grayButton)
        _square.color = [UIColor darkGrayColor];
}

@end
