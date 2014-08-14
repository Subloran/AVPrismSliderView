//
//  AVPrismSliderViewSampleVCViewController.m
//  AVPrismSliderViewSample
//
//  Created by Artem on 14/08/14.
//  Copyright (c) 2014 Artem. All rights reserved.
//

#import "AVPrismSliderViewSampleVC.h"

@interface AVPrismSliderViewSampleVC ()

@property (nonatomic, retain) IBOutlet UITableView* table;

@end

@implementation AVPrismSliderViewSampleVC

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
    _table.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDelegate

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"firstCell"];
                AVPrismSliderViewItem* leftItem = [[AVPrismSliderViewItem alloc] init];
                
                leftItem.itemLabelString = @"Лево";
                leftItem.itemFont = [UIFont fontWithName:@"AvenirNext-Medium" size:14];
                leftItem.regularColor = [UIColor colorWithRed:71.0/255.0 green:82.0/255.0 blue:89.0/255.0 alpha:1.0];
                leftItem.highlightedColor = [UIColor whiteColor];
                
                AVPrismSliderViewItem* centerItem = [[AVPrismSliderViewItem alloc] init];
                
                centerItem.itemLabelString = @"Центр";
                centerItem.itemFont = [UIFont fontWithName:@"AvenirNext-Medium" size:14];
                centerItem.regularColor = [UIColor colorWithRed:71.0/255.0 green:82.0/255.0 blue:89.0/255.0 alpha:1.0];
                centerItem.highlightedColor = [UIColor whiteColor];
                
                AVPrismSliderViewItem* rightItem = [[AVPrismSliderViewItem alloc] init];
                
                rightItem.itemLabelString = @"Право";
                rightItem.itemFont = [UIFont fontWithName:@"AvenirNext-Medium" size:14];
                rightItem.regularColor = [UIColor colorWithRed:71.0/255.0 green:82.0/255.0 blue:89.0/255.0 alpha:1.0];
                rightItem.highlightedColor = [UIColor whiteColor];
                
                AVPrismSliderView* sliderView = [AVPrismSliderView sliderViewWithItems:@[leftItem, centerItem, rightItem]];
                sliderView.delegate = self;
                sliderView.sliderBackgroundColor = [UIColor clearColor];
                sliderView.sliderFieldColor = [UIColor colorWithRed:229.0/255.0 green:231.0/255.0 blue:234.0/255.0 alpha:1.0];
                sliderView.sliderColor = [UIColor colorWithRed:0 green:160.0/255.0 blue:196.0/255.0 alpha:1.0];
                
                sliderView.tag = 1001;
                [sliderView setTranslatesAutoresizingMaskIntoConstraints:NO];
                [cell.contentView addSubview:sliderView];
                
                [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[sliderView]-5-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(sliderView)]];
                [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[sliderView]-5-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(sliderView)]];
                
            }
            return cell;
        }
        case 1:
        {
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell"];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"secondCell"];
                AVPrismSliderViewItem* item0 = [[AVPrismSliderViewItem alloc] init];
                
                item0.itemLabelString = @"0";
                item0.regularColor = [UIColor blueColor];
                item0.highlightedColor = [UIColor blackColor];
                
                AVPrismSliderViewItem* item1 = [[AVPrismSliderViewItem alloc] init];
                
                item1.itemLabelString = @"1";
                item1.regularColor = [UIColor whiteColor];
                item1.highlightedColor = [UIColor redColor];
                
                AVPrismSliderViewItem* item2 = [[AVPrismSliderViewItem alloc] init];
                
                item2.itemLabelString = @"2";
                item2.regularColor = [UIColor blueColor];
                item2.highlightedColor = [UIColor blackColor];
                
                AVPrismSliderViewItem* item3 = [[AVPrismSliderViewItem alloc] init];
                
                item3.itemLabelString = @"3";
                item3.regularColor = [UIColor whiteColor];
                item3.highlightedColor = [UIColor redColor];
                
                
                AVPrismSliderViewItem* item4 = [[AVPrismSliderViewItem alloc] init];
                
                item4.itemLabelString = @"4";
                item4.regularColor = [UIColor blueColor];
                item4.highlightedColor = [UIColor blackColor];
                
                
                AVPrismSliderViewItem* item5 = [[AVPrismSliderViewItem alloc] init];
                
                item5.itemLabelString = @"5";
                item5.regularColor = [UIColor whiteColor];
                item5.highlightedColor = [UIColor redColor];
                
                
                AVPrismSliderViewItem* item6 = [[AVPrismSliderViewItem alloc] init];
                
                item6.itemLabelString = @"6";
                item6.regularColor = [UIColor blueColor];
                item6.highlightedColor = [UIColor blackColor];
                
                
                AVPrismSliderViewItem* item7 = [[AVPrismSliderViewItem alloc] init];
                
                item7.itemLabelString = @"7";
                item7.regularColor = [UIColor whiteColor];
                item7.highlightedColor = [UIColor redColor];
                
                AVPrismSliderView* sliderView = [AVPrismSliderView sliderViewWithItems:@[item0, item1, item2, item3, item4, item5, item6, item7]];
                sliderView.delegate = self;
                sliderView.sliderBackgroundColor = [UIColor redColor];
                sliderView.sliderFieldColor = [UIColor greenColor];
                sliderView.sliderColor = [UIColor purpleColor];
                
                sliderView.tag = 20002;
                [sliderView setTranslatesAutoresizingMaskIntoConstraints:NO];
                [cell.contentView addSubview:sliderView];
                
                [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[sliderView]-5-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(sliderView)]];
                [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[sliderView]-5-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(sliderView)]];
            }
            return cell;
        }
        default:
            return nil;
    }
}

#pragma mark -
#pragma mark AVPrismSliderViewDelegate


- (void)selectionChanged:(NSInteger)selectedItem inSlider:(AVPrismSliderView*)sender
{
    NSLog(@"Slider with tag %d selected item# %d", sender.tag, selectedItem);
}

@end
