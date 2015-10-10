//
//  TaskCreationTableViewController.h
//  MarsWater
//
//  Created by Justine Gartner on 10/5/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "List.h"

@interface TaskCreationTableViewController : UITableViewController

@property (nonatomic) List *list;
@property (nonatomic) Task *selectedTask;
@property (nonatomic) NSInteger selectedTaskIndexPathRow;

@end
