//
//  ListOfRecipesViewController.swift
//  BrightskiesTest
//
//  Created by Maged Omar on 12/06/2021.
//

import UIKit
import NVActivityIndicatorView


protocol ListOfRecipesViewProtocol{
    func recipesData(_ data: [RecipesResponseModelElement])
    func startIndcator()
    func stopIndcator()
    func showError(message:String)
}

class ListOfRecipesViewController: UIViewController, NVActivityIndicatorViewable {
    
    //    MARK:- Outlet
    @IBOutlet private var recipesTableView: UITableView!
    
    //    MARK:- Properties
    private var recipesData = [RecipesResponseModelElement]()
    private var presenter : ListOfRecipesPresenterProtocol!
    //    MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List Of Recipes"
        self.setColorOfNav()
        self.presenter = ListOfRecipesPresenter(view: self)
        self.recipesTableView.delegate = self
        self.recipesTableView.dataSource = self
        self.recipesTableView.register(UINib(nibName: "RecipesTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipesTableViewCell")
        self.presenter.getListOfRecipes()
        
    }
    
    //    MARK:- Method
    
    //    MARK:- Action
    
    //    MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeDetails" {
            if let destination = segue.destination as? DetailOfARecipeViewController {
                if let recipeDetails = sender as?  RecipesResponseModelElement {
                    destination.recipeDetails = recipeDetails
                }
            }
        }
    }
}

extension ListOfRecipesViewController: ListOfRecipesViewProtocol,ErrorFeedBack{
    
    func startIndcator() {
        self.startAnimating()
    }
    
    func recipesData(_ data: [RecipesResponseModelElement]) {
        self.recipesData = data
        self.recipesTableView.reloadData()
    }
    
    func stopIndcator() {
        if self.isAnimating{
            self.stopAnimating()
        }
    }
    
    func showError(message: String) {
        self.showErrorAlert(title: "Error", msg: message)
    }
}



// Cell Name: RecipesTableViewCell
extension ListOfRecipesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RecipesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RecipesTableViewCell", for: indexPath) as! RecipesTableViewCell
        let data = self.recipesData[indexPath.row]
        cell.setCell(data: data)
        cell.selectionStyle = .none
        cell.share = { [weak self] in
            guard let self = self else{return}
            // text to share
            let text = """
                \(data.name ?? "")/n
                \(data.recipesResponseModelDescription ?? "")
                """
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
            self.present(activityViewController, animated: true, completion: nil)
        }
        return cell
    }
    // did Select Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.recipesData[indexPath.row]
        self.performSegue(withIdentifier: "recipeDetails", sender: data)
    }
}
