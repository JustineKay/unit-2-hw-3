//
//  ListCreationTableViewController.m
//  MarsWater
//
//  Created by Justine Gartner on 10/4/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ListCreationTableViewController.h"
#import "List.h"
#import "AppDelegate.h"

@interface ListCreationTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@property (nonatomic)List *list;

@property (nonatomic)BOOL colorButtonSelected;

@end

@implementation ListCreationTableViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.colorButtonSelected = NO;
    
    [self setupNavigationBar];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:delegate.managedObjectContext];
    
}

-(void)setupNavigationBar{
    
    self.navigationItem.title = @"Create New List";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:224.0/255.0 green:35.0/255.0 blue:70.0/255.0 alpha:1.0];
}

-(void)cancel{
    
    [self removeObjectFromNSManagedObjectContext:self.list];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)save{
    
    if ([self.titleTextField.text isEqualToString:@""]) {
        
        [self emptyTextFieldAlertController];
        
    }else if (self.colorButtonSelected == NO) {
        
        [self colorButtonAlertController];
        
    }else {
        
        self.list.title = self.titleTextField.text;
        self.list.createdAt = [NSDate date];
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate.managedObjectContext save:nil];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        NSLog(@"%@", self.list);
    }
    
}


- (IBAction)colorButtonTapped:(UIButton *)sender {
    
    self.colorButtonSelected = YES;
    
    self.list.color = sender.backgroundColor;
}

#pragma mark - alertController

-(void)colorButtonAlertController{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oops"
                                                                   message:@"Please select a color."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)emptyTextFieldAlertController{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oops"
                                                                   message:@"Please fill in the list title."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - NSManagedObjectContext

-(void)removeObjectFromNSManagedObjectContext:(List *)list {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    [context deleteObject:list];
    [context processPendingChanges];
    
}


@end
