JadeBootstrap3SnippetsView = require './jade-bootstrap3-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = JadeBootstrap3Snippets =
  jadeBootstrap3SnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @jadeBootstrap3SnippetsView = new JadeBootstrap3SnippetsView(state.jadeBootstrap3SnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @jadeBootstrap3SnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'jade-bootstrap3-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @jadeBootstrap3SnippetsView.destroy()

  serialize: ->
    jadeBootstrap3SnippetsViewState: @jadeBootstrap3SnippetsView.serialize()

  toggle: ->
    console.log 'JadeBootstrap3Snippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
