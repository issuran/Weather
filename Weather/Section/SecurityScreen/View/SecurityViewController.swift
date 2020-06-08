//
//  SecurityViewController.swift
//  Weather
//
//  Created by Tiago Oliveira on 07/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import UIKit
import LocalAuthentication

class SecurityViewController: BaseViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    var context = LAContext()
    
    enum AuthenticationState {
        case loggedIn, loggedOut
    }
    
    var state = AuthenticationState.loggedOut {
        didSet {
            loginButton.isHighlighted = state == .loggedIn
            if state == .loggedIn {
                coordinator?.homeWeather()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        requestLocalAuthentication()
    }
    
    @IBAction func signIn(_ sender: Any) {
        requestLocalAuthentication()
    }
    
    func requestLocalAuthentication() {
        if state == .loggedIn {
            coordinator?.homeWeather()
        } else {
            context = LAContext()

            context.localizedCancelTitle = "Enter Username/Password"

            /// Verifica se possuo suporte de hardware.
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {

                let reason = "Log in to your account"
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in

                    if success {
                        DispatchQueue.main.async { [unowned self] in
                            self.state = .loggedIn
                        }
                    } else {
                        /// Fall back de pedir password ao usuario
                        debugPrint(error?.localizedDescription ?? "Failed to authenticate")
                    }
                }
            } else {
                /// Fall back de pedir password ao usuario
                debugPrint(error?.localizedDescription ?? "Can't evaluate policy")
            }
        }
    }
}
