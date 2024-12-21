//
//  ClockSliderView.swift
//  ClockSliderLibraryClientMac
//
//  Created by Jason Cross on 2024-10-28.
//

import Foundation
import Cocoa
import ClockSliderLibrary

class ClockSliderView: NSView {
    var underlyingClockSliderView: CrossPlatformClockSliderView?
    private var viewModel: ClockSliderViewModel
    
    init(_frame: CGRect,
         _ringWidth: CGFloat,
         _sliderStartAngle: CGFloat,
         _sliderEndAngle: CGFloat,
         _clockType: ClockType,
         _clockRotationCount: ClockRotationCount) {
        
        let screenScale = NSScreen.main?.backingScaleFactor ?? 1.0
        viewModel = ClockSliderViewModel(
            _frame: _frame,
            _clockType: _clockType,
            _ringWidth: _ringWidth,
            _sliderStartAngle: _sliderStartAngle,
            _sliderEndAngle: _sliderEndAngle,
            _clockRotationCount: _clockRotationCount,
            _screenScale: screenScale)
        underlyingClockSliderView = CrossPlatformClockSliderView(
            viewModel: viewModel)
        
        super.init(frame: _frame)
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
    
    func originForThumbnail(minutes: Int) -> CGPoint {
        return self.viewModel.originForThumbnail(minutes)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let safeRect = self.bounds
                
        guard let ctx = NSGraphicsContext.current?.cgContext,
              let underlyingView = self.underlyingClockSliderView else {
            return
        }
        
        underlyingView.draw(safeRect, context: ctx)
    }
}
