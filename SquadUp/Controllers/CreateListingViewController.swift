//
//  CreateListingViewController.swift
//  SquadUp
//
//  Created by Matthew Goldfine on 12/15/20.
//

import UIKit

class CreateListingViewController: UIViewController {

    @IBOutlet weak var textBox: UITextView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var experienceField: UITextField!
    @IBOutlet weak var seekingField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textBox.layer.borderWidth = 2
        textBox.layer.cornerRadius = 12
        titleField.layer.borderWidth = 2
        titleField.layer.cornerRadius = 12
        experienceField.layer.borderWidth = 2
        experienceField.layer.cornerRadius = 12
        seekingField.layer.borderWidth = 2
        seekingField.layer.cornerRadius = 12
        submitButton.layer.borderWidth = 2
        submitButton.layer.cornerRadius = 12
        
    }
    
    @IBAction func closeModal(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func submitListing(_ sender: UIButton) {
        print("hello")
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
