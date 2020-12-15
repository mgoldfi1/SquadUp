//
//  ViewController.swift
//  SquadUp
//
//  Created by Matthew Goldfine on 11/29/20.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInButton.layer.cornerRadius = 12
        logInButton.layer.borderWidth = 2
        registerButton.layer.cornerRadius = 12
        registerButton.layer.borderWidth = 2
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToLogin", sender: self)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToRegister", sender: self)
    }
}

