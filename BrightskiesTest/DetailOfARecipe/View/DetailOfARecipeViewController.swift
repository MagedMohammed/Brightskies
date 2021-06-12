//
//  DetailOfARecipeViewController.swift
//  BrightskiesTest
//
//  Created by Maged Omar on 12/06/2021.
//

import UIKit

class DetailOfARecipeViewController: UIViewController {

    //    MARK:- Outlet
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeRateLabel: UILabel!
    @IBOutlet weak var recipeTimeLabel: UILabel!
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    @IBOutlet weak var recipeDifficultyLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    
    //    MARK:- Properties
    var recipeDetails = RecipesResponseModelElement()
    //    MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ingredientsTableView.delegate = self
        self.ingredientsTableView.dataSource = self
        self.setColorOfNav()
        self.setview(data: self.recipeDetails)
    }
    
    //    MARK:- Method
    func setview(data:RecipesResponseModelElement){
        let imageURL = URL(string:data.image ?? "")
        self.recipeImage.pin_setImage(from: imageURL)
        self.recipeTitleLabel.text = data.name
        self.recipeTimeLabel.text = data.time ?? ""
        self.recipeRateLabel.text = String(data.ratings ?? 0)
        self.recipeIngredientsLabel.text = "\(data.ingredients?.count ?? 0) Ingredients"
        self.descriptionLabel.text = data.recipesResponseModelDescription ?? ""
    }

}
extension DetailOfARecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDetails.ingredients?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let data = recipeDetails.ingredients ?? [String]()
        cell.selectionStyle = .none
        cell.textLabel?.text = "* \(data[indexPath.row])"
        return cell
    }
}
