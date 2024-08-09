# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "jquery", to: "https://code.jquery.com/jquery-3.6.0.min.js", preload: true
pin "jquery_ujs", to: "https://cdn.jsdelivr.net/npm/jquery-ujs@1.2.3/src/rails.min.js", preload: true
pin "layout", to: "layout.js"