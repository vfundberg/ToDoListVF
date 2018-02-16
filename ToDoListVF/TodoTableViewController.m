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
    
    if(section == impSection){
        return @"Viktigt";
    }else if(section == todoSection){
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
    if (section == impSection){
        return [self.model importantAmount];
    }else if (section == todoSection){
        return [self.model todosAmount];
    }else{
        return [self.model doneAmount];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell" forIndexPath:indexPath];
    
    if(indexPath.section == impSection){
        cell.textLabel.text = self.model.important[indexPath.row];
        [cell setBackgroundColor:[UIColor grayColor]];
    }else if (indexPath.section == todoSection){
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
        [self.model deleteTaskFrom:(int)indexPath.section andIndex:(int)indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    NSMutableArray *moveFrom = [self.model getSection:(int)fromIndexPath.section];
    NSMutableArray *moveTo = [self.model getSection:(int)toIndexPath.section];
    NSString *textToMove = moveFrom[fromIndexPath.row];
    [moveFrom removeObjectAtIndex:fromIndexPath.row];
    [moveTo insertObject:textToMove atIndex:toIndexPath.row];
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
