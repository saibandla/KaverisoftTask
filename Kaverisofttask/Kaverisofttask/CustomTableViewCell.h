//
//  CustomTableViewCell.h
//  Kaverisofttask
//
//  Created by Sesha Sai Bhargav Bandla on 03/02/15.
//  Copyright (c) 2015 nivansys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bookTitlteLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookpriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookDescriptionLabel;



@property (weak, nonatomic) IBOutlet UIImageView *modelthumbnailImage;
@property (weak, nonatomic) IBOutlet UILabel *modelNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *modelPriceLabel;


@property (weak, nonatomic) IBOutlet UILabel *musicTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *musicAlbumNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *musicArtistNameLabel;

@end
