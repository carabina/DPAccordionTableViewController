//
//  DPAccordionTableViewController.m
//  DPAccordionTableView
//
//  Created by Kostas Antonopoulos on 9/30/12.
//  Copyright (c) 2012 Kostas Antonopoulos. All rights reserved.
//

#import "DPAccordionTableViewController.h"

@interface DPAccordionTableViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger openSection;
    IBOutlet UITableView *tableView;
}

@end

@implementation DPAccordionTableViewController
@synthesize datasource;
@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    openSection=NSNotFound;


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView reloadData];
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.datasource numberOfSectionsInAccordionTableView:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==openSection) {
        return [self.datasource accordionTableView:self numberOfRowsInExpandedSection:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header;
    if (self.delegate && [self.delegate respondsToSelector:@selector(accordionTableView:headerViewForSection:)]) {
        header = [self.delegate accordionTableView:self headerViewForSection:section];
    }else{
        header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
        
        if ([self.datasource respondsToSelector:@selector(accordionTableView:titleForSection:)]) {
            [titleLabel setText:[self.datasource accordionTableView:self titleForSection:section]];
        }else{
            [titleLabel setText:[NSString stringWithFormat:@"Section %d",section]];
        }
        [header addSubview:titleLabel];
    }

    UITapGestureRecognizer *tapRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerTapped:)];
    [header addGestureRecognizer:tapRecognizer];

    header.tag=section;
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

#pragma mark - Header Actions

-(void)headerTapped:(UITapGestureRecognizer*)sender{
    if (openSection!=sender.view.tag) { //einai kleisto
        [self openSection:sender.view.tag];
        openSection=sender.view.tag;
    }else{
        [self closeSection:sender.view.tag];
        openSection=NSNotFound;
    }
    
}

#pragma mark - Open/Close TableView

-(void)openSection:(NSInteger)section{
    
}

-(void)closeSection:(NSInteger)section{
    
}

@end
