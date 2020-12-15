//
//  RegisterViewController.swift
//  SquadUp
//
//  Created by Matthew Goldfine on 12/1/20.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    var networkingClient = NetworkingClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .black
        createButton.layer.cornerRadius = createButton.frame.size.height/2
        createButton.layer.borderWidth = 2
        
        emailTextField.layer.cornerRadius = emailTextField.frame.size.height/2
        emailTextField.clipsToBounds = true
        emailTextField.text = "email@gma1sil.com"
        emailTextField.layer.borderWidth = 2
        
        passwordTextField.layer.cornerRadius = passwordTextField.frame.size.height/2
        passwordTextField.clipsToBounds = true
        passwordTextField.text = "bombaclot"
        passwordTextField.layer.borderWidth = 2
        
        confirmPasswordField.layer.cornerRadius = confirmPasswordField.frame.size.height/2
        confirmPasswordField.clipsToBounds = true
        confirmPasswordField.text = "bombaclot"
        confirmPasswordField.layer.borderWidth = 2
        networkingClient.delegate = self

    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let passwordConfirmation = confirmPasswordField.text!
        if !email.isEmpty && !password.isEmpty && !passwordConfirmation.isEmpty {
            if password == passwordConfirmation {
                networkingClient.register(email: email, password: password)
            } else {
                errorMessage.text = "Password and confirmation do not match"
                errorMessage.sizeToFit()
            }
        } else {
            errorMessage.text = "Fields cannot be left blank."
            errorMessage.sizeToFit()

        }
        
    }
    

}

extension RegisterViewController: NetworkingClientDelegate {
    func didSuccessfullyLogin(session: LoginSession) {
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
