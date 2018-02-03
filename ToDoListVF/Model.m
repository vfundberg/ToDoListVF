//
//  Model.m
//  ToDoListVF
//
//  Created by Victor Fundberg on 2018-02-03.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

#import "Model.h"

@implementation Model

-(instancetype)init{
    self = [super init];
    if(self){
        self.todos = [[[NSUserDefaults standardUserDefaults] objectForKey:@"todos"]mutableCopy];
        self.important = [[[NSUserDefaults standardUserDefaults] objectForKey:@"important"]mutableCopy];
        self.donetodos = [[[NSUserDefaults standardUserDefaults] objectForKey:@"done"]mutableCopy];
        
        if (self.todos == nil) {
            self.todos = [[NSMutableArray alloc] init];
        }
        if (self.important == nil) {
            self.important = [[NSMutableArray alloc]init];
        }
        if (self.donetodos == nil) {
            self.donetodos = [[NSMutableArray alloc]init];
        }
    }
    return self;
}

-(void)addNote:(NSString *)note{
    [self.todos addObject:note];
    [[NSUserDefaults standardUserDefaults] setObject:self.todos forKey:@"todos"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(void)addImportantNote:(NSString *)note{
    [self.important addObject:note];
    [[NSUserDefaults standardUserDefaults]setObject:self.important forKey:@"important"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(void)deleteNote:(NSInteger)index{
    [self.todos removeObjectAtIndex:(int)index];
    [[NSUserDefaults standardUserDefaults]setObject:self.todos forKey:@"todos"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(void)deleteImportant:(int)index{
    [self.todos removeObjectAtIndex:(int)index];
    [[NSUserDefaults standardUserDefaults]setObject:self.important forKey:@"important"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(void)deleteDone:(int)index{
    [self.donetodos removeObjectAtIndex:(int)index];
    [[NSUserDefaults standardUserDefaults]setObject:self.donetodos forKey:@"done"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(void)saveTables{
    [[NSUserDefaults standardUserDefaults]setObject:self.todos forKey:@"todos"];
    [[NSUserDefaults standardUserDefaults]setObject:self.important forKey:@"important"];
    [[NSUserDefaults standardUserDefaults]setObject:self.donetodos forKey:@"done"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(NSUInteger)todosAmount{
    return self.todos.count;
}
-(NSUInteger)importantAmount{
    return self.important.count;
}
-(NSUInteger)doneAmount{
    return self.donetodos.count;
}

@end
