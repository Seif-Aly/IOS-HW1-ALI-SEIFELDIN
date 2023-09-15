import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var view3: UIView!
    
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonWasPressed(_ sender: UIButton) {
        disableButtonDuringAnimation()
        randomizeColors()
    }
    
    func randomizeColors() {
        view1.layer.cornerRadius = .random(in: 0...40)
        view2.layer.cornerRadius = .random(in: 0...40)
        view3.layer.cornerRadius = .random(in: 0...40)
        
        animateColorChange(view1,view2,view3)
    }
    
    func getUniqueColor() -> UIColor {
        let randomHexColor = String(format: "#%06X", arc4random_uniform(0xFFFFFF))
        if let color = UIColor(hex: randomHexColor) {
            return color
        }
        return UIColor.white
    }
    
    func animateColorChange(_ view1: UIView, _ view2: UIView, _ view3: UIView) {
        UIView.animate(withDuration: 3.0, animations: {
            view1.backgroundColor = self.getUniqueColor()
        }, completion: { [weak self] _ in
            UIView.animate(withDuration: 2.0, animations: {
                view2.backgroundColor = self?.getUniqueColor()
            }, completion: { _ in
                UIView.animate(withDuration: 3.0, animations: {
                    view3.backgroundColor = self?.getUniqueColor()
                }, completion: { _ in
                    self?.button.isEnabled = true
                })
            })
        })
    }
    
    func disableButtonDuringAnimation() {
        button.isEnabled = false
    }
    
}

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
