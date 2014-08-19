//
//  DIImageView.m
//  DIImageView
//
//  Created by Daniel Inoa Llenas on 8/18/14.
//  Copyright (c) 2014 Daniel Inoa Llenas. All rights reserved.
//

#import "DIImageView.h"

@implementation DIImageView

@synthesize caption;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initCaption];

        // Tap Gesture for ImageView
        UITapGestureRecognizer *imageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped)];
        imageViewTap.delegate = self;
        [self addGestureRecognizer:imageViewTap];
        [self setUserInteractionEnabled:YES];
        
        // Drag Gesture for Caption
        UIPanGestureRecognizer *drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(captionDrag:)];
        [self addGestureRecognizer:drag];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    // Caption
    [self initCaption];
}

- (void) initCaption{
    
    // Caption
    caption = [[UITextField alloc] initWithFrame:CGRectMake(0,
                                                            self.frame.size.height/2,
                                                            self.frame.size.width,
                                                            32)];
    caption.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    caption.textAlignment = NSTextAlignmentCenter;
    caption.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    caption.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    caption.textColor = [UIColor whiteColor];
    caption.keyboardAppearance = UIKeyboardAppearanceDark;
    caption.alpha = 0;
    caption.tintColor = [UIColor whiteColor];
    caption.delegate = self;
    [self addSubview:caption];
}

- (void) imageViewTapped{
    
    caption.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    caption.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    if([caption isFirstResponder]){
        [caption resignFirstResponder];
        caption.alpha = ([caption.text isEqualToString:@""]) ? 0 : caption.alpha;
    } else {
        [caption becomeFirstResponder];
        caption.alpha = 1;
    }
}

- (void) captionDrag: (UIGestureRecognizer*)gestureRecognizer{
    
    CGPoint translation = [gestureRecognizer locationInView:self];

    if(translation.y < caption.frame.size.height/2){
        caption.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,  caption.frame.size.height/2);
    } else if(self.frame.size.height < translation.y + caption.frame.size.height/2){
        caption.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,  self.frame.size.height - caption.frame.size.height/2);
    } else {
        caption.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,  translation.y);
    }
    
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    
    NSString *text = textField.text;
    text = [text stringByReplacingCharactersInRange:range withString:string];
    CGSize textSize = [text sizeWithAttributes: @{NSFontAttributeName:textField.font}];
    return (textSize.width + 10 < textField.bounds.size.width) ? true : false;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [caption resignFirstResponder];
    return true;
}

@end
