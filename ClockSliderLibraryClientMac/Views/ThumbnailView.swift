//
//  ThumbnailView.swift
//  ClockSliderLibraryClientMac
//
//  Created by Jason Cross on 2024-10-29.
//

import Foundation
import Cocoa
import ClockSliderLibrary

class ThumbnailView: NSView {
    var underlyingThumbnailView: CrossPlatformThumbnailView
    
    //MARK:- initialization
    override init(frame: CGRect) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_frame: CGRect,
         _ringWidth: CGFloat,
         _clockRadius: CGFloat,
         _underlyingThumbnailView: CrossPlatformThumbnailView,
         _thumnailImage: NSImage? = nil,
         _thumbnailColor: NSColor? = nil
    ) {
        var thumbnailRect = _frame
        let thumnailImage: CGImage? = _thumnailImage?.cgImage(forProposedRect: &thumbnailRect, context: nil, hints: nil)
        let thumbnailColor: CGColor? = _thumbnailColor?.cgColor
        underlyingThumbnailView = _underlyingThumbnailView
        underlyingThumbnailView.thumbnailImage = thumnailImage
        underlyingThumbnailView.thumbnailColor = thumbnailColor
        
        super.init(frame: _frame)
    }

    //MARK:- Drawing
    override var isFlipped: Bool {
        return true
    }
    
    func setDrawableEndAngle(_ endAngle: CGFloat) {
        underlyingThumbnailView.drawableEndAngle = endAngle
        self.setNeedsDisplay(self.bounds)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let safeRect = self.bounds
                
        guard let ctx = NSGraphicsContext.current?.cgContext else {
            return
        }
        
        self.underlyingThumbnailView.draw(safeRect, context: ctx)
    }
}
