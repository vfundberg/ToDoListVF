//
//  Model.h
//  ToDoListVF
//
//  Created by Victor Fundberg on 2018-02-03.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int impSection = 0;
static const int todoSection = 1;
static const int doneSection = 2;

@interface Model : NSObject

@property (nonatomic) NSMutableArray *todos;
@property (nonatomic) NSMutableArray *donetodos;
@property (nonatomic) NSMutableArray *important;
@property (nonatomic) NSString *note;

-(void) addNote:(NSString *)note;
-(void)deleteNote:(int)index;
-(void)saveTables;
-(void)addImportantNote:(NSString*)note;

-(NSUInteger)todosAmount;
-(NSUInteger)doneAmount;
-(NSUInteger)importantAmount;

-(void)deleteImportant:(int)index;
-(void)deleteDone:(int)index;
-(NSMutableArray*)getSection:(int)section;
-(void)deleteTaskFrom:(int)section andIndex:(int)index;
@end
