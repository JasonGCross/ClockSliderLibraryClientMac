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
    
    //MARK: - initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.underlyingClockFaceView = CrossPlatformClockFaceView(
            _frame: self.bounds,
            _ringWidth: 44.0,
            _viewModel: ClockFaceViewModel()
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.underlyingClockFaceView = CrossPlatformClockFaceView(
            _frame: self.bounds,
            _ringWidth: 44.0,
            _viewModel: ClockFaceViewModel()
        )
    }
    
    convenience init(_frame: CGRect,
                     _ringWidth: CGFloat,
                     _viewModel: ClockFaceViewModel) {
        self.init(frame: _frame)
        self.underlyingClockFaceView = CrossPlatformClockFaceView(
            _frame: _frame,
            _ringWidth: _ringWidth,
            _viewModel: _viewModel)
    }
    
    //MARK:- drawing
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
