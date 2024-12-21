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
    var underlyingThumbnailView: CrossPlatformThumbnailView?
    
    init(_frame: CGRect,
         _ringWidth: CGFloat,
         _clockRadius: CGFloat,
         _thumnailImage: NSImage? = nil,
         _thumbnailColor: NSColor? = nil) {
        super.init(frame: _frame)
        
        var thumbnailRect = _frame
        let thumnailImage: CGImage? = _thumnailImage?.cgImage(forProposedRect: &thumbnailRect, context: nil, hints: nil)
        let thumbnailColor: CGColor? = _thumbnailColor?.cgColor
        underlyingThumbnailView = CrossPlatformThumbnailView(_frame: _frame,
                                                             _ringWidth: _ringWidth,
                                                             _clockRadius: _clockRadius,
                                                             _thumbnailImage: thumnailImage,
                                                             _thumbnailColor: thumbnailColor)
    }
    
    override init(frame: CGRect) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isFlipped: Bool {
        return true
    }
    
    func setDrawableEndAngle(_ endAngle: CGFloat) {
        underlyingThumbnailView?.drawableEndAngle = endAngle
        self.setNeedsDisplay(self.bounds)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let safeRect = self.bounds
                
        guard let ctx = NSGraphicsContext.current?.cgContext,
              let underlyingView = self.underlyingThumbnailView else {
            return
        }
        
        underlyingView.draw(safeRect, context: ctx)
    }
}
