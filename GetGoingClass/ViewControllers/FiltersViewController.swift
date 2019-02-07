//
//  FiltersViewController.swift
//  GetGoingClass
//
//  Created by Diven Sambhwani on 2/4/19.
//  Copyright © 2019 SMU. All rights reserved.
//

import UIKit

enum RankBy{
    case prominence,distance
    
    func description() -> String{
        switch self{
        case .distance:
            return String(describing: self).capitalized
        case .prominence:
            return String(describing: self).capitalized
        }
    }
}
class FiltersViewController: UIViewController {
    var rankByDictionary: [RankBy] = [.prominence, .distance]
    @IBOutlet weak var pickerView: UIPickerView!
    @IBAction func closeButtonAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var rankByLabelSelected: UILabel!
    @IBOutlet weak var rankByLabel: UILabel!
    @IBOutlet weak var isOpenNow: UISwitch!
    @IBAction func radiusSliderChangedValue(_ sender: UISlider) {
        print("Slider value changed to \(sender.value)int\(Int(sender.value))")
    }
    
    @IBAction func switchValueChange(_ sender: UISwitch) {
        
        
        print("Switch vlaue changed to \(sender.isOn)")
    }
    @IBOutlet weak var radiusSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate=self
        pickerView.isHidden = true
        rankByLabel.isUserInteractionEnabled = true
        let tapGestureRecogonizer = UITapGestureRecognizer(target: self, action: #selector(rankByLabelTapped))
        rankByLabel.addGestureRecognizer(tapGestureRecogonizer)
        rankByLabelSelected.text = rankByDictionary.first?.description()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
    }
    


    @objc func rankByLabelTapped(){
        print("label was tapped")
        pickerView.isHidden = !pickerView.isHidden
    }
        


    // MARK: - Table view data source

  

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

    extension FiltersViewController: UIPickerViewDataSource, UIPickerViewDelegate{
        func numberOfComponents(in pickerView:UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return rankByDictionary.count
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return rankByDictionary[row].description()
}
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, forComponent component: Int){
            rankByLabelSelected.text =  rankByDictionary[row].description()
        }

}
