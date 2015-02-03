//
//  ProductListTableViewController.m
//  Kaverisofttask
//
//  Created by Sesha Sai Bhargav Bandla on 03/02/15.
//  Copyright (c) 2015 nivansys. All rights reserved.
//

#import "ProductListTableViewController.h"
#import "CustomTableViewCell.h"
#define KBQues dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
@interface ProductListTableViewController ()
@property(nonatomic,strong)NSMutableArray *bookDataArray;
@property(nonatomic,strong)NSMutableArray *modelDataArray;
@property(nonatomic,strong)NSMutableArray *musicDataArray;
@end

@implementation ProductListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(KBQues, ^{
        NSString *urlString=@"http://www.kaverisoft.com/careers/assignments/iphone/a1.php";
        urlString=[urlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        [self performSelectorOnMainThread:@selector(loadTabelViewdata:) withObject:data waitUntilDone:YES];
    });
    
}
-(void)loadTabelViewdata:(NSData *)responseData
{
    NSError *error;
    NSArray *responseArray=[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSLog(@"%@",responseArray);
    if(responseArray.count>0)
    {
        for(NSDictionary *dic in responseArray)
        {
            if([[dic allKeys]containsObject:@"book"])
            {
                NSDictionary *dataDic=[dic objectForKey:@"book"];
                [self.bookDataArray addObject:dataDic];
            }
            if([[dic allKeys]containsObject:@"camera"])
            {
                NSDictionary *dataDic=[dic objectForKey:@"camera"];
                [self.modelDataArray addObject:dataDic];
            }
            if([[dic allKeys]containsObject:@"music"])
            {
                NSDictionary *dataDic=[dic objectForKey:@"music"];
                [self.musicDataArray addObject:dataDic];
            }
            
        }
        
       [self.tableView reloadData];
    }
}
-(NSMutableArray *)bookDataArray
{
    
    if(!_bookDataArray)
    {
        _bookDataArray=[[NSMutableArray alloc]init];
    }
    return _bookDataArray;
}
-(NSMutableArray *)modelDataArray
{
    if(!_modelDataArray)
    {
        _modelDataArray=[[NSMutableArray alloc]init];
    }
    return _modelDataArray;
}
-(NSMutableArray *)musicDataArray
{
    if(!_musicDataArray)
    {
        _musicDataArray=[[NSMutableArray alloc]init];
    }
    return _musicDataArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Books";
        case 1:
            return @"Photos";
        case 2:
            return @"Music";
        default:
            return @"";
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return self.bookDataArray.count;
        case 1:
            return self.modelDataArray.count;
        case 2:
            return self.musicDataArray.count;
        default:
            return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 132;
         case 1:
            return 121;
            case 2:
            return 117;
        default:
            return 44;
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *bookReusableIdentifier=@"bookCell";
    NSString *cameraReusableIdentifier=@"cameraCell";
    NSString *musicReusableIdentifier=@"musicCell";
    CustomTableViewCell *cell;
    
    switch (indexPath.section) {
        case 0:{
            cell = [tableView dequeueReusableCellWithIdentifier:bookReusableIdentifier forIndexPath:indexPath];
            NSDictionary *bookDictionary=[self.bookDataArray objectAtIndex:indexPath.row];
            cell.bookTitlteLabel.text=[bookDictionary objectForKey:@"title"];
            cell.bookAuthorNameLabel.text=[bookDictionary objectForKey:@"authors"];
            cell.bookpriceLabel.text=[NSString stringWithFormat:@"₨ %@",[bookDictionary objectForKey:@"price"]];
            NSString *desc=[bookDictionary objectForKey:@"description"];
           NSMutableArray *arr=[[NSMutableArray alloc]initWithArray: [desc componentsSeparatedByString:@" "]];
            while (1) {
                [arr removeLastObject];
                if(arr.count==10)
                {
                    break;
                }
            }
           
            cell.bookDescriptionLabel.text=[arr componentsJoinedByString:@" "];
        }
            break;
        case 1:
        {
            cell=[tableView dequeueReusableCellWithIdentifier:cameraReusableIdentifier forIndexPath:indexPath];
            NSDictionary *camraDictionary=[self.modelDataArray objectAtIndex:indexPath.row];
            NSString *thumbUrl=[camraDictionary objectForKey:@"picture"];
            thumbUrl=[thumbUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if([UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:thumbUrl]]]!=nil)
                {
            cell.modelthumbnailImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:thumbUrl]]];
                }
            cell.modelNameLabel.text=[camraDictionary objectForKey:@"model"];
            cell.modelPriceLabel.text=[NSString stringWithFormat:@"₨ %@",[camraDictionary objectForKey:@"price"]];
        }
            
            break;
        case 2:
        {
             cell=[tableView dequeueReusableCellWithIdentifier:musicReusableIdentifier forIndexPath:indexPath];
            NSDictionary *musicDictionary=[self.musicDataArray objectAtIndex:indexPath.row];
            
            cell.musicTitleLabel.text=[musicDictionary objectForKey:@"title"];
            cell.musicArtistNameLabel.text=[musicDictionary objectForKey:@"artist"];
            cell.musicAlbumNameLabel.text=[musicDictionary objectForKey:@"album"];
        }
            break;
            
    }
    
    
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
