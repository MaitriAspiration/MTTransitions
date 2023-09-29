//
//  PickImageTransitionViewController.swift
//  MTTransitionsDemo
//
//  Created by xu.shuifeng on 2020/4/9.
//  Copyright © 2020 xu.shuifeng. All rights reserved.
//

import UIKit
import MetalPetal
import MTTransitions

class PickImageTransitionViewController: UIViewController {

    private var imageView: MTIImageView!
    
    private var nameLabel: UILabel!
    
    private var pickButton: UIButton!
    
    private var fromImage: MTIImage!
    private var toImage: MTIImage!
    
    private var effect: MTTransition.Effect = .angular
    var displayTime:Double = 0.0
    var videoDuration:Double = 0.0

    var transition: MTTransition!
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureImages()
        configureSubviews()
        transition = effect.transition
        doTransition()
    }
    
    private func configureImages() {
        func loadImage(named: String) -> MTIImage {
            let imageUrl = Bundle.main.url(forResource: named, withExtension: "jpg")!
            return MTIImage(contentsOf: imageUrl, options: [.SRGB: false])!.oriented(.downMirrored)
        }
        fromImage = loadImage(named: "1")
        toImage = loadImage(named: "2")
    }

    private func configureSubviews() {
        imageView = MTIImageView(frame: .zero)
        imageView.image = fromImage.oriented(.downMirrored)
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 512.0/400),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -60)
        ])
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        ])
        
        pickButton = UIButton(type: .system)
        pickButton.setTitle("Pick A Transition", for: .normal)
        view.addSubview(pickButton)
        
        pickButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickButton.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 30),
            pickButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        pickButton.addTarget(self, action: #selector(handlePickButtonClicked), for: .touchUpInside)
        startTimer()
    }
    
    private func doTransition() {
        transition.duration = 2.0
        
        if effect == .BiLinear {
            transition.imgName = "bilinear-lateral"
        } else if effect == .ConicalAsym {
            transition.imgName = "conical-asym"
        } else if effect == .ConicalSym {
            transition.imgName = "conical-sym"
        } else if effect == .LinearAawtoothLateral {
            transition.imgName = "linear-sawtooth-lateral-4"
        } else if effect == .RadialTriLateral {
            transition.imgName = "radial-tri-lateral-4"
        } else if effect == .RadialTriLateralReverse {
            transition.imgName = "radial-tri-lateral-5"
        } else if effect == .Spiral1 {
            transition.imgName = "spiral-1"
        } else if effect == .Spiral2 {
            transition.imgName = "spiral-2"
        } else if effect == .Spiral3 {
            transition.imgName = "spiral-3"
        } else if effect == .Square {
            transition.imgName = "square"
        } else if effect == .DispCurious {
            transition.imgName = "disp"
        } else if effect == .DispCurious1 {
            transition.imgName = "disp1"
        }  else if effect == .DispCurious2 {
            transition.imgName = "disp2"
        } else if effect == .DispCurious3 {
            transition.imgName = "disp3"
        } else if effect == .DispCurious4 {
            transition.imgName = "disp4"
        } else if effect == .DispCurious5 {
            transition.imgName = "671-v7"
        } else if effect == .DispCurious6 {
            transition.imgName = "671-v6"
        }  else if effect == .DispCurious7 {
            transition.imgName = "671-v5"
        } else if effect == .DispCurious8 {
            transition.imgName = "671-v3"
        } else if effect == .DispCurious9 {
            transition.imgName = "671-v2"
        } else if effect == .DispCurious10 {
            transition.imgName = "3d-cnoise"
        } else if effect == .DispCurious11 {
            transition.imgName = "cellnoise-00"
        } else if effect == .DispCurious12 {
            transition.imgName = "triangle-making"//"rect-df"
        }


        transition.transition(from: fromImage, to: toImage, updater: { [weak self] image in
            self?.imageView.image = image
        }, completion: nil)
        
        let name = NSStringFromClass(transition.classForCoder).replacingOccurrences(of: "MTTransitions.", with: "")
        nameLabel.text = name
    }
    
    @objc private func handlePickButtonClicked() {
        timer?.invalidate()
        timer = nil
        let pickerVC = TransitionsPickerViewController()
        pickerVC.selectionUpdated = { [weak self] effect in
            guard let self = self else { return }
            self.effect = effect
            self.transition = effect.transition
            self.doTransition()
            self.startTimer()
        }
        let nav = UINavigationController(rootViewController: pickerVC)
        present(nav, animated: true, completion: nil)
    }
    
    func startTimer() {
        self.displayTime = 0.0
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.timerValueUpdate), userInfo: nil, repeats: true)
    }

    @objc func timerValueUpdate() {
        print(self.displayTime)
        if self.displayTime >= 1 {
            self.displayTime = 0
            timer?.invalidate()
            timer = nil
        } else {
            self.displayTime += (0.05/2.0)
        }
        self.transition?.timerFired(displayTime: self.displayTime, isStop: false)
        if self.videoDuration > 2.0 {
        } else {
            self.videoDuration += (0.05)
        }
    }
}
