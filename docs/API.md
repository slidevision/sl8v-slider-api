# sl8v-slider-api
This api is bundled with every slider you load from slidevision and provides easy access for developer to interact with your SlideVision slider.

## Initial Loading
#### sl8v_on_before_loading()
If the method `sl8v_on_before_loading` is defined in the context of `window` this method will be called * before the SlideVision slider gets initialized

#### sl8v_on_slider_ready()
If the method `sl8v_on_slider_ready` is defined in the context of `window` this method will be called:
* after the SlideVision slider is initialized
* before the SlideVision slider shows up in the page

If you want to listen by your own you can do:
```javascript
$(document).on('ready.formslider', '.slidevision-formslider', function(){
  console.log('SlideVision slider is ready');
});
```

## sl8v.api
#### sl8v.api.version
Current version of the sl8v slider api.

#### sl8v.api.container()
The container the SlideVision slider is initialized on.

Most the time is `$('.slidevision-formslider')`.

#### sl8v.api.slides()
This method returns object of the slides with the index as key and the div as value.

You can iterate over the  slides by doing the following:
```javascript
$(sl8v.api.slides()).each(function(index, slide){
  var slideId = $(slide).data('id');
  console.log(slideId);
});
```

#### sl8v.api.url(input)
This is a proxy method to the `js-url` api to access url parameters.
* https://github.com/websanova/js-url

### sl8v.api.transport
#### sl8v.api.transport.index()
Return the current slide index.

#### sl8v.api.transport.count()
Returns the amount of slides.

#### sl8v.api.transport.next()
Triggeres transition to the next slide.

This action will maybe not executed if an input field of the current slide has an validation error for example.

#### sl8v.api.transport.prev()
Triggeres transition to the previous slide.

#### sl8v.api.transport.goto(indexFromZero)
Triggers transition to a certain slide on a zero based index.

This action will maybe not executed if an input field of the current slide has an validation error for example.

#### sl8v.api.transport.gotoId(slideId)
Triggers transition to a certain slide based on the slide id.

This action will maybe not executed if an input field of the current slide has an validation error for example.

### sl8v.api.plugins
#### sl8v.api.plugins.get(name)
Returns a plugin loaded from the SlideVision slider or undefined if not loaded.

### sl8v.api.submission
#### sl8v.api.submission.get(key, fallback = undefined)
Returns all or a certain value of the lead data that gets submitted.

If you specify a `key` and key is not in the store the `fallback` value will be returned.

Expects a `Form-Submission Create` or `Form-Submission Lead-Mailer` plugin to be configured with the slider.

#### sl8v.api.submission.inject(key, value, triggerTrackEvent = false)
This method makes it possible to store data in the lead submission data store.

The `triggerTrackEvent` indicates if this `key` and `value` should be triggered to the configured tracking backends (Google-Tag-Manager, Facebook etc.)

### sl8v.api.events
The event manager is a light weight but powerful event pub/sub implementation.

An event is created by triggering a string (eventName). `before.leaving.question` for example.

The event in this case is `before`, `leaving` and `question` are tags.

So it is possible to listen for some of the events:
  * `before`
  * `before.leaving`
  * `before.question`
  * `before.leaving.question`
  * `before.question.leaving`

You can not! listen for tags. The following will not be triggered:
  * `leaving`
  * `question`
  * `leaving.question`
  * `question.leaving`

#### sl8v.api.events.on(name, callback, context='global')
Registers an event listener.

The `name` parameter has the following semantic:

`name[.tag1.tag2.tag3]`

Possible pre define event names in chronoloical order:
```bash
  * `ready`                         # fired when slider is ready
  * `resize`                        # fired when page is resized
  * `first-interaction`             # fired after first transition
  * `leaving`                       # fired before going to the next slide, can stop transition
  * `leaving.[currentRole]`         # currentRole it the role of the slide, a plugin can listen only listen for `leaving.zipcode`
  * `leaving.[currentRole].next`    # same as above but only when direction forward
  * `leaving.[currentRole].prev`    # same as above but only when direction backward
  * `before`                        # fired after leaving, when transition is allowed
  * `before.[nextRole]`             # role of the up comming slide
  * `before.[nextRole].next`        # same as above but only when direction forward
  * `before.[nextRole].prev`    # same as above but only when direction backward
  * `after`                         # fired after the transition
  * `after.[currentRole]`           # role of the current slide
  * `after.[currentRole].next`        # same as above but only when direction forward
  * `after.[currentRole].prev`    # same as above but only when direction backward
```

#### sl8v.api.events.off(name, context='global')
Deregister an event listener.

The `name` parameter has the following semantic:

`name[.tag1.tag2.tag3]`
