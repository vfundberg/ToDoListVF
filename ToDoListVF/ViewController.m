//
//  ViewController.m
//  ToDoListVF
//
//  Created by Victor Fundberg on 2018-02-01.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>
@property (nonatomic) NSMutableArray *todos;
@property (nonatomic) NSArray *categories;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.todos = @[@{@"name" : @"Städa", @"category" : @"Normal"}, @{@"name" : @"Handla", @"category" : @"Normal"}].mutableCopy;
    self.categories = @[@"Normal", @"Viktig"];
    
}
- (IBAction)addNewItem:(id)sender {
    UIAlertController *alertTodo = [UIAlertController alertControllerWithTitle:@"To Do" message:@"Skriv in en ny To-Do" preferredStyle:UIAlertControllerStyleAlert];
    [alertTodo addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Ny To-Do";
        textField.secureTextEntry = NO;
    }];
    UIAlertAction *addToDo = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *alertTextField =[alertTodo.textFields objectAtIndex:0];
        NSString *newTodo = alertTextField.text;
        NSDictionary *todo = @{@"name" : newTodo, @"category" : @"Home"};
        [self.todos addObject:todo];
        NSInteger numNormalItems = [self numberOfItemsInCategory:@"Normal"];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:numNormalItems -1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    [alertTodo addAction:addToDo];
    UIAlertAction *cancelToDo = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) { }];
    [alertTodo addAction:cancelToDo];
    [self presentViewController:alertTodo animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Hjälpmetoder för kategorier och nersparning av To-Dos

-(NSArray *) itemsInCategory:(NSString *) targetCategory{
    NSPredicate *matchingPredicate = [NSPredicate predicateWithFormat:@"category == %@",targetCategory];
    NSArray *categoryItems = [self.todos filteredArrayUsingPredicate:matchingPredicate];
    return categoryItems;
}

-(NSInteger) numberOfItemsInCategory:(NSString *)targetCategory{
    return [self itemsInCategory:targetCategory].count;
}
-(NSDictionary *)itemAtIndexPath:(NSIndexPath * )indexPath{
    NSString * category = self.categories[indexPath.section];
    NSArray *categoryItems = [self itemsInCategory:category];
    NSDictionary *item = categoryItems[indexPath.row];
    return item;
}

-(NSInteger) itemIndexForIndexPath:(NSIndexPath *) indexPath{
    NSDictionary *item = [self itemAtIndexPath:indexPath];
    NSInteger index = [self.todos indexOfObjectIdenticalTo:item];
    return index;
}

-(void)removeItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = [self itemIndexForIndexPath:indexPath];
    [self.todos removeObjectAtIndex:index];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.categories.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self numberOfItemsInCategory:self.categories[section]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ToDoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *item = [self itemAtIndexPath:indexPath];
    cell.textLabel.text= item[@"name"];
    if ([item[@"completed"]boolValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = [self itemIndexForIndexPath:indexPath];
    NSMutableDictionary *item = [self.todos[indexPath.row]mutableCopy];
    BOOL completed = [item[@"completed"]boolValue];
    item[@"completed"] = @(!completed);
    
    self.todos[index] = item;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = ([item[@"completed"]boolValue]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.categories[section];
}
-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        [self removeItemAtIndexPath:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewCellEditingStyleDelete];
    }
    
}




@end
