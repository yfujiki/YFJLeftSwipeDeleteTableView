YFJLeftSwipeDeleteTableView
===========================

Drop-in UITableView subclass that supports left-swipe cell deletion like in iOS7. (works both in iOS6 and iOS7)

Just grab YFJLeftSwipeDeleteTableView.(h|m) and drop in your project. You have to specify following methods in the datasource methods, but that is it.

```
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Since you do not want stock delete button to appear, return NO here.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Operation to do when you delete cell.
    // e.g., delete item from datasource, call [UITableView deleteRowAtIndexPaths:withRowAnimation].
}

```

It will give you left-swipe delete button like in iOS7 both for iOS6&7.
