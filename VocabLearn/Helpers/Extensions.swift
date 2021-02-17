//
//  Extensions.swift
//  VocabLearn
//
//  Created by Jun K on 2020-05-31.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit
import CoreData

// hide keyboadrd
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
//UI iphone screen compatibility
extension CGFloat {
    var dp: CGFloat {
        return (self / 375) * UIScreen.main.bounds.width
    }
}
extension UIColor{
     static var lightGrey : UIColor{
        return UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
    }
     static var veryLightGray : UIColor{
        return UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1)
    }
    static var backgroundGray : UIColor{
        return UIColor(red: 211/255.0, green: 211/255.0, blue: 211/255.0, alpha: 1)
    }
    static var darkerGray : UIColor{
        return UIColor(red: 105/255.0, green: 105/255.0, blue: 105/255.0, alpha: 1)
    }
    static var placeholderGray: UIColor {
        return UIColor(red: 199/255.0, green: 199/255.0, blue: 205/255.0, alpha: 1)
    }
    static var teal: UIColor {
        return UIColor(red: 67/255.0, green: 195/255.0, blue: 206/255.0, alpha: 1)
    }
    static var lightBlue: UIColor {
        return UIColor(red: 211/255.0, green:231/255.0, blue: 238/255.0, alpha:1)
    }
    static var darkerBlue: UIColor {
           return UIColor(red: 56/255.0, green:78/255.0, blue: 120/255.0, alpha:1)
    }
    static var lightRed: UIColor {
        return UIColor(red: 231/255.0, green:151/255.0, blue: 150/255.0, alpha:1)
    }
    static var lightGreen: UIColor {
        return UIColor(red: 167/255.0, green:214/255.0, blue: 118/255.0, alpha:1)
    }
    static var Green: UIColor {
           return UIColor(red: 107/255.0, green:234/255.0, blue: 98/255.0, alpha:1)
    }
    static var lightPurple: UIColor {
           return UIColor(red: 191/255.0, green:184/255.0, blue: 218/255.0, alpha:1)
    }
    static var lightOrange: UIColor {
              return UIColor(red: 255/255.0, green:189/255.0, blue: 113/255.0, alpha:1)
       }
    static var lightPink: UIColor {
                 return UIColor(red: 229/255.0, green:193/255.0, blue: 205/255.0, alpha:1)
          }
    static var lightTeal: UIColor {
            return UIColor(red: 67/255.0, green: 195/255.0, blue: 206/255.0, alpha: 0.4)
    }
}

public extension UIDevice {

    class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }

    class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    class var isTV: Bool {
        return UIDevice.current.userInterfaceIdiom == .tv
    }

    class var isCarPlay: Bool {
        return UIDevice.current.userInterfaceIdiom == .carPlay
    }
}

extension UIViewController {
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}

extension UIViewController {
    var safeArea : UILayoutGuide {
        return (view.safeAreaLayoutGuide)
    }
    var safeAreaHeight : CGFloat {
        return (view.safeAreaLayoutGuide.layoutFrame.height)
    }
    var safeAreaWidth : CGFloat {
        return (view.safeAreaLayoutGuide.layoutFrame.width)
    }
}
extension UIImageView {

    func makeRounded() {

        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
extension UIButton {
    func drawCicleByFive(){
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.imageEdgeInsets = UIEdgeInsets(
                              top: self.frame.size.height/5,
                              left: self.frame.size.width/5,
                              bottom: self.frame.size.height/5,
                              right: self.frame.size.width/5)
    }
    func makeInsetByTen(){
        self.imageEdgeInsets = UIEdgeInsets(
                                     top: self.frame.size.height/10,
                                     left: self.frame.size.width/10,
                                     bottom: self.frame.size.height/10,
                                     right: self.frame.size.width/10)
    }
    func crossAnimate(){
        self.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.5 , options: .curveEaseIn ,animations: {
                  self.transform = .identity
                  self.alpha = 1
              })
       }
}
    extension UIDatePicker {
        func crossAnimate(){
         self.alpha = 0
         UIView.animate(withDuration: 0.5, delay: 0.5 , options: .curveEaseIn ,animations: {
                   self.transform = .identity
                   self.alpha = 1
               })
        }
    }

extension UIImageView{
    
    func crossAnimate(){
     self.alpha = 0
     UIView.animate(withDuration: 0.7, delay: 1, options: .curveEaseIn ,animations: {
               self.transform = .identity
               self.alpha = 1
           })
    }
 
    func colorFavouritePicture(imageView: UIImageView, liked: Bool) -> UIImage{
        var wordFavourited : Bool
        var favouriteImg : UIImageView
        favouriteImg = imageView
        wordFavourited = liked
        
        if wordFavourited == true{
            favouriteImg.image = (UIImage(named: "Favourite")?.withRenderingMode(.alwaysTemplate))!
            favouriteImg.tintColor = .teal
        }else{
            favouriteImg.image = (UIImage(named: "Favourite")?.withRenderingMode(.alwaysOriginal))!
                    }
        return favouriteImg.image!
    }

    func colorLearnedPicture(imageView: UIImageView, liked: Bool) -> UIImage{
        var wordLearned : Bool
        var learnedImg : UIImageView
        learnedImg = imageView
        wordLearned = liked
        
        if wordLearned == true{
            learnedImg.image = (UIImage(named: "checkmarkicon")?.withRenderingMode(.alwaysTemplate))!
                 learnedImg.tintColor = .teal
        }else{
            learnedImg.image = (UIImage(named: "checkmarkicon")?.withRenderingMode(.alwaysOriginal))!
                    }
        return learnedImg.image!
    }
    
