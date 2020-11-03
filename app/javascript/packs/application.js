// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
import jQuery from 'jquery'

window.$ = jQuery
window.jQuery = jQuery

// ------------------
//     CSS
// --------------------
import "../stylesheets/application"

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

// ------------------
//      JS
// --------------------
import 'bootstrap'

// TEMPLATE JS
require("template/jquery-ui.min")
require("template/jquery.countdown.min")
require("template/jquery.nice-select.min")
require("template/jquery.zoom.min")
require("template/jquery.dd")
require("template/jquery.slicknav")
require("template/owl.carousel.min")
require("template/main")

// APPLICATION JS
require("template/custom")
