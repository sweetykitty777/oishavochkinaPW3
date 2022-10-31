//
//  ColorPaletteView.swift
//  oishavochkinaPW2
//
//  Created by Olga on 29.10.2022.
//

import Foundation
import UIKit

final class ColorPaletteView: UIControl {
    private let stackView = UIStackView()
    var delegate:  ViewControllerProtocol?
    private(set) var chosenColor: UIColor = .systemGray6
    init() {
        super.init(frame: .zero)
        setupView()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        let redControl = ColorSliderView(colorName: "R", value:
                                            Float(chosenColor.redComponent))
        let greenControl = ColorSliderView(colorName: "G", value:
                                            Float(chosenColor.greenComponent))
        let blueControl = ColorSliderView(colorName: "B", value:
                                            Float(chosenColor.blueComponent))
        redControl.tag = 0
        greenControl.tag = 1
        blueControl.tag = 2
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(redControl)
        stackView.addArrangedSubview(greenControl)
        stackView.addArrangedSubview(blueControl)
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 12
        [redControl, greenControl, blueControl].forEach {
            $0.addTarget(self, action: #selector(sliderMoved(slider:)),
                         for: .touchDragInside)
        }
         addSubview(stackView)
      //  stackView.pinTop(to: self, 0)
     //   stackView.pin(to: self)
     //   delegate?.changeColor()(self.sliderMoved(slider: stackView.redControl.touchDr)
        stackView.pinTop(to: self, 0)
        stackView.pinBottom(to: self, 0)
       stackView.pinLeft(to: self, 0)
        stackView.pinRight(to: self, 0)
    }
    @objc
    private func sliderMoved(slider: ColorSliderView) {
        delegate?.changeColor(self)
        switch slider.tag {
        case 0:
            self.chosenColor = UIColor(
                red: CGFloat(slider.value),
                green: chosenColor.greenComponent,
                blue: chosenColor.blueComponent,
                alpha: chosenColor.alphaComponent
            )
        case 1:
            self.chosenColor = UIColor(
                red: chosenColor.redComponent,
                green: CGFloat(slider.value),
                blue: chosenColor.blueComponent,
                alpha: chosenColor.alphaComponent
            )
        default:
            self.chosenColor = UIColor(
                red: chosenColor.redComponent,
                green: chosenColor.greenComponent,
                blue: CGFloat(slider.value),
                alpha: chosenColor.alphaComponent
            )
        }
        sendActions(for: .touchDragInside)
    }
    public func setColors(colorRed: CGFloat?, colorGreen: CGFloat?, colorBlue: CGFloat?) {
        //  stackView.
    }
}

extension ColorPaletteView {
    private final class ColorSliderView: UIControl {
        private let slider = UISlider()
        private let colorLabel = UILabel()
        private(set) var value: Float
        init(colorName: String, value: Float) {
            self.value = value
            super.init(frame: .zero)
            slider.value = value
            colorLabel.text = colorName
            setupView()
            slider.addTarget(self, action: #selector(sliderMoved(_:)), for: .touchDragInside) //?
        }
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        private func setupView() {
            let stackView = UIStackView(arrangedSubviews:
                                            [colorLabel, slider])
            stackView.axis = .horizontal
            stackView.spacing = 8
            addSubview(stackView)
          //  stackView.pin(to: self, [.left: 12, .top: 12, .right: 12, .bottom: 12])
             stackView.pinTop(to: self, 12)
              stackView.pinLeft(to: self, 12)
               stackView.pinRight(to: self, 12)
              stackView.pinBottom(to: self, 12)
              // stackView.pin(to: self, [.left: 12, .top: 12, .right:
              //       12, .bottom: 12])
        }
        @objc
        private func sliderMoved(_ slider: UISlider) {
            self.value = slider.value
            sendActions(for: .touchDragInside)
        }
    }
}
extension UIColor {
    var redComponent: CGFloat{
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return red
    }
    
    var greenComponent: CGFloat{
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return green
    }
    
    var blueComponent: CGFloat{
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return blue
    }
    
    var alphaComponent: CGFloat{
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return alpha
    }
}
