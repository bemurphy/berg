import 'es5-shim'
import 'es6-shim'
import roneo from 'roneo'
import domReady from 'domready'
import viewloader from 'viewloader'
import views from './views'

/**
 * Kick roneo immediately
 */

roneo()

/**
 * Kick things off on domReady
 */
domReady(() => {
  viewloader.execute(views)
})

