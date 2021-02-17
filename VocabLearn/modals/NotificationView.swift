//
//  NotificationView.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-15.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

class NotificationView: UIViewController {

    let isPhone = UIDevice.isPhone
    
    fileprivate var hour = -1
    fileprivate var minute = -1
    
    lazy var titleLbl: UILabel = {
                let titleLbl = UILabel()
                    titleLbl.textAlignment = .center
                   // titleLbl.font = UIFont(name: "Helvetica-Bold", size: 32)
                    titleLbl.translatesAutoresizingMaskIntoConstraints = false
                    titleLbl.text = "Set your daily \nnotification"
                    titleLbl.numberOfLines = 0
            titleLbl.textColor = .lightGray
                    return titleLbl
    }()
          lazy var descLbl: UILabel = {
                let descriptionLbl = UILabel()
               descriptionLbl.textAlignment = .center
               descriptionLbl.numberOfLines = 0
                descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
               descriptionLbl.text = "Set your daily notification time \n\n Consistency leads to better improvement"
               return descriptionLbl
          }()

    
    let scheduleBtn: UIButton = {
                         let btn = UIButton.init(type: .system)
                             btn.translatesAutoresizingMaskIntoConstraints = false
                         btn.setTitle("Set Time", for: .normal)
                         btn.isUserInteractionEnabled = true
                         btn.layer.backgroundColor = UIColor.teal.cgColor
                        btn.setTitleColor(UIColor.white, for: .normal)
                         btn.addTarget(self, action: #selector(setNotification), for: .touchUpInside)
                         return btn
    }()

    
    let timePicker: UIDatePicker = {
                         let timepickers = UIDatePicker()
                         timepickers.translatesAutoresizingMaskIntoConstraints = false
                      timepickers.datePickerMode = UIDatePicker.Mode.time
                             //startTimeDiveTextField.inputView = timePicker
        //timepickers.layer.borderColor = UIColor.white.cgColor
                          timepickers.addTarget(self, action: #selector(getTime(sender:)), for: .valueChanged)
                         return timepickers
      }()
    
        lazy var closeBtn: UIButton = {
                   let btn = UIButton.init(type: .system)
                  btn.translatesAutoresizingMaskIntoConstraints = false
                  let img = UIImage(named: "closeicon")
                   btn.clipsToBounds = true
                  btn.tintColor = .lightGray
                  btn.layer.backgroundColor = UIColor.lightGrey.cgColor
                  btn.setImage(img, for: .normal)
                   btn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
                   return btn
        }()
    
    let notificationImg: UIImageView = {
          let img = UIImageView()
          img.translatesAutoresizingMaskIntoConstraints = false
          img.image = UIImage(named: "intro4-4")
          img.contentMode = .scaleAspectFit
          return img
      }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(titleLbl)
        view.addSubview(closeBtn)
        view.addSubview(notificationImg)
        view.addSubview(timePicker)
        view.addSubview(scheduleBtn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
       // let minimumSize = self.view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        //self.preferredContentSize = CGSize(width: 280, height: minimumSize.height)
        let center = UNUserNotificationCenter.current()
                      center.requestAuthorization(options: [.alert,.badge, .sound]){granted, error
                          in
                          if granted{
                              print("good")
                          }else{
                              print("no")
                          }
              }
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()

        if isPhone{
           titleLbl.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/30)
            scheduleBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/30)
         
            let today = Date()
            getDate(date: today)
            
            
            closeBtn.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: safeAreaWidth/30).isActive = true
            closeBtn.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -safeAreaHeight/35).isActive = true
            closeBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.1).isActive = true
            closeBtn.heightAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.1).isActive = true
            
             titleLbl.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaHeight/30).isActive = true
            titleLbl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: safeAreaHeight/35).isActive = true
            titleLbl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,  constant: -safeAreaHeight/35).isActive=true
            
            notificationImg.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: safeAreaHeight/30).isActive = true
            notificationImg.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: safeAreaHeight/35).isActive = true
            notificationImg.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,  constant: -safeAreaHeight/35).isActive=true
            notificationImg.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.3).isActive = true
 
       
            timePicker.topAnchor.constraint(equalTo: notificationImg.bottomAnchor, constant: safeAreaHeight/55).isActive = true
             timePicker.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.8).isActive = true
            timePicker.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.23).isActive = true

       
             scheduleBtn.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: safeAreaHeight/25).isActive = true
            scheduleBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.55).isActive = true
            scheduleBtn.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.08).isActive = true
            
            scheduleBtn.layer.cornerRadius = safeAreaHeight/25
   
            
        }else{
            
        }
        closeBtn.drawCicleByFive()
        scheduleBtn.addSlightShadow()
        notificationImg.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        scheduleBtn.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        timePicker.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
    }
    
    @objc func closeView(){
           dismiss(animated: true, completion: nil)
       }
    
     // -------------- TIMEPICKER AND NOTIFICATIONS  Functions ------------//
    
    @objc func getTime(sender: UIDatePicker) {
       self.getDate(date: sender.date)
    }
    
    func getDate(date: Date) {
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute], from: date)
        hour = comp.hour ?? 0
        minute = comp.minute ?? 0
    }
    
    @objc func setNotification(){
        if(hour > -1 && minute > -1){
          
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        
        content.title = "Notification"
        content.body = "Use the VocabLearn to expand your vocabulary!"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "new"]
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
            
        showAlert()
        }
    }
    
    func showAlert(){
        let editAlert = UIAlertController(title: "Success", message: "Notification Added", preferredStyle: .alert)
          editAlert.addAction(UIAlertAction(title: "Ok", style: .cancel))
          self.present(editAlert, animated: true, completion: nil)
    }
}
