//
//  ListOfRecipesPresenter.swift
//  BrightskiesTest
//
//  Created by Maged Omar on 12/06/2021.
//

import Foundation
import Alamofire


protocol ListOfRecipesPresenterProtocol {
    func getListOfRecipes()
}

class ListOfRecipesPresenter: ListOfRecipesPresenterProtocol{
    
    //    MARK:- Properties
    private var view: ListOfRecipesViewProtocol?
    //    MARK:- init
    init(view:ListOfRecipesViewProtocol){
        self.view = view
    }
    //    MARK:- Method
    
    func getListOfRecipes() {
        let url = "https://api.npoint.io/43427003d33f1f6b51cc"
        self.view?.startIndcator()
        AF.request(url).responseDecodable(of: RecipesResponseModel.self) { response in
            if let items = response.value,response.error == nil  {
                self.view?.recipesData(items)
            }else{
                let errorMessage = response.error?.localizedDescription ?? ""
                self.view?.showError(message: errorMessage)
            }
            self.view?.stopIndcator()
        }
    }
}
