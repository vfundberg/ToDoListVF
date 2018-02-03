//
//  TodoTableViewController.m
//  ToDoListVF
//
//  Created by Victor Fundberg on 2018-02-03.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

#import "TodoTableViewController.h"
#import "AddViewController.h"
#import "Model.h"


@interface TodoTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addNote;
@property (nonatomic) Model *model;

@end

@implementation TodoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[Model alloc]init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        return @"Viktigt";
    }else if(section == 1){
        return @"Att göra";
    }else{
        return @"Klara";
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0){
        return [self.model importantAmount];
    }else if (section == 1){
        return [self.model todosAmount];
    }else{
        return [self.model doneAmount];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    if(indexPath.section == 0){
        cell.textLabel.text = self.model.important[indexPath.row];
        [cell setBackgroundColor:[UIColor grayColor]];
    }else if (indexPath.section == 1){
        cell.textLabel.text = self.model.todos[indexPath.row];
        [cell setBackgroundColor:[UIColor whiteColor]];
    }else{
        cell.textLabel.text = self.model.donetodos[indexPath.row];
        [cell setBackgroundColor:[UIColor greenColor]];
    }
    
    return cell;
}

- (IBAction)editButton:(id)sender {
    if ([self isEditing]) {
        [self setEditing:NO animated:YES];
        [self.model saveTables];
        [self.tableView reloadData];
    }else{
        [self setEditing:YES animated:YES];
    }
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 0) {
            [self.model deleteImportant:(int)indexPath.row];
        }else if (indexPath.section == 1){
            [self.model deleteNote:(int)indexPath.row];
        }else{
            [self.model deleteDone:(int)indexPath.row];
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    NSMutableArray *moveTextFrom;
    NSMutableArray *moveTextTo;
    
    if (fromIndexPath.section == 0) {
        moveTextFrom = self.model.important;
    }else if (fromIndexPath.section == 1){
        moveTextFrom = self.model.todos;
    }else if(fromIndexPath.section == 2){
        moveTextFrom = self.model.donetodos;
    }
    
    if (toIndexPath.section == 0) {
        moveTextTo = self.model.important;
    }else if (toIndexPath.section == 1){
        moveTextTo = self.model.todos;
    }else if (toIndexPath.section == 2){
        moveTextTo = self.model.donetodos;
    }
    
    NSString *stringToMove = moveTextFrom[fromIndexPath.row];

    [moveTextFrom removeObjectAtIndex:fromIndexPath.row];
    [moveTextTo insertObject:stringToMove atIndex:toIndexPath.row];
    
    [self.model saveTables];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    AddViewController *add = [segue destinationViewController];
    add.model = self.model;
    
}


@end
