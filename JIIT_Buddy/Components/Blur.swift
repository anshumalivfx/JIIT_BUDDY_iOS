//
//  Blur.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 11/04/23.
//

import SwiftUI

class UIBackdropView: UIView {
    override class var layerClass: AnyClass {
        NSClassFromString("CABackdropLayer") ?? CALayer.self
        
    }
}


struct BackDrop:UIViewRepresentable {
    func makeUIView(context: Context) -> UIBackdropView {
        UIBackdropView()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct Blur: View {
    var radius : CGFloat = 3
    var opaque : Bool = false
    
    var body: some View {
        BackDrop()
            .blur(radius: radius, opaque: opaque)
    }
}

struct Blur_Previews: PreviewProvider {
    static var previews: some View {
        Blur()
    }
}


struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
