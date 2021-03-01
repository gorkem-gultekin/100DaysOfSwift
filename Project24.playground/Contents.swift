import UIKit

var str = "Hello, playground"

print(str[str.index(str.startIndex, offsetBy: 3)])

let password = "12345"

password.hasPrefix("123")
password.hasSuffix("5")
let languages = ["Python","Ruby","Swift"]
let input = "Swift is like Objective-C without the C"

languages.contains(where: input.contains)

let attributes: [NSAttributedString.Key:Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]
//let attributedString = NSAttributedString(string: input, attributes: attributes)


let attributedString = NSMutableAttributedString(string: input)
attributedString.addAttribute(.font, value:  UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))

extension String{
    func withPrefix(_ prefix: String) ->String{
        if self.contains(prefix) {return self} else {return prefix + " " + self}
    }
    func isNumberic()-> Bool{
        if Double(self) == nil {return false} else {return true}
    }
    var lines: [String.SubSequence] {self.split(separator: " ")}
}

"deneme".withPrefix("den")
"deneme".withPrefix("123")
"123".isNumberic()
"asd123".isNumberic()
"swift php sql".lines

extension Int{
    var isOdd: Bool{
        return !self.isMultiple(of: 2)
    }
    var isEven: Bool{
        return self.isMultiple(of: 2)
    }
    var bolunme: Bool{
        if self % 2 == 0{
            return true
        }else{
        return false
        }
    }
    func times(_ closure: () -> Void) {
        guard self > 0 else {return}
        for _ in 0 ..< self{
            closure()
        }
    }
}
12.isOdd
12.isEven
13.bolunme

5.times{print("asdasd")}


