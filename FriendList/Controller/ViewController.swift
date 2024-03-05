//
//  ViewController.swift
//  FriendList
//
//  Created by Ajay Kumar on 04/03/24.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    var friendArray = [Friend]()
    var friendPhotos = [UIImage?]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendArray = Friend.defaultFriendList()
        
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        myTableView.reloadData()
    }
    
    
    @IBAction func nextPage(_ sender: UIBarButtonItem) {
        
        print("rr")
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InformationViewController") as! InformationViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friendArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myTableViewCell", for: indexPath) as! myTableViewCell
        
        
        cell.backImgView.layer.cornerRadius = cell.backImgView.frame.size.width / 2
        cell.backImgView.clipsToBounds = true
        
        if let image = friendArray[indexPath.row].profilePicture {
            print(image)
            cell.imgView.image = image
        }
        let isNameOn = userStandard.bool(forKey: UserDefaultKey.lastNameKey.rawValue)
        if isNameOn {
            cell.nameLable.text = "\(friendArray[indexPath.row].firstName)"
        }
        else {
            cell.nameLable.text = "\(friendArray[indexPath.row].firstName) \(friendArray[indexPath.row].lastName)"
        }

        let isContactOn = userStandard.bool(forKey: UserDefaultKey.contactKey.rawValue)
        cell.contactLabel.text = isContactOn ? "" : friendArray[indexPath.row].contact
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "InformationViewController") as? InformationViewController {
            vc.friendData = friendArray[indexPath.row]
            vc.currentIndex = indexPath.row
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

extension ViewController: InformationViewControllerDelegate  {
    
    func addOrUpdateFriend(friend: Friend, index: Int) {
        
        if index >= 0 && index < friendArray.count {
            // Update existing friend
            friendArray[index] = friend
        } else {
            // Add new friend
            friendArray.append(friend)
        }
        myTableView.reloadData()
    }
    
    func deleteFriend(index: Int) {
        friendArray.remove(at: index)
        myTableView.reloadData()
    }
    
}
