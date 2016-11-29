//
//  AILine.swift
//  AIVeris
//
//  Created by 王坜 on 16/8/18.
//  Copyright © 2016年 ___ASIAINFO___. All rights reserved.
//

import UIKit

class AILine: UIView {

    //MARK: Constants


    //MARK: Properties
    var isDotted: Bool!
    var lineColor: UIColor!
    //MARK: init

    init(frame: CGRect, color: UIColor, dotted: Bool) {
        super.init(frame: frame)
        lineColor = color
        isDotted = dotted
        self.backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }




    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.beginPath()

        if isDotted == true {
            let lengths: [CGFloat] = [3, 3]
            context.setLineDash(phase: 0, lengths: lengths)
            context.setLineCap(.round)

        }

        context.setStrokeColor(lineColor.cgColor)
        context.setLineWidth(rect.height)


        if isDotted == false {
            context.stroke(rect, width: rect.width)
        }

        context.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.strokePath()
    }



}
