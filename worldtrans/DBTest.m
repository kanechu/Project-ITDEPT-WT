

#import "DBTest.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"

static DBTest *sharedInstance = nil;
static FMDatabase *database = nil;
static sqlite3_stmt *statement = nil;
#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }


@implementation DBTest

+(DBTest*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

-(BOOL)createDB{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath¡G ?Õu?¸ô?¡A¦bDocument¤¤¡C
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"Test.db"];
    
    BOOL isSuccess = YES;
    FMDatabase *database= [FMDatabase databaseWithPath:dbPath] ;
    if (![database open]) {
        isSuccess = NO;
        NSLog(@"Failed to open/create database");
    } else {
        
        NSString *sql_stmt =
        @"create table if not exists studentsDetail (regno integer primary key, name text, department text, year text)";
        
        [database executeUpdate:sql_stmt];
        [database close];
        return  isSuccess;
    }
    return isSuccess;
}

- (BOOL) saveData:(NSString*)registerNumber name:(NSString*)name
       department:(NSString*)department year:(NSString*)year;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath¡G ?Õu?¸ô?¡A¦bDocument¤¤¡C
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"Test.db"];
    
    BOOL isSuccess = YES;
    FMDatabase *database= [FMDatabase databaseWithPath:dbPath] ;
    if (![database open]) {
        isSuccess = NO;
        NSLog(@"Failed to open/create database");
    } else {
        
        NSString *insertSQL = [NSString stringWithFormat:@"insert into studentsDetail (name, department, year) values (\"%@\", \"%@\", \"%@\")", name, department, year];
        [database executeUpdate:insertSQL];
        [database close];
        return  YES;
    }
    return NO;
}

- (NSMutableArray*) getData;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath¡G ?Õu?¸ô?¡A¦bDocument¤¤¡C
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"Test.db"];
    FMDatabase *database= [FMDatabase databaseWithPath:dbPath] ;
    NSMutableArray *results = [NSMutableArray array];
    
    if (![database open]) {
        NSLog(@"Failed to open/create database");
    } else {
        
        FMResultSet *rs = [database executeQuery:@"select * from studentsDetail"];
        
        while ([rs next]) {
            [results addObject:[rs resultDictionary]];
        }
        
        [rs close];

    }

    return results;
    // close the result set.
    // it'll also close when it's dealloc'd, but we're closing the database before
    // the autorelease pool closes, so sqlite will complain about it.    return results;
}


@end