    func animate(){
          self.transform = CGAffineTransform(translationX: 0, y: self.frame.height + 50)
          self.alpha = 0
          UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping:  0.4, initialSpringVelocity: 1 , options: .curveLinear,animations: {
              self.transform = .identity
              self.alpha = 1
          })
      }
}

extension UILabel
{
var optimalHeight : CGFloat
    {
        get
        {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = self.lineBreakMode
            label.font = self.font
            label.text = self.text

            label.sizeToFit()

            return label.frame.height
         }
    }
}
extension UIViewController {
func formattingWordList(word: NSManagedObject) -> Word{
   // let today = Date()
       var newWord: Word!
             let title = word.value(forKey: "title") as! String
              let wordType = word.value(forKey: "wordType") as! String
              let definition = word.value(forKey: "definition") as! String
              let sentence = word.value(forKey: "sentence") as! String
              let category = word.value(forKey: "category") as! String
              let favourite = word.value(forKey: "favourited") as! Bool
           let learned = word.value(forKey: "learned") as! Bool

              newWord = Word(title: title, wordType: wordType , definition: definition
                 ,sentence: sentence, category: category, favourited: favourite, added: false, learned:learned)
       
       return newWord
      }

}

extension UIViewController {
    func hideNavigationBar(animated: Bool){
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }

    func showNavigationBar(animated: Bool) {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
extension UILabel {
func crossAnimate(){
    self.alpha = 0
    UIView.animate(withDuration: 0.7, delay: 0.5 , options: .curveEaseIn ,animations: {
              self.transform = .identity
              self.alpha = 1
          })
   }
}

extension UIView {    
    func addCorner(){
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }

    func addShadow(){
       // containerView.layer.shadowColor = UIColor.darkGray.cgColor
       // containerView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
       // containerView.layer.shadowOpacity = 1.0
       // containerView.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = safeAreaLayoutGuide.layoutFrame.width/80
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero//CGSize(width: -safeAreaLayoutGuide.layoutFrame.width/80, height: safeAreaLayoutGuide.layoutFrame.width/80)
        self.layer.masksToBounds = false
    }
    func addStrongShadow(){
       // containerView.layer.shadowColor = UIColor.darkGray.cgColor
       // containerView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
       // containerView.layer.shadowOpacity = 1.0
       // containerView.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = safeAreaLayoutGuide.layoutFrame.width/50
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.masksToBounds = false
    }
    func addSlightShadow(){
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = safeAreaLayoutGuide.layoutFrame.width/120
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.masksToBounds = false
    }
    
    func addBottomShadow(){
        self.layer.shadowRadius = safeAreaLayoutGuide.layoutFrame.width/80
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: safeAreaLayoutGuide.layoutFrame.width/80)
        self.layer.masksToBounds = false
    }
    func strongBottomShadow(){
        self.layer.shadowRadius = safeAreaLayoutGuide.layoutFrame.width/40
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: safeAreaLayoutGuide.layoutFrame.width/40)

        self.layer.masksToBounds = false
    }
    
    func addTopShadow(){
        self.layer.shadowRadius = safeAreaLayoutGuide.layoutFrame.width/80
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: -safeAreaLayoutGuide.layoutFrame.width/80)
        self.layer.masksToBounds = false
    }
    
    func curveTopView(){
        let curveHeight:CGFloat = 50.0
        let curvedLayer = CAShapeLayer()
        let rect = self.frame
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addArc(withCenter: CGPoint(x: CGFloat(rect.width) - curveHeight, y: rect.height), radius: curveHeight, startAngle: 0, endAngle: 1.5 * CGFloat.pi, clockwise: false)
        path.addLine(to: CGPoint(x: curveHeight, y: rect.height - curveHeight))
        path.addArc(withCenter: CGPoint(x: curveHeight, y: rect.height - (curveHeight * 2.0)), radius: curveHeight, startAngle: 0, endAngle:  CGFloat.pi, clockwise: true)
        path.close()
        curvedLayer.path = path.cgPath
        curvedLayer.fillColor = UIColor.lightBlue.cgColor//UIColor(red: 8/255, green: 95/255, blue: 189/255, alpha: 1.0).cgColor
        curvedLayer.frame = rect
        self.layer.insertSublayer(curvedLayer, at: 0)
    }
    func drawBottomCurve(){
        let offset = CGFloat(self.frame.size.height/2)
                       let bounds = self.bounds

                    let rectBounds = CGRect(x: bounds.origin.x, y: bounds.origin.y  , width:  bounds.size.width, height: bounds.size.height / 2)
                       let rectPath = UIBezierPath(rect: rectBounds)
                       let ovalBounds = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)

                       let ovalPath = UIBezierPath(ovalIn: ovalBounds)
                   rectPath.append(ovalPath)

                       let maskLayer = CAShapeLayer.init()
                       maskLayer.frame = bounds
                       maskLayer.path = rectPath.cgPath
                       self.layer.mask = maskLayer
    }
    func addBackground(width: Float, height: Float, image: UIImage) {
        // screen width and height:
       // let width = UIScreen.mainScreen().bounds.size.width
        //let height = UIScreen.mainScreen().bounds.size.height

        let imageViewBackground = UIImageView(frame: CGRect(x: CGFloat(width/3), y: 0, width: CGFloat(width), height: CGFloat(height)))
        imageViewBackground.image = image

        // you can change the content mode:
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill

        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
    func animateView(){
    self.transform = CGAffineTransform(translationX: 0, y: self.frame.height + 50)
           self.alpha = 0
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping:  0.55, initialSpringVelocity: 1 , options: .curveEaseIn ,animations: {
               self.transform = .identity
               self.alpha = 1
           })
    }
}


