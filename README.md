YFJLeftSwipeDeleteTableView
===========================

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
