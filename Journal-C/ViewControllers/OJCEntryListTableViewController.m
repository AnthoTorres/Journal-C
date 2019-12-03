//
//  EntryListTableViewController.m
//  Journal-C
//
//  Created by Anthony Torres on 12/2/19.
//  Copyright © 2019 Anthony Torres. All rights reserved.
//

#import "OJCEntryListTableViewController.h"
#import "OJCEntryController.h"
#import "OJCEntryDetailViewController.h"


@interface OJCEntryListTableViewController ()

@end

@implementation OJCEntryListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [OJCEntryController shared].Entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"entryCell" forIndexPath:indexPath];
    
        OJCEntry *entry = [OJCEntryController shared].Entries[indexPath.row];
        cell.textLabel.text = entry.title;
        
        NSDateFormatter *df = [NSDateFormatter new];
        df.dateFormat = @"MM/d h:mm a";
        cell.detailTextLabel.text = [df stringFromDate:entry.timeStamp];
        
        return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        OJCEntry *entry = [OJCEntryController shared].Entries[indexPath.row];
        [[OJCEntryController shared] removeEntry:entry];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqual:@"cellToDetailVC"]) {
        OJCEntryDetailViewController *destinationVC = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        OJCEntry *entry = [OJCEntryController shared].Entries[indexPath.row];
        [destinationVC updateWith:entry];
    }
}

@end
