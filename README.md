RZSquaresLoading
==============
iOS loading animation with squares.  
  
![image](https://raw.github.com/robinzhangx/RZSquaresLoading/master/SquaresLoading.gif)

Usage
==============
Instantiate ```RZSquaresLoading```(change the frame size and position to suit your need) and add to your view hierarchy.
```
RZSquaresLoading *squareLoading = [[RZSquaresLoading alloc] initWithFrame:CGRectMake((0, 0, 36, 36)];
[self.view addSubview:squareLoading];
```

Change color:
```
squareLoading.color = [UIColor redColor];
```

Install
==============
Install using CocoaPods:
```
pod 'RZSquaresLoading'
```

License
==============
```RZSquaresLoading``` is available under the MIT license. See the LICENSE file for more info.
