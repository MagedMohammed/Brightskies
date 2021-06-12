//
//  RecipesTableViewCell.swift
//  BrightskiesTest
//
//  Created by Maged Omar on 12/06/2021.
//

import UIKit
import PINRemoteImage

class RecipesTableViewCell: UITableViewCell {
    
    //    MARK:- Outlet
    @IBOutlet weak var recipesImage: UIImageView!{
        didSet{
            recipesImage.layer.cornerRadius = 12
            recipesImage.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var recipesTitleLabel: UILabel!
    @IBOutlet weak var recipesTimeLabel: UILabel!
    @IBOutlet weak var recipeCalLabel: UILabel!
    @IBOutlet weak var recipesRateLabel: UILabel!
    @IBOutlet weak var recipesFavLabel: UILabel!
    
    //    MARK:- Properties
    var share:(()->())?
    
    //    MARK:- ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //    MARK:- Method
    func setCell(data:RecipesResponseModelElement){
        let imageURL = URL(string:data.image ?? "")
        self.recipesImage.pin_setImage(from: imageURL)
        self.recipesTitleLabel.text = data.name
        self.recipeCalLabel.text = "\(data.calories ?? "") Cal"
        self.recipesTimeLabel.text = data.time ?? ""
        self.recipesRateLabel.text = String(data.ratings ?? 0)
        self.recipesFavLabel.text = String(data.favorites ?? 0)
    }
    
    //    MARK:- Action
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        self.share?()
    }
}
