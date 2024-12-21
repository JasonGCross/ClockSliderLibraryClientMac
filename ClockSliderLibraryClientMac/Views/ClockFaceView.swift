//
//  ClockFaceView.swift
//  ClockSliderLibraryClientMac
//
//  Created by Jason Cross on 2024-10-27.
//

import Foundation
import Cocoa
import ClockSliderLibrary

class ClockFaceView: NSView {
    var underlyingClockFaceView: CrossPlatformClockFaceView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.underlyingClockFaceView = CrossPlatformClockFaceView(_frame: self.bounds, _ringWidth: 44.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.underlyingClockFaceView = CrossPlatformClockFaceView(_frame: self.bounds, _ringWidth: 44.0)
    }
    
    override var isFlipped: Bool {
        return true
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let safeRect = self.bounds
                
        guard let ctx = NSGraphicsContext.current?.cgContext,
              let underlyingView = self.underlyingClockFaceView else {
            return
        }
        
        underlyingView.draw(safeRect, context: ctx)
    }
}
