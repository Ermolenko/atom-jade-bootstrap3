JadeBootstrap3Snippets = require '../lib/jade-bootstrap3-snippets'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "JadeBootstrap3Snippets", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('jade-bootstrap3-snippets')

  describe "when the jade-bootstrap3-snippets:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.jade-bootstrap3-snippets')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'jade-bootstrap3-snippets:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.jade-bootstrap3-snippets')).toExist()

        jadeBootstrap3SnippetsElement = workspaceElement.querySelector('.jade-bootstrap3-snippets')
        expect(jadeBootstrap3SnippetsElement).toExist()

        jadeBootstrap3SnippetsPanel = atom.workspace.panelForItem(jadeBootstrap3SnippetsElement)
        expect(jadeBootstrap3SnippetsPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'jade-bootstrap3-snippets:toggle'
        expect(jadeBootstrap3SnippetsPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.jade-bootstrap3-snippets')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'jade-bootstrap3-snippets:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        jadeBootstrap3SnippetsElement = workspaceElement.querySelector('.jade-bootstrap3-snippets')
        expect(jadeBootstrap3SnippetsElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'jade-bootstrap3-snippets:toggle'
        expect(jadeBootstrap3SnippetsElement).not.toBeVisible()
