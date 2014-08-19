DIImageView
===========

A Snachat-like caption integrated within a regular UIImageView.

![image](https://github.com/danielinoa/DIImageView/blob/master/Screenshots/ss1.png)
![image](https://github.com/danielinoa/DIImageView/blob/master/Screenshots/ss2.png)

Installation
------------

Simply add DIImageView.h/m into your project.

Usage
-----
```objective-c
// Example
DIImageView *imageView = [[DIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
[imageView setImage: [UIImage imageNamed:@"alley.jpg"]];
[self.view addSubview:imageView];
```

## Requirements

* iOS 7.0+ and XCode 5.1+

Author
------

Daniel Inoa, www.danielinoa.com

## License

DIImageView is available under the MIT license. See the LICENSE file for more info.
