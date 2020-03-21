# sl8v-slider-api
This api is bundled with every slider you load from slidevision and provides easy access for developer to interact with your SlideVision slider.

## Initial Loading
##### sl8v_on_before_loading()
##### sl8v_on_slider_ready()

## sl8v.api
##### sl8v.api.version
##### sl8v.api.container()
##### sl8v.api.slides()

### sl8v.api.transport
##### sl8v.api.transport.index()
##### sl8v.api.transport.count()
##### sl8v.api.transport.next()
##### sl8v.api.transport.prev()
##### sl8v.api.transport.goto(indexFromZero=null)

### sl8v.api.plugins
##### sl8v.api.plugins.get(name)
##### sl8v.api.plugins.getTracking()
##### sl8v.api.plugins.getFormSubmission()
##### sl8v.api.plugins.getSubmissionData()

### sl8v.api.events
##### sl8v.api.events.on(eventName, callback)
