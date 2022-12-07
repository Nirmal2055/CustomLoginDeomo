//
//  SignUpViewController.swift
//  CustomLoginDemo
//
//  Created by Nirmal Koirala on 18/07/2022.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
//        hide the error label
        errorLabel.alpha = 0
        
        
//        style the button
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styledFilledButton(signUpButton)
        
    }
    func validateFields() -> String? {
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines ) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines  )  == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines )
        
        if Utilities.isPasswordValid(cleanedPassword ) == false {
             return "please make sure your password format is valid "
        }
        
        return nil
         
    }
     

    
    @IBAction func signUpTapped(_ sender: Any) {
//        validate the fields
        
        let error = validateFields()
        
        if error != nil {
           showError(error!)
             
        }
        else{
            let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
             
//            let unwrappedEmail = email ?? ""
            //        create the user
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, err) in
                guard
                    let strongSelf = self else { return }
                
                if  err !=  nil {
                    
                    strongSelf.showError("Error Creating User ")
                    
                }
                else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstame": firstName, "lastname": lastName, "uid": result!.user.uid ]) { (error) in
                         
                        if error != nil {
                            strongSelf.showError("ERROR saving user data")
                        }
                    }
                    //        transition to the home screen 
                    strongSelf.transitionToHome()
                }
            }

    }
}
                                   
      
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
         
    }
    func transitionToHome() {
       let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.HomeViewController) as? HomeViewController
        view.window?.rootViewController =  homeViewController
        view.window?.makeKeyAndVisible()
        

    }
}
 
