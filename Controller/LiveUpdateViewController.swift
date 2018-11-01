//
//  LiveUpdateTableViewController.swift
//  KnightHacks
//
//  Created by KnightHacks on 9/17/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

func getImage(at url: String, completion: @escaping (UIImage?) -> Void) {
    var validatedUrl = url
    let httpsText = "https://"
    let httpText = "http://"
    print("this is the validate url before conditional = " + validatedUrl)
    // if prefix has no http:// append http://
    // if it is http, change to https
    if String(url.prefix(httpText.count)) == httpText {
        validatedUrl = httpsText + String(url.suffix(url.count - httpText.count))
    } else if String(url.prefix(httpsText.count)) == httpsText {
        
    } else {
        validatedUrl = httpsText + url
    }
    
    print("this is the validate url after conditional = " + validatedUrl)
    guard let fullUrl = URL(string: validatedUrl) else {
        print("Error: Invalid URL request")
        completion(nil)
        return
    }
    
    let task = URLSession.shared.dataTask(with: fullUrl) { (data, res, err) in
        DispatchQueue.main.async {
            if(err != nil) {
                completion(nil)
                print(err!)
                return
            }
            
            guard let imageData = data else {
                completion(nil)
                print("Error: Could not convert response to Data")
                return
            }
            
            guard let decodedImage = UIImage(data: imageData) else {
                completion(nil)
                print("Error: Could not convert Data to UIImage")
                return
            }
            
            completion(decodedImage)
        }
    }
    task.resume()
}


class LiveUpdatesViewController: ParentTableView {
    var liveUpdateContent: [LiveUpdateObject] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.register(LiveUpdatesTableViewCell.self, forCellReuseIdentifier: LiveUpdatesTableViewCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return LIVE_UPDATE_VIEW_HEIGHT
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LiveUpdatesTableViewCell.identifier, for: indexPath) as! LiveUpdatesTableViewCell
            
            if cell.liveUpdatesView == nil {
                cell.liveUpdatesView = LiveUpdateCountdownTimerViewController(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: LIVE_UPDATE_VIEW_HEIGHT))
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DynamicTableViewCell.identifier, for: indexPath) as! DynamicTableViewCell
            cell.cellType = .leftImageCell
            
            getImage(at: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/%27Greeley_Panorama%27_from_Opportunity%27s_Fifth_Martian_Winter%2C_PIA15689.jpg/1920px-%27Greeley_Panorama%27_from_Opportunity%27s_Fifth_Martian_Winter%2C_PIA15689.jpg") { (imageOfWeb) in
                
                if imageOfWeb == nil { print("error?")}
                
                cell.contentImageView?.image = imageOfWeb
            }
            cell.selectionStyle = .none
            return cell
        }
    }
}
