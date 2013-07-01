YFJLeftSwipeDeleteTableView
===========================

# Description

Drop-in UITableView subclass that supports left-swipe cell deletion like in iOS7. (works both in iOS6 and iOS7)

Just grab YFJLeftSwipeDeleteTableView.(h|m) and drop in your project. You have to specify following methods in the datasource methods as before.

```
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	// You can return BOOL value based on which cell you want to enable delete
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Operation to do when you delete cell.
    // e.g., delete item from datasource, call [UITableView deleteRowAtIndexPaths:withRowAnimation].
}

```

![Screenshot](https://s3.amazonaws.com/yfj_screenshots/YFJLeftSwipeDeleteTableView/Screenshot1.png "Screenshot")

It will give you left-swipe delete button like in iOS7 both for iOS6&7.


# License

The MIT License (MIT)

Copyright (c) 2013 Yuichi Fujiki

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.