window.sl8v = window.sl8v || {}
window.sl8v.api =
  version: '1.4'
  container: -> window.sl8v.formslider.container
  slides:    -> window.sl8v.formslider.slides
  url: (input) ->
    return jQuery.url(input) if jQuery.url
    console.error('sl8v.api: js-url not laoded')

  cookie:
    get: (name=null) ->
      return Cookies.get(name) if Cookies
      console.error('sl8v.api: js-ccokies not laoded')

    set: (name, value, options={}) ->
      return Cookies.set(name, value, options) if Cookies
      console.error('sl8v.api: js-ccokies not laoded')

  transport:
    index: -> window.sl8v.formslider.index()
    count: -> window.sl8v.formslider.slides.length
    next:  -> window.sl8v.formslider.next()
    prev:  -> window.sl8v.formslider.prev()
    goto:   (indexFromZero) ->
      window.sl8v.formslider.goto(parseInt(indexFromZero))

    gotoId: (slideId) ->
      slide = $(".slide-id-#{slideId}", window.sl8v.api.container())
      window.sl8v.formslider.goto(slide.index()) if slide

    _dispatchUrl: ->
      window.sl8v.api.transport.goto(index) if index = sl8v.api.url('?sl8v-goto-index')
      window.sl8v.api.transport.gotoId(id)  if id    = sl8v.api.url('?sl8v-goto-id')

  events:
    on:  (name, callback, context = 'global') ->
      window.sl8v.formslider.events.on("#{name}.#{context}", callback)

    off: (name, context = 'global') ->
      window.sl8v.formslider.events.off("#{name}.#{context}")

    _onReady: ->
      window.sl8v.api.transport._dispatchUrl()
      if window.Sl8vLeadUuid && !window.leadUuid
        window.leadUuid                 = new Sl8vLeadUuid()
        window.trackingUuid             = new Sl8vTrackingUuid()
        window.trackingEntranceUrl      = new Sl8vTrackingEntranceUrl()
        window.trackingEntranceRefferer = new Sl8vTrackingEntranceRefferer()

      window.sl8v.formslider.events.trigger('api.ready.formslider')
      window.sl8v.formslider.container.trigger('api.ready.formslider')
      window.sl8v_on_slider_ready() if 'sl8v_on_slider_ready' of window

    _onBeforeLoading: ->
      window.sl8v_on_before_loading() if 'sl8v_on_before_loading' of window

  plugins:
    get: (name) -> window.sl8v.formslider.plugins.get(name)
    _getFormSubmitter: ->
      plugin = window.sl8v.api.plugins.get('FormSubmission')
      return plugin.submitter if plugin
      console.warn('sl8v.api: missing FormSubmission plugin')
      false

  submission:
    inject: (name, value, triggerTrackEvent = false) ->
      trackerPlugin = window.sl8v.api.plugins.get('TrackSessionInformation')
      trackerPlugin.inform(name, value, triggerTrackEvent)

      replacePlugin = window.sl8v.api.plugins.get('ContentReplace')
      replacePlugin.config.mappings["{{#{name}}}"] = value if replacePlugin

    get: (key, fallback = undefined) ->
      submitter = window.sl8v.api.plugins._getFormSubmitter()
      return fallback unless submitter

      inputs = submitter.collectInputs()
      return inputs unless key
      return fallback unless key of inputs
      inputs[key]

$(document).on('ready.formslider', '.slidevision-formslider', window.sl8v.api.events._onReady)

window.sl8v.api.events._onBeforeLoading()
