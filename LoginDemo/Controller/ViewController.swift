//
//  ViewController.swift
//  LoginDemo


import UIKit
import GoogleSignIn
import FBSDKLoginKit

class ViewController: UIViewController {
    
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtEmailId: UITextField!
    
    @IBOutlet var btnSignIn: UIButton!
    @IBOutlet var btnSignInWithGoogle: UIButton!
    @IBOutlet var btnSignInWithApple: UIButton!
    
    @IBOutlet var btnSignInWithFacebook: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if(UserDefaults.standard.value(forKey: "loggedIn") as? Bool ?? false){
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CartViewController") as? CartViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        image.image = UIImage(named: "background")
        
        self.view.addSubview(image)
        self.view.sendSubviewToBack(image)
//        if let token = AccessToken.current,
//               !token.isExpired {
//               // Facebook token to login directly next time
//        }
       
        
        btnSignIn.layer.cornerRadius = 5
        btnSignIn.layer.masksToBounds = true
        btnSignIn.layer.borderColor = UIColor.white.cgColor
        btnSignIn.layer.borderWidth = 1
        
        btnSignInWithGoogle.layer.cornerRadius = 5
        btnSignInWithGoogle.layer.masksToBounds = true
        
        btnSignInWithFacebook.layer.cornerRadius = 5
        btnSignInWithFacebook.layer.masksToBounds = true
        
        btnSignInWithApple.layer.cornerRadius = 5
        btnSignInWithApple.layer.masksToBounds = true
         
    }
    
}

extension ViewController{
    
    //MARK: normal sign in method
    @IBAction func btnSignInClicked(_ sender: Any) {
        
        if isValidEmail(txtEmailId.text ?? ""){
            if(txtEmailId.text ?? "".trimmingCharacters(in: .whitespacesAndNewlines) == "meetpandya104@gmail.com" && txtPassword.text ?? "".trimmingCharacters(in: .whitespacesAndNewlines) == "12345678"){
                
                loginSuccess()
                
                print("loggedIn")
            }else if(txtPassword.text ?? "".trimmingCharacters(in: .whitespacesAndNewlines) == ""){
                let alert = UIAlertController(title: "Please enter password", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Please enter valid password", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "Please enter correct email address", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    //MARK: google sign in method
    @IBAction func btnSignInWithGoogleClicked(_ sender: Any) {
        let signInConfig = GIDConfiguration(clientID: "676677457646-njom3b5hn684774duclsfr5k6sivbpi6.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }

            self.loginSuccess()
          }
        
    }
    
    
    //MARK: facebook sign in method
    @IBAction func btnSignInWithFacebookClicked(_ sender: Any) {
        LoginManager.init().logIn(permissions: [Permission.publicProfile, Permission.email], viewController: self) { (loginResult) in
          switch loginResult {
          case .success(let granted, let declined, let token):
            /*
            Sample log:
              granted: [FBSDKCoreKit.Permission.email, FBSDKCoreKit.Permission.publicProfile],
              declined: [],
              token: <FBSDKAccessToken: 0x282f50fc0>
            */
//              let requestedFields = "email, first_name, last_name"
//              GraphRequest.init(graphPath: "me", parameters: ["fields":requestedFields]).start { (connection, result, error) -> Void in
//
//
//                  }
//
//              }
              self.loginSuccess()
                  
              print("granted: \(granted), declined: \(declined), token: \(token)")
          case .cancelled:
              print("Login: cancelled.")
          case .failed(let error):
            print("Login with error: \(error.localizedDescription)")
          }
        }
    }
    
    //MARK: apple sign in method
    @IBAction func btnSignInWithAppleClicked(_ sender: Any) {
    }

    //MARK: email validation
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func loginSuccess(){
        UserDefaults.standard.set(true, forKey: "loggedIn")
        UserDefaults.standard.synchronize()
        
        txtPassword.text = ""
        txtEmailId.text = ""
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CartViewController") as? CartViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}



