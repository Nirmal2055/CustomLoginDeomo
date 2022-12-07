//
//  LoginViewController.swift
//  CustomLoginDemo
//
//  Created by Nirmal Koirala on 18/07/2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
     
    func setUpElements() {
        
//        hide the error label
        errorLabel.alpha = 0
        
        
//        style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styledFilledButton(loginButton)
    }
    
    func validateFields() -> String? {
        
            if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines )
        
        if Utilities.isPasswordValid(cleanedPassword ) == false {
             return "please make sure your password format is valid "
        }
        
        return nil
         
    }
    

    @IBAction func loginTapped(_ sender: Any) {
        
        //validate text fields
        let error = validateFields()
        
        if error != nil {
           showError(error!)
             
        }
        else{
        
//        create clean version of the text field
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) 
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) 

        //signing in the users
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard
                let strongSelf = self else { return }
            
            
            if error != nil {
//                couldnot sign in
                strongSelf.errorLabel.text = error!.localizedDescription
                strongSelf.errorLabel.alpha = 1
            }
            else {
                let homeViewController = strongSelf.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.HomeViewController) as? HomeViewController
                strongSelf.view.window?.rootViewController =  homeViewController
                strongSelf.view.window?.makeKeyAndVisible()
                 
            }
        }
        
    }
    }
        func showError(_ message: String) {
            errorLabel.text = message
            errorLabel.alpha = 1
             
        }
       
    
  
}

