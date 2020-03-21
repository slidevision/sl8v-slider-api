window.sl8v = window.sl8v || {}
window.sl8v.api =
  version: '1.0'
  container: -> window.sl8v.formslider.container
  slides:    -> window.sl8v.formslider.slides
  transport:
    index: -> window.sl8v.formslider.index()
    count: -> window.sl8v.formslider.slides.length
    next:  -> window.sl8v.formslider.next()
    prev:  -> window.sl8v.formslider.prev()
    goto:   (indexFromZero) ->
      window.sl8v.formslider.goto parseInt(indexFromZero)

    gotoId: (slideId) ->
      slide = $(".slide-id-#{slideId}", window.sl8v.api.container())
      window.sl8v.formslider.goto slide.index()

    dispatchUrl: ->
      return unless jQuery.url
      window.sl8v.api.transport.goto(index) if index = jQuery.url("?sl8v-goto-index")
      window.sl8v.api.transport.gotoId(id)  if id = jQuery.url("?sl8v-goto-id")

  events:
    on: (eventName, callback) ->
      window.sl8v.formslider.events.on(eventName, callback)

    onReady: ->
      window.sl8v_on_slider_ready() if 'sl8v_on_slider_ready' of window
      window.sl8v.api.transport.dispatchUrl()

    onBeforeLoading: ->
      window.sl8v_on_before_loading() if 'sl8v_on_before_loading' of window

  plugins:
    get: (name) -> window.sl8v.formslider.plugins.get(name)
    getTracking: -> window.sl8v.api.plugins.get('FormsliderTracking')
    getFormSubmission: -> window.sl8v.api.plugins.get('FormSubmission')

    getFormSubmitter: ->
      plugin = window.sl8v.api.plugins.getFormSubmission()
      return plugin.submitter if plugin
      console.warn('sl8v: missing FormSubmission plugin')

    getSubmissionData: (key, fallback) ->
      submitter = window.sl8v.api.plugins.getFormSubmitter()
      return fallback unless submitter

      inputs = submitter.collectInputs()
      return inputs unless key
      return fallback unless key of inputs
      inputs[key]

$(document).on('ready.formslider', '.slidevision-formslider', window.sl8v.api.events.onReady)

window.sl8v.api.events.onBeforeLoading()
