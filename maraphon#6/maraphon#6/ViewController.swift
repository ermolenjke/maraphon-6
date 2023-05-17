//
//  ViewController.swift
//  maraphon#6
//
//  Created by Даниил Ермоленко on 16.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var squareView = UIView()
    var snap: UISnapBehavior?
    var animator = UIDynamicAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupSquareView()
        createGestureRecognizer()
        createAnimatorandBehavior()
    }
    
    func setupSquareView() {
        
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        squareView.center = view.center
        squareView.backgroundColor = .systemBlue
        squareView.layer.cornerRadius = 10
        
        view.addSubview(squareView)
    }
    
    func createGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tap)
    }
    
    func createAnimatorandBehavior() {
        animator = UIDynamicAnimator(referenceView: view)
        let collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        snap = UISnapBehavior(item: squareView, snapTo: squareView.center)
        snap?.damping = 0.9
        animator.addBehavior(snap!)
        
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        let tapPoint: CGPoint = sender.location(in: view)
        
        if (snap != nil) {
            animator.removeBehavior(snap!)
        }
        snap = UISnapBehavior(item: squareView, snapTo: tapPoint)
        snap?.damping = 0.9
        animator.addBehavior(snap!)
    }
}
