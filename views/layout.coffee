doctype 5
html ->
  head ->
    title 'Claw - Chat with me'
    meta charset: 'utf-8'

    meta(name: 'description', content: @description) if @description?
    link(rel: 'canonical', href: @canonical) if @canonical?

    link rel: 'icon', href: '/favicon.png'
    link rel: 'stylesheet', href: '/app.css'

		script src: '/browserify.js'

  body ->
      header

      div id: 'content', ->
        @body

      footer
