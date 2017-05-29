//
//  ViewController.swift
//  spinBall
//
//  Created by Kien Nguyen Duc on 5/25/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var ball = UIImageView()
    var radians = CGFloat()
    var ballRadius = CGFloat()
    var rotate: CGFloat!
    var time = Timer()
    var right: Bool = true
    var direction: CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotate = 0
        direction = 1
        addBall()
        changDirection()
        time = Timer.scheduledTimer(timeInterval: 0.009, target: self, selector: #selector(check) , userInfo: nil, repeats: true)
    }
    
    func addBall(){
        
        // thêm quả bóng vào toạ độ trên màn hình
        let mainViewSize = self.view.bounds.size
        ball = UIImageView(frame: CGRect(x: 0, y: view.bounds.size.height/2, width: 64, height: 64))
        ball.image = UIImage(named: "ball.png")
        ballRadius = 32.0
        ball.center = CGPoint(x: ballRadius ,y: mainViewSize.height * 0.5  )
        self.view.addSubview(ball)
    }
    
    func rollBall(){
        
        let deltaAngle: CGFloat = 0.1
        rotate = rotate + 0.1
        self.ball.transform = CGAffineTransform(rotationAngle:self.rotate)
        ball.center = CGPoint(x: ball.center.x + ballRadius * deltaAngle, y: self.ball.center.y + ballRadius * deltaAngle * direction)
        if (ball.center.x >= view.bounds.size.width - ballRadius )
        {
            right = false
        }
    }
    
    func fliprollBall() {
        
        let deltaAngle: CGFloat = -0.1
        rotate = rotate + deltaAngle
        self.ball.transform = CGAffineTransform(rotationAngle:rotate)
        ball.center = CGPoint(x: ball.center.x + ballRadius * deltaAngle , y: self.ball.center.y - ballRadius*deltaAngle*direction)
        
        if (ball.center.x < ballRadius ) // Nếu quả bóng chạm mép phải màn hình thì quay ngược lại
        {
            right = true
        }
    }
    
    func check() {
        if (right ){
            rollBall()
            changDirection()
        } else {
            fliprollBall()
            changDirection()
        }
    }
    
    func makeRandom() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
    
    func changDirection() {
        
        let dic = makeRandom()
        
        if ball.center.y > view.bounds.size.height - ballRadius {
            direction = -dic
        }
        else if ball.center.y <  ballRadius {
            direction = dic
        }
    }
    
}








