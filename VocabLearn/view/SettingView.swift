//
//  SettingView.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-14.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class SettingView: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
    let isPhone = UIDevice.isPhone
    
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.layer.borderColor = UIColor.lightGrey.cgColor
        tv.isScrollEnabled = true
        tv.register(SettingCell.self, forCellReuseIdentifier: "SettingCell")
        return tv
    }()
    
    let titleLbL: UILabel = {
                  let label = UILabel()
                  label.translatesAutoresizingMaskIntoConstraints = false
                  label.textAlignment = .left
                  label.minimumScaleFactor = 0.1
                   label.adjustsFontSizeToFitWidth = true
                   label.numberOfLines = 1
                label.text = "VOCALE"
           label.textColor = .darkerGray
                  return label
       }()
    let descLbL: UILabel = {
                     let label = UILabel()
                     label.translatesAutoresizingMaskIntoConstraints = false
                     label.textAlignment = .left
                     label.minimumScaleFactor = 0.1
                      label.adjustsFontSizeToFitWidth = true
                      label.numberOfLines = 1
                   label.text = "Vocabulary builder"
              label.textColor = .lightGray
                     return label
          }()
   
    let versionLbL: UILabel = {
                    let label = UILabel()
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.textAlignment = .center
                    label.minimumScaleFactor = 0.1
                     label.adjustsFontSizeToFitWidth = true
                     label.numberOfLines = 1
                  label.text = "Vocale © 2020 Version: 5.29.0 (2137)"
             label.textColor = .lightGray
                    return label
         }()
    let logoImg: UIImageView = {
              let img = UIImageView()
              img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "logo")!.withRenderingMode(.alwaysOriginal)
             img.contentMode = .scaleAspectFit
              return img
    }()
    
    let logoIcon: UIButton = {
          let btn = UIButton.init(type: .system)
             btn.translatesAutoresizingMaskIntoConstraints = false
       let img = UIImage(named: "logo")?.withRenderingMode(.alwaysOriginal)
      // img?.withTintColor(.white)
       btn.setImage(img, for: .normal)
         btn.layer.borderWidth = 2
       btn.clipsToBounds = true
       btn.layer.borderColor = UIColor.lightBlue.cgColor
       btn.layer.backgroundColor = UIColor.white.cgColor
        // btn.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
             return btn
    }()
    
    
    let shareBtn: UIButton = {
           let btn = UIButton.init(type: .system)
               btn.translatesAutoresizingMaskIntoConstraints = false
               btn.setTitle("Share", for: .normal)
               btn.isUserInteractionEnabled = true
               btn.layer.backgroundColor = UIColor.link.cgColor
               btn.setTitleColor(UIColor.white, for: .normal)
               btn.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
               return btn
    }()
 let topView : UIView = {
              let view = UIView()
                  view.translatesAutoresizingMaskIntoConstraints = false
              view.backgroundColor = .white
              return view
    }()
   /* let footerView : UIView = {
              let view = UIView()
                  view.translatesAutoresizingMaskIntoConstraints = false
              view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGrey.cgColor
        return view
    }()*/
    let title1 = UILabel()
    let title2 = UILabel()
    let title3 = UILabel()
    let title4 = UILabel()
    let title5 = UILabel()
    
