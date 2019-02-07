//
//  SearchResultsViewController.swift
//  GetGoingClass
//
//  Created by Diven Sambhwani on 1/23/19.
//  Copyright © 2019 SMU. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {
    //Mark:- Outlets
    
    @IBOutlet weak var tableView: UITableView!
    //Mark: - properties
    var places = [PlaceDetails]()
    
    //Mark: -ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }

 
    @IBAction func sortAction(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            places.sort(by: {$1.name ?? "" > $0.name ?? ""})
        }
        if sender.selectedSegmentIndex == 1 {
            places.sort(by: {$0.rating ?? 0 > $1.rating ?? 0})
        }
        tableView.reloadData()
        
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
extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as? SearchResultTableViewCell else {return UITableViewCell()}
        let place = places[indexPath.row]
        cell.nameLabel.text = place.name
        // cell.vicinityLabel.text = place.vicinity
        cell.vicinityLabel.text=place.address
        if let placeRating = place.rating {
                cell.rating.rating = Int(placeRating.rounded(.down))
        }
        
        guard let iconStr = place.icon,
            let iconURL = URL(string: iconStr),
        let imageData = try? Data(contentsOf: iconURL)
        else{
            cell.iconImageView.image = UIImage(named: "StarEmpty")
            return cell
        }
        cell.iconImageView.image = UIImage(data: imageData)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let selected_Place = places[indexPath.row]
        let place_Id = selected_Place.placeId
        print(place_Id)
        GooglePlacesAPI.requestDetails(place_Id) { (status,json) in print(json)
            guard let jsonres = json else { return}
            var res = APIParser.parsePlacesDetails(jsonObj: jsonres)
            
            if !res.isEmpty {
                self.presentDetails(places: res[0])
            }
            
        }
}
    func presentDetails(places: Details) {
        guard let detailsViewController = UIStoryboard(name:"Main",bundle:nil).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewCotroller else { return }
        detailsViewController.detailInfo = places
        DispatchQueue.main.async{
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }

    
}
}

