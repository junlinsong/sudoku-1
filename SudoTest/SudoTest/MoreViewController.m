//
//  MoreViewController.m
//  SudoTest
//
//  Created by 可可 王 on 12-5-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoreViewController.h"


@interface MoreViewController ()

@end

@implementation MoreViewController
@synthesize listData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *array = [[NSArray alloc]initWithObjects:@"帮助",@"分享到微博",@"给Sudoku打分",@"联系我们",@"关于我们",nil];
    self.listData = array;
    [array release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.listData = nil;
}
-(void)dealloc
{
    [listData release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    self.navigationItem.title = @"更多";
	[self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - TableView DataSource Methods

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [listData count];   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier]autorelease];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [listData objectAtIndex:row];
    return cell;
}
#pragma mark - TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row]) 
    {
        case 3://send email to me
        {
            if (![MFMailComposeViewController canSendMail])
            {
                break;
            }
            MFMailComposeViewController *mailcontroller = [[MFMailComposeViewController alloc] init];
            
            mailcontroller.mailComposeDelegate = self;            
            NSArray *addArray = [[NSArray alloc]initWithObjects:@"cokecoffe@gmail.com",nil];
            [mailcontroller setToRecipients:addArray];
            [mailcontroller setSubject:@"数独酷"];
            [mailcontroller setMessageBody:@"在此填写您的建议或者软件的问题" isHTML:NO];
            
            [self presentModalViewController:mailcontroller animated:YES];
           
            [mailcontroller release];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - MailDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
}

@end