let scrollView = UIScrollView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
       // self.navigationItem.title = "Settings"
       // let scrollView = UIScrollView(frame: view.bounds)
      //  scrollView.delegate = self
       // scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100)
       // view.addSubview(scrollView)
       // scrollView.contentSize = CGSize(width: self.view.frame.width, height:2000)
        
        view.backgroundColor = .veryLightGray
              //  scrollView.frame = view.bounds
        view.addSubview(title1)
        view.addSubview(title2)
       view.addSubview(title3)
        view.addSubview(title4)
        view.addSubview(title5)
       //view.addSubview(headerView)
       // view.addSubview(footerView)
       // headerView.addSubview(logoImg)
       
      //  footerView.addSubview(versionLbL)
        //footerView.addSubview(shareBtn)
        view.addSubview(topView)
        topView.addSubview(logoIcon)
        topView.addSubview(titleLbL)
        topView.addSubview(descLbL)
        view.addSubview(tableView)
        //scrollView.backgroundColor = .clear
        tableView.separatorColor = UIColor.lightGray
        
        
    }
    
    override func viewDidLayoutSubviews() {
              super.viewDidLayoutSubviews()
       // scrollView.setContentOffset( CGPoint(x:0,y:30), animated:true )
           //scrollView.contentOffset.y += 80
        if (isPhone){
            
            topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            topView.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive=true
            topView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.2).isActive=true
                       
            titleLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/30)
             descLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/45)
            
            logoIcon.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.15).isActive = true
            logoIcon.heightAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.15).isActive = true
            logoIcon.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -safeAreaHeight/80).isActive = true
            logoIcon.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: safeAreaHeight/35).isActive = true
  
            titleLbL.topAnchor.constraint(equalTo: logoIcon.topAnchor, constant: safeAreaHeight/85).isActive = true
            titleLbL.leadingAnchor.constraint(equalTo: logoIcon.trailingAnchor, constant: safeAreaHeight/40).isActive = true
  
            descLbL.topAnchor.constraint(equalTo: titleLbL.bottomAnchor, constant: safeAreaHeight/200).isActive = true
            descLbL.leadingAnchor.constraint(equalTo: logoIcon.trailingAnchor, constant: safeAreaHeight/40).isActive = true
        
             tableView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
                      //tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -safeAreaHeight/40).isActive = true
            tableView.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive=true
           // tableView.heightAnchor.constraint(equalTo: safeArea.heightAnchor).isActive=true
            //tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive=true
                      
                    //  tableView.layer.cornerRadius = safeAreaHeight/70
            tableView.rowHeight = safeAreaHeight/11
            view.backgroundColor = .white

        }else{
            titleLbL.font = UIFont(name: "Helvetica-Bold", size: safeArea.layoutFrame.height/27)
                       titleLbL.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaHeight/23).isActive = true
                       
                       logoImg.topAnchor.constraint(equalTo: titleLbL.bottomAnchor, constant: safeAreaHeight/40).isActive = true
                       logoImg.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.15).isActive = true
                       logoImg.heightAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.15).isActive = true
                       
            tableView.topAnchor.constraint(equalTo: logoImg.bottomAnchor, constant: safeAreaHeight/40).isActive = true
                       tableView.heightAnchor.constraint(equalTo: safeArea.heightAnchor,multiplier:0.65).isActive=true
                       tableView.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.95).isActive=true
            
            tableView.layer.cornerRadius = safeAreaHeight/50
            tableView.rowHeight = safeAreaHeight/15

        }
        //topView.addShadow()
        logoIcon.drawCicleByFive()
       tableView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
  
    }
    
 
    
    //--------------TableView FUNCTIONS-----------------//
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         switch section {
         case 0:
             let headerView1 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: safeAreaHeight/12))
             let underline = UIView(frame: CGRect.init(x: 17, y: 0, width: tableView.frame.width-34, height: safeAreaHeight/150))
                      //  underline.translatesAutoresizingMaskIntoConstraints = false
             underline.backgroundColor = .lightGrey
                       //     headerView1.addSubview(underline)
             title1.text = "Premium"
             title1.textColor = .darkerGray
             let headerHeight = headerView1.frame.height
             title1.translatesAutoresizingMaskIntoConstraints = false
             title1.font = UIFont(name: "Helvetica-Bold", size: headerHeight/4)
            headerView1.addSubview(title1)
           // title1.bottomAnchor.constraint(equalTo: headerView1.bottomAnchor, constant: -headerHeight/8).isActive = true
             title1.centerYAnchor.constraint(equalTo: headerView1.centerYAnchor).isActive = true
            title1.leadingAnchor.constraint(equalTo: headerView1.leadingAnchor, constant: safeAreaWidth/20).isActive = true
            headerView1.backgroundColor = .lightGrey
             return headerView1
         case 1:
            
             let headerView2 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: safeAreaHeight/12))
            // let title2 = UILabel()
             title2.text = "General"
             title2.textColor = .darkerGray
             title2.translatesAutoresizingMaskIntoConstraints = false
             let headerHeight = headerView2.frame.height
             title2.font = UIFont(name: "Helvetica-Bold", size: headerHeight/4)
             headerView2.addSubview(title2)
            // title2.bottomAnchor.constraint(equalTo: headerView2.bottomAnchor, constant: -headerHeight/8).isActive = true
             title2.centerYAnchor.constraint(equalTo: headerView2.centerYAnchor).isActive = true
             title2.leadingAnchor.constraint(equalTo: headerView2.leadingAnchor, constant: safeAreaWidth/20).isActive = true
             headerView2.backgroundColor = .lightGrey
             return headerView2
         case 2:
             let headerView3 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: safeAreaHeight/12))
            // let title3 = UILabel()
             title3.text = "Statistic"
             title3.textColor = .darkerGray
             title3.translatesAutoresizingMaskIntoConstraints = false
             let headerHeight = headerView3.frame.height
             title3.font = UIFont(name: "Helvetica-Bold", size: headerHeight/4)
            headerView3.addSubview(title3)
             title3.centerYAnchor.constraint(equalTo: headerView3.centerYAnchor).isActive = true
           // title3.bottomAnchor.constraint(equalTo: headerView3.bottomAnchor, constant: -headerHeight/8).isActive = true
            title3.leadingAnchor.constraint(equalTo: headerView3.leadingAnchor, constant: safeAreaWidth/20).isActive = true
            headerView3.backgroundColor = .lightGrey
             return headerView3
         case 3:
            let headerView4 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: safeAreaHeight/12))
                // let title3 = UILabel()
                 title4.text = "Legal"
                 title4.textColor = .darkerGray
                 title4.translatesAutoresizingMaskIntoConstraints = false
                 let headerHeight = headerView4.frame.height
                 title4.font = UIFont(name: "Helvetica-Bold", size: headerHeight/4)
                headerView4.addSubview(title4)
            title4.centerYAnchor.constraint(equalTo: headerView4.centerYAnchor).isActive = true
                //title4.bottomAnchor.constraint(equalTo: headerView4.bottomAnchor, constant: -headerHeight/8).isActive = true
                title4.leadingAnchor.constraint(equalTo: headerView4.leadingAnchor, constant: safeAreaWidth/20).isActive = true
                headerView4.backgroundColor = .lightGrey
                 return headerView4
            
         default:
             let headerView5 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: safeAreaHeight/9))
            // let title4 = UILabel()
             let underline = UIView(frame: CGRect.init(x: 17, y: 0, width: tableView.frame.width-34, height: safeAreaHeight/150))
             //  underline.translatesAutoresizingMaskIntoConstraints = false
               underline.backgroundColor = .lightGrey
                headerView5.addSubview(underline)
             title5.text = "VOCALE"
             title5.translatesAutoresizingMaskIntoConstraints = false
             title5.textColor = .darkerGray
             let headerHeight = headerView5.frame.height
             title5.font = UIFont(name: "Helvetica", size: headerHeight/4)
             headerView5.addSubview(versionLbL)
            versionLbL.font = UIFont(name: "Helvetica", size: safeAreaHeight/65)
            versionLbL.bottomAnchor.constraint(equalTo: headerView5.bottomAnchor, constant: -headerHeight/10).isActive = true
            versionLbL.centerXAnchor.constraint(equalTo: headerView5.centerXAnchor).isActive = true
            headerView5.addSubview(title5)
            title5.bottomAnchor.constraint(equalTo: versionLbL.topAnchor, constant: -headerHeight/8).isActive = true
            title5.centerXAnchor.constraint(equalTo: headerView5.centerXAnchor).isActive = true
             headerView5.backgroundColor = .white
             
             return headerView5
         }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       /* if section == 0 {
            return safeAreaHeight/6
        }
        else*/ if section == 0 || section == 1 || section == 2 || section == 3{
            return safeAreaHeight/12
        }else{
            return safeAreaHeight/8
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        switch section {
       // case 0:
         //   count = 0
        case 0:
            count = 1
        case 1:
            count = 4
        case 2:
            count = 3
        case 3:
            count = 2
        default:
            count = 0
        }
        return count
    }
    
    var count = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell

        var titles = [String]()
        var images = [String]()
        
        if indexPath.section == 0 {
             titles = ["Premium Subscription"]
            images = ["crown2"]
               // cell.accessoryType = .disclosureIndicator
             
        }else if indexPath.section == 1{
             titles = ["Set Notification", "Add your own Word", "Leave us a Review", "Give us a Feedback"]
             images = ["notification", "addword", "thumbsup", "feedback1"]
               // cell.accessoryType = .disclosureIndicator
            
        }else if indexPath.section == 2{
            titles = ["Words Favourited","Words Added", "Words Learned"]
            images = ["empty","empty", "empty"]
            
        }else{
            titles = ["Terms of Service", "Privacy Policy"]
            images = ["empty", "empty"]
        }
       /* var lastSection = false
        if indexPath.section == 3 && indexPath.row == titles.count-1{
               lastSection = true
        }
        if (indexPath.row == titles.count - 1 && count < 4 && !lastSection) {
            //cell.separatorInset.bottom = cell.bounds.size.width
            /*cell.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
            let thickness: CGFloat = 1.0
            let bottomBorder = CALayer()
            bottomBorder.frame = CGRect(x:0, y: cell.frame.height - thickness, width: cell.frame.width, height:thickness)
            bottomBorder.backgroundColor = UIColor.red.cgColor
            cell.layer.addSublayer(bottomBorder)*/
           
           let sep = CALayer()
               let insets = tableView.separatorInset
               let width = tableView.bounds.width - 17 - 17
           let sepFrame = CGRect(x: insets.left, y: tableView.rowHeight - 0.5, width: width, height: 0.3)

            //cell.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
             // create layer with separator, setting color
                sep.removeFromSuperlayer()
             sep.frame = sepFrame
        sep.backgroundColor = UIColor.lightGray.cgColor//tableView.separatorColor?.cgColor
            // cell.layer.addSublayer(sep)
            count += 1
        }*/
        cell.selectionStyle = .none
        let image = UIImage(named: images[indexPath.row])!.withRenderingMode(.alwaysTemplate)
        //image.withTintColor(.lightGray, renderingMode: .alwaysTemplate)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
        cell.setUpSetting(title: titles[indexPath.row] , image: image)
        
        cell.label.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/38)
        cell.favouritedCount.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/38)
        cell.learnedCount.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/38)
        cell.addedCount.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/38)
       /* cell.label.font = UIFont(name: "Helvetica-Bold", size: safeAreaWidth/21)
        cell.favouritedCount.font = UIFont(name: "Helvetica-Bold", size: safeAreaWidth/21)
        cell.learnedCount.font = UIFont(name: "Helvetica-Bold", size: safeAreaWidth/21)
        cell.addedCount.font = UIFont(name: "Helvetica-Bold", size: safeAreaWidth/21)*/
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        if section == 0 {
            premiumTapped()
        }
        if section == 1 {
            switch indexPath.row {
            case 0:
                  let mainSB = UIStoryboard(name:"Main", bundle:nil)
                  let notificationView = mainSB.instantiateViewController(identifier: "NotificationView") as! NotificationView
                  notificationView.modalPresentationStyle = .popover
                         // self.navigationController?.preferredContentSize = CGSize(width: 248, height: 200)
                         // notificationView.modalTransitionStyle = .crossDissolve

                  self.present(notificationView, animated: true, completion: nil)
                    //self.navigationController?.pushViewController(notificationView, animated: true)
            case 1:
                let mainSB = UIStoryboard(name:"Main", bundle:nil)
                  let customWordView = mainSB.instantiateViewController(identifier: "CustomWordView") as! CustomWordView
                customWordView.modalPresentationStyle = .popover
                self.present(customWordView, animated: true, completion: nil)
            case 2:
                feedback()
            case 3:
                showEmailComposer()
            default:
               print("default")
            }
        }
    }
      func premiumTapped(){
          let mainSB = UIStoryboard(name:"Main", bundle:nil)
           let premiumView = mainSB.instantiateViewController(identifier: "PremiumView") as! PremiumView
        premiumView.modalPresentationStyle = .overFullScreen
          // self.navigationController?.preferredContentSize = CGSize(width: 248, height: 200)
           premiumView.modalTransitionStyle = .crossDissolve
           self.present(premiumView, animated: true, completion: nil)
      }
    func showEmailComposer(){
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["junkyamazaki@gmail.com"])
        composer.setSubject("App Feedback")
        
        present(composer, animated: true)
    }
 
    func feedback(){
           let feedbackUrl = "https://apps.apple.com/app/id1084540807?fbclid=IwAR1ctXGVKLXubpvHB9GCJ-tGzpfhCHyfyRLi6dRSIKJFViAVKTmdyZC6uJU"
         showSafariVC(for: feedbackUrl)
      }
    
    func showSafariVC(for url: String){
           guard let url = URL(string: url) else {
               return
           }
           let safariVC = SFSafariViewController(url:url)
           present(safariVC, animated: true)
    }
    
    @objc func shareTapped(_ button: UIButton){
           share()
    }
    
    func share(){
          let shareUrl = "https://apps.apple.com/app/id1084540807?fbclid=IwAR1ctXGVKLXubpvHB9GCJ-tGzpfhCHyfyRLi6dRSIKJFViAVKTmdyZC6uJU"
          let activityVC = UIActivityViewController(activityItems: [shareUrl], applicationActivities: nil)
          activityVC.isModalInPresentation = true
          activityVC.popoverPresentationController?.sourceView = self.view
          self.present(activityVC, animated: true, completion: nil)
    }

}
extension SettingView: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error{
            controller.dismiss(animated: true)
            return
        }
        
        switch result {
        case .cancelled:
            print("cancelled")
             controller.dismiss(animated: true)
        case .failed:
            print("failed")
             controller.dismiss(animated: true)
        case .saved:
             print("saved")
             controller.dismiss(animated: true)
        case .sent:
             print("sent")
             controller.dismiss(animated: true)
        @unknown default:
            print("default")
             controller.dismiss(animated: true)
        }
        
        //controller.dismiss(animated: true)
    }
}

