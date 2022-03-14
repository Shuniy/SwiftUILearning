//
//  UIViewRepresentableDemo.swift
//  SwiftUILearning
//
//  Created by Shubham Kumar on 01/02/22.
//

import SwiftUI

struct UIViewRepresentableDemo: View {
    //MARK: PROPERTIES
    @State private var text:String = ""
    
    //MARK: BODY
    var body: some View {
        VStack {
            Text("\(text)")
            TextField("Type Here...", text: $text)
                .frame(height:55)
            UITextFieldViewRepresentable(text: $text)
                .frame(height:55)
        }//:VStack
    }//:Body
}

//MARK: PREVIEW
struct UIViewRepresentableDemo_Previews: PreviewProvider {
    static var previews: some View {
        UIViewRepresentableDemo()
    }
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = getTextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    // pass data from UIKit to SwiftUI
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func getTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        let placeHolder = NSAttributedString(
            string:"Type Here...",
            attributes: [
                .foregroundColor:UIColor.red
            ]
        )
        textField.attributedPlaceholder = placeHolder
        return textField
    }
    
    // pass data from SwiftUI to UIKit
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding  var text: String

        init(text: Binding<String>){
            self._text = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
    
}
