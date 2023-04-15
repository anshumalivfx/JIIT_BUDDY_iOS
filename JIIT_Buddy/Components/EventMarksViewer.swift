//
//  EventMarksViewer.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 15/04/23.
//

import SwiftUI
import PDFKit

struct PDFViewWrapper: UIViewRepresentable {
    
    let data: Data
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: data)
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = PDFDocument(data: data)
    }
}


