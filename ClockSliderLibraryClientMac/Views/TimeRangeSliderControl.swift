//
//  TimeRangeSliderControl.swift
//  ClockSliderLibraryClientMac
//
//  Created by Jason Cross on 2024-10-29.
//

import AppKit
import ClockSliderLibrary

class TimeRangeSliderControl: NSControl {
    var underlyingTimeRangeSliderControl: CrossPlatformTimeRangeSliderControl?
    
    //MARK:- subviews
    var clockFaceView : ClockFaceView?
    var clockSliderView: ClockSliderView?
    var startKnobView: ThumbnailView?
    var finishKnobView: ThumbnailView?
    
    //MARK:- initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:- helpers
    convenience init(
        _frame: CGRect,
        _ringWidth: CGFloat,
        _clockType: ClockType,
        _timeOfDay: TimeOfDayModel,
        _sliderStartTime: TimeOfDayModel,
        _sliderEndTime: TimeOfDayModel) {
            self.init(frame: _frame)
            
            self.underlyingTimeRangeSliderControl = CrossPlatformTimeRangeSliderControl(
                _frame: _frame,
                _ringWidth: _ringWidth,
                _clockType: _clockType,
                _timeOfDay: _timeOfDay,
                _sliderStartTime: _sliderStartTime,
                _sliderEndTime: _sliderEndTime)
            
            // the inner circle with the hands, ticks, and numbers
            let clockFaceViewModel = self.underlyingTimeRangeSliderControl!.viewModel.clockFaceViewModel
            let clockFaceView = ClockFaceView(
                _frame: _frame,
                _ringWidth: _ringWidth,
                _viewModel: clockFaceViewModel)
            self.addSubview(clockFaceView)
            self.clockFaceView = clockFaceView
        
            // the outer ring with a track for sliding
            let (startAngle, finishAngle) = self.underlyingTimeRangeSliderControl!.viewModel.calculateSliderStartAndFinishAngles()
            let clockSliderView = ClockSliderView(
                _frame: _frame,
                _ringWidth: _ringWidth,
                _sliderStartAngle: startAngle,
                _sliderEndAngle: finishAngle,
                _clockType: _clockType,
                _clockRotationCount: .first)
            self.addSubview(clockSliderView)
            self.clockSliderView = clockSliderView
            
            // the sliders along the track
            let diameter = CGFloat(fminf(Float(frame.size.width),
                                         Float(frame.size.height)))
            let clockRadius = diameter / 2.0
            let startThumbnailOrigin = clockSliderView.originForThumbnail(minutes:_sliderStartTime.totalMinutes)
            let startThumbnailFrame = CGRect(x: startThumbnailOrigin.x, y: startThumbnailOrigin.y, width: _ringWidth, height: _ringWidth)
            let startKnobView = ThumbnailView(
                _frame: startThumbnailFrame,
                _ringWidth: _ringWidth,
                _clockRadius: clockRadius,
                _thumbnailColor: NSColor.red
            )
            
            self.addSubview(startKnobView)
            self.startKnobView = startKnobView
            self.startKnobView?.setDrawableEndAngle(startAngle)
        
            let finishThumbnailOrigin = clockSliderView.originForThumbnail(minutes:_sliderEndTime.totalMinutes)
            let finishThumbnailFrame = CGRect(x: finishThumbnailOrigin.x, y: finishThumbnailOrigin.y, width: _ringWidth, height: _ringWidth)
            let finishKnobView = ThumbnailView(
                _frame: finishThumbnailFrame,
                _ringWidth: _ringWidth,
                _clockRadius: clockRadius,
                _thumbnailColor: NSColor.green
            )
            self.addSubview(finishKnobView)
            self.finishKnobView = finishKnobView
            self.finishKnobView?.setDrawableEndAngle(finishAngle)
    }
    
    internal func updateThumbLayers() -> Void {
//        fatalError("updateThumbLayers() not implemented")
    }
    
    //MARK: - drawing
    //*************************************************************************
    
    override var isFlipped: Bool {
        return true
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let safeRect = self.bounds
                
        guard let ctx = NSGraphicsContext.current?.cgContext,
              let underlyingView = self.underlyingTimeRangeSliderControl else {
            return
        }
        
        underlyingView.draw(safeRect, context: ctx)
        // the slider and the thumbs
        self.clockSliderView?.setNeedsDisplay(self.bounds)
        self.updateThumbLayers()
    }
}
