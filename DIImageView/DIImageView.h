//
//  DIImageView.h
//  DIImageView
//
//  Created by Daniel Inoa Llenas on 8/18/14.
//  Copyright (c) 2014 Daniel Inoa Llenas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DIImageView : UIImageView <UITextFieldDelegate, UIGestureRecognizerDelegate>

@property UITextField *caption;

@end
