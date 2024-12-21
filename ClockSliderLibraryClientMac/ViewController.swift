//
//  ViewController.swift
//  ClockSliderLibraryClientMac
//
//  Created by Jason Cross on 2024-10-27.
//

import Cocoa
import ClockSliderLibrary

class ViewController: NSViewController {
    
    @IBOutlet weak var customViewContainer: NSView!
    var timeRangeSliderControl: TimeRangeSliderControl!
    var clockFaceView: ClockFaceView!
    var clockSliderView: ClockSliderView!
    var startKnobView: ThumbnailView!
    var finishKnobView: ThumbnailView!
    let ringWidth: CGFloat = 44.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sliderStartAngle = 0.0
        let sliderEndAngle = Double.pi/4
        
        self.clockFaceView = ClockFaceView(frame: customViewContainer.bounds)
        self.clockSliderView = ClockSliderView(
            _frame: self.customViewContainer.bounds,
            _ringWidth: ringWidth,
            _sliderStartAngle: sliderStartAngle,
            _sliderEndAngle: sliderEndAngle,
            _clockType: ClockType.twelveHourClock,
            _clockRotationCount: ClockRotationCount.first)
        
        let diameter = CGFloat(fminf(Float(view.frame.size.width),
                                     Float(view.frame.size.height)))
        let clockRadius = diameter / 2.0
        let startThumbnailOrigin = self.clockSliderView.originForThumbnail(minutes:0)
        let startThumbnailFrame = CGRect(x: startThumbnailOrigin.x, y: startThumbnailOrigin.y, width: ringWidth, height: ringWidth)
        
        self.startKnobView = ThumbnailView.init(_frame: startThumbnailFrame,
                                                _ringWidth: ringWidth,
                                                _clockRadius: clockRadius,
                                                _thumbnailColor: NSColor.red)
        self.startKnobView.setDrawableEndAngle(sliderStartAngle)
        
        let finishThumbnailOrigin = self.clockSliderView.originForThumbnail(minutes:90)
        let finishThumbnailFrame = CGRect(x: finishThumbnailOrigin.x, y: finishThumbnailOrigin.y, width: ringWidth, height: ringWidth)
        self.finishKnobView = ThumbnailView.init(_frame: finishThumbnailFrame,
                                                 _ringWidth: ringWidth,
                                                 _clockRadius: clockRadius,
                                                 _thumbnailColor: NSColor.green)
        self.finishKnobView.setDrawableEndAngle(sliderEndAngle)
        
        timeRangeSliderControl = TimeRangeSliderControl(frame: customViewContainer.bounds)
        self.customViewContainer.addSubview(timeRangeSliderControl)
        
        self.timeRangeSliderControl.addSubview(self.clockFaceView)
        self.timeRangeSliderControl.addSubview(self.clockSliderView)
        self.timeRangeSliderControl.addSubview(self.startKnobView)
        self.timeRangeSliderControl.addSubview(self.finishKnobView)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