/*class MySettingHeader: UITableViewHeaderFooterView {
    let title: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            label.minimumScaleFactor = 0.1
            label.adjustsFontSizeToFitWidth = true
            label.numberOfLines = 1
        //label.textColor = .white
            return label
    }()
    let img: UIImageView = {
                let img = UIImageView()
                img.translatesAutoresizingMaskIntoConstraints = false
              //  img.image = UIImage(named: "logo")
               img.contentMode = .scaleAspectFit
                return img
      }()
    
    let disclosureImg: UIImageView = {
                  let img = UIImageView()
                  img.translatesAutoresizingMaskIntoConstraints = false
                //  img.image = UIImage(named: "logo")
                 img.contentMode = .scaleAspectFit
                  return img
        }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        contentView.backgroundColor = .lightGrey
        title.font = UIFont(name: "Helvetica-Bold", size: 18)
        contentView.addSubview(title)
        contentView.addSubview(img)
        contentView.addSubview(disclosureImg)

        NSLayoutConstraint.activate([
          //  title.heightAnchor.constraint(equalToConstant: 30),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            img.leadingAnchor.constraint(equalTo: title.trailingAnchor,constant: 20),
            img.widthAnchor.constraint(equalToConstant: 25),
            img.heightAnchor.constraint(equalToConstant: 25),
            img.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            disclosureImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            disclosureImg.widthAnchor.constraint(equalToConstant: 25),
            disclosureImg.heightAnchor.constraint(equalToConstant: 25),
            disclosureImg.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}*/
