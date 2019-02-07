//
//  SearchViewController.swift
//  GetGoingClass
//
//  Created by Diven Sambhwani on 1/16/19.
//  Copyright © 2019 SMU. All rights reserved.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchButton: UIButton!
    //Mark : - Properties
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func segmentedObserver(_ sender: UISegmentedControl) {
        
        print("segmented control option was changed to \(sender.selectedSegmentIndex)")
        if sender.selectedSegmentIndex == 1 {
            LocationService.shared.startUpdatingLocation()
            LocationService.shared.delegate = self
        }
    }
    @IBAction func loadLastSavedResults(_ sender: Any) {
        guard let places = loadPlacesFromLocalStorage() else {
            
            self.presentErrorAlert(message: "no result were previously stored")
            return
        }
        presentSearchResults(places: places)
        
    }
    @IBAction func presentFilters(_ sender: Any) {
        performSegue(withIdentifier: "FilterSegue", sender: self)
        //performSegue(withIdentifier: "FilterSegue", sender: self)
//        guard let filtersViewController = UIStoryboard(name: "Filters", bundle: nil).instantiateViewController(withIdentifier: "FilterViewController") as? FiltersViewController else { return }
//        present(filtersViewController, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var searchTextField: UITextField!
    
    var searchparameter: String?
    var currentLocation: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        searchTextField.delegate = self
        
    }
    
    func showActivityIndicator(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        searchButton.isEnabled = false
    }
    
    func hideActivityIndicator(){
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        searchButton.isEnabled = true
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        searchparameter = searchTextField.text
        guard let searchParameter = searchparameter else {
            print("query nil")
            return
        }
        
        searchTextField.resignFirstResponder()
        showActivityIndicator()
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            
            GooglePlacesAPI.requestPlaces(searchParameter){(status, json) in
                print(json ?? "")
                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                }
                
                guard let jsonObj = json else {return}
                let results = APIParser.parsePlacesResponse(jsonObj: jsonObj)
                self.savePlacesToLocalStorage(places: results)
                if results.isEmpty{
                    //     if let jsonObj = json {
                    //   } else {
                    // TODO: - Present an ale
                    DispatchQueue.main.async {
                        self.presentErrorAlert(message: "no results found")
                    }
                } else {
                    self.presentSearchResults(places: results)
                }
            }
        case 1:
            guard let location = currentLocation else { return }
            GooglePlacesAPI.requestPlacesNearby(for: location, radius: 10000.0, searchParameter) {
                (status, json) in
                print(json ?? "")
                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                }
                guard let jsonObj = json else {return}
                let results = APIParser.parsePlacesResponse(jsonObj: jsonObj)
                if results.isEmpty{
                    //     if let jsonObj = json {
                    //   } else {
                    // TODO: - Present an ale
                    DispatchQueue.main.async {
                        self.presentErrorAlert(message: "no results found")
                    }
                } else {
                    self.presentSearchResults(places: results)
                }
            }
        default:
            return
        }
        
    }
    func presentSearchResults(places: [PlaceDetails]){
        guard let searchResultViewController = UIStoryboard(name:"Main",bundle:nil).instantiateViewController(withIdentifier: "SearchResultViewController") as? SearchResultsViewController else
        {return}
        searchResultViewController.places = places
        DispatchQueue.main.async{
            self.navigationController?.pushViewController(searchResultViewController, animated: true)
        }
    }
    
    func presentErrorAlert(title: String = "Error", message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButtonAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButtonAction)
        present(alert, animated: true)
    }
    
    func savePlacesToLocalStorage(places: [PlaceDetails])
    {
        NSKeyedArchiver.archiveRootObject(places, toFile: Constants.ArchiveURL.path)
    }
    
    func loadPlacesFromLocalStorage() -> [PlaceDetails]?
    {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Constants.ArchiveURL.path) as? [PlaceDetails]
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField {
            searchTextField.resignFirstResponder()
            searchparameter = textField.text ?? ""
            print("text field should return")
            return true
        }
        return false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == searchTextField{
            searchparameter = textField.text ?? ""
        }
    }
}

extension SearchViewController: LocationServiceDelegate
{
    func didUpdateLocation(location: CLLocation) {
        print("latitude \( location.coordinate.latitude)longitude\(location.coordinate.longitude)")
        currentLocation = location.coordinate
        
    }
}
