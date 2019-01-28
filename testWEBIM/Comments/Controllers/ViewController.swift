import UIKit
import SwiftyVK

class ViewController: UIViewController {
    
    @IBAction func loginButton(_ sender: Any) {
        VK.sessions.default.logIn(
            onSuccess: { info in
                print("SwiftyVK: success authorize with", info)
                
        },
            onError: { error in
                print("SwiftyVK: authorize failed with", error)
        }
        )
        if VK.sessions.default.accessToken != nil {
            self.performSegue(withIdentifier: "segue", sender: self)
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if VK.sessions.default.accessToken != nil {
            self.performSegue(withIdentifier: "segue", sender: self)
        }
        
    }
}

