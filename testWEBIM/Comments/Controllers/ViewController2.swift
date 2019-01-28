import UIKit
import SwiftyVK

class ViewController2: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var friendOne: UILabel!
    @IBOutlet weak var friendTwo: UILabel!
    @IBOutlet weak var friendThree: UILabel!
    @IBOutlet weak var friendFour: UILabel!
    @IBOutlet weak var friendFive: UILabel!
    
    
    override func viewDidAppear(_ animated: Bool) {
        VK.API.Users.get(.empty)
            .configure(with: Config.init(httpMethod: .POST))
            .onSuccess { print("SwiftyVK: users.get successed with \n \(JSON($0))")
                let firstName = JSON($0)[0]["first_name"].stringValue
                let lastName = JSON($0)[0]["last_name"].stringValue
                self.nameLabel.text = "\(firstName) \(lastName)"
                
            }
            .onError { print("SwiftyVK: friends.get fail \n \($0)") }
            .send()
        
        
        
        VK.API.Friends.get([.fields : "bdate"])
            .onSuccess { //print("SwiftyVK: friends.get successed with \n \(JSON($0))")
              var fullnameArray = [String]()
                for friend in JSON($0)["items"].arrayValue {
                    let fullname = friend["first_name"].stringValue + " " + friend["last_name"].stringValue
                    fullnameArray.append(fullname)
                }
            
                if !fullnameArray.isEmpty {
                 self.friendOne.text = "\(fullnameArray[0])"
                 self.friendTwo.text = "\(fullnameArray[1])"
                 self.friendThree.text = "\(fullnameArray[2])"
                 self.friendFour.text = "\(fullnameArray[3])"
                 self.friendFive.text = "\(fullnameArray[4])"
                } else {
                    self.friendOne.text = "У вас нет друзей"
                }
                
            }
            .onError { print("SwiftyVK: friends.get failed with \n \($0)") }
            .send()
        
        
    }
    
    @IBAction func out(_ sender: Any) {
        VK.sessions.default.logOut()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
