//
//  ViewController.m
//  DIImageView
//
//  Created by Daniel Inoa Llenas on 8/18/14.
//  Copyright (c) 2014 Daniel Inoa Llenas. All rights reserved.
//

#import "ViewController.h"
#import "DIImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];

    DIImageView *imageView = [[DIImageView alloc] initWithFrame:
                              CGRectMake(0, 0, 320, 320)];
    [imageView setImage: [UIImage imageNamed:@"alley.jpg"]];
    [self.view addSubview:imageView];
    
    
    // Tap Image Label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                      imageView.frame.origin.y + imageView.frame.size.height,
                                                      [UIScreen mainScreen].bounds.size.width,
                                                      40)];
    label.backgroundColor = [UIColor blackColor];
    label.text = @"Tap Image";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
