import UIKit

class GroupViewController: UIViewController {
    let defaults = UserDefaults.standard
    var group: Group? = nil;

    @IBOutlet weak var n_members: UILabel!
    @IBOutlet weak var idgroup: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let groupId = defaults.string(forKey: "groupId")
        Service().getGroup(groupId: groupId!) { group in
            self.group = group
        }
        
        let members: [User] = [
            User(googleId: "123", username: "Florian"),
            User(googleId: "1234", username: "Antoine"),
            User(googleId: "1234", username: "Max")
        ];
//        let group: Group = Group(id: "1", nbMember: members.count, name: "CSC App Dev", Members: members)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        do {
            usleep(1000000)
        }
        let nb: Int = self.group!.nbMember
        self.n_members.text = String("\(nb)")
       self.idgroup.text = self.group?.name
        gmCreator(groupmember: self.group!.Members)
    }
    
    func gmCreator(groupmember :[User]) {
        var y = 200
        for member in groupmember {
            let label = UILabel(frame: CGRect(x: 10, y: y, width: 400, height: 31))
            label.textAlignment = .left
            label.font = label.font.withSize(40)
            label.text = member.username
            self.view.addSubview(label)
            y = y + 60
        }
    }

}
