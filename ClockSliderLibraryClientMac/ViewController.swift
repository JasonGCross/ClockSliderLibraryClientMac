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
        
        // change these 2 values to change the UI
        let sliderStartAngle = 0.0
        let sliderEndAngle = (3.0 / 2.0) * Double.pi
        let clockType = ClockType.twentyFourHourClock
        
        // all these are calculated based on above
        let startMinutes = Int(clockType.minutesFromAngle(sliderStartAngle))
        let endMinutes = Int(clockType.minutesFromAngle(sliderEndAngle))
        let sliderStartTime =  TimeOfDayModel.timeModelFromMinutes(startMinutes)
        let sliderEndTime = TimeOfDayModel.timeModelFromMinutes(endMinutes)
        
        timeRangeSliderControl = TimeRangeSliderControl(
            _frame: customViewContainer.bounds,
            _ringWidth: ringWidth,
            _clockType: clockType,
            _timeOfDay: TimeOfDayModel.now,
            _sliderStartTime: sliderStartTime,
            _sliderEndTime: sliderEndTime)
        self.customViewContainer.addSubview(timeRangeSliderControl)
        
        timeRangeSliderControl.clockContainerBackgroundColor = .systemGray
        timeRangeSliderControl.clockFaceBackgroundColor = .white
        timeRangeSliderControl.clockFaceHandsColor = .black
        timeRangeSliderControl.clockFaceTickMarkColor = .black
        timeRangeSliderControl.clockFaceTextColor = .black
        
        //timeRangeSliderControl.setNeedsDisplay(timeRangeSliderControl.bounds)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

