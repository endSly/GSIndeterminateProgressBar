//
//  GSMasterViewController.m
//  Example
//
//  Created by Endika Gutiérrez Salas on 27/05/14.
//  Copyright (c) 2014 Endika Gutiérrez Salas. All rights reserved.
//

#import "GSMasterViewController.h"

#import "GSIndeterminateProgressView.h"

@interface GSMasterViewController () {
    NSMutableArray *_objects;
    
    GSIndeterminateProgressView *_progressView;
}
@end

@implementation GSMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    GSIndeterminateProgressView *progressView = [[GSIndeterminateProgressView alloc] initWithFrame:CGRectMake(0, navigationBar.frame.size.height - 2,
                                                                                                              navigationBar.frame.size.width, 2)];
    progressView.progressTintColor = navigationBar.barTintColor;
    progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [navigationBar addSubview:progressView];
    
    [progressView startAnimating];
    _progressView = progressView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAnimationgAction:(id)sender
{
    [_progressView startAnimating];
}

- (IBAction)stopAnimationgAction:(id)sender
{
    [_progressView stopAnimating];
}

@end
