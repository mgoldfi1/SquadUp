//
//  LoginViewController.swift
//  SquadUp
//
//  Created by Matthew Goldfine on 11/29/20.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    var networkingClient = NetworkingClient()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .systemPurple
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        
        logInButton.layer.cornerRadius = logInButton.frame.size.height/2
        
        emailTextField.layer.cornerRadius = emailTextField.frame.size.height/2
        emailTextField.clipsToBounds = true
        emailTextField.text = "email@gmail.com"
        
        passwordTextField.layer.cornerRadius = passwordTextField.frame.size.height/2
        passwordTextField.clipsToBounds = true
        passwordTextField.text = "pass"
        
        networkingClient.delegate = self
     }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if !email.isEmpty && !password.isEmpty {
            
         networkingClient.login(email: email, password: password)
            
        } else {
            print("NOTHING ENTERED")
            errorMessage.text = "Fields cannot be blank"
            errorMessage.sizeToFit()

        }
    }
    

}


extension LoginViewController: NetworkingClientDelegate {
    func didSuccessfullyLogin(session: LoginSession) {
        print(session)
        self.performSegue(withIdentifier: "goToHome", sender: self)
    }
    
    func loginFailed(session: LoginSession) {
        if let error = session.message {
            print("ERROR HERE \(error)")
            DispatchQueue.main.async {
                print("hello")
                self.errorMessage.text = error
                self.errorMessage.textColor = .white
                self.errorMessage.sizeToFit()
            }
        }
        print("This failed \(session)")
    }
}
