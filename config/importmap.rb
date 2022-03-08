# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

pin_all_from "app/javascript/components", under: "components"
pin "htm", to: "https://ga.jspm.io/npm:htm@3.1.0/dist/htm.module.js"
pin "react", to: "https://ga.jspm.io/npm:react@17.0.2/index.js"
pin "react-dom", to: "https://ga.jspm.io/npm:react-dom@17.0.2/index.js"
pin "object-assign", to: "https://ga.jspm.io/npm:object-assign@4.1.1/index.js"
pin "scheduler", to: "https://ga.jspm.io/npm:scheduler@0.20.2/index.js"
pin "@apollo/client", to: "https://ga.jspm.io/npm:@apollo/client@3.5.8/index.js"
pin "@wry/context", to: "https://ga.jspm.io/npm:@wry/context@0.6.1/lib/context.esm.js"
pin "@wry/equality", to: "https://ga.jspm.io/npm:@wry/equality@0.5.1/lib/equality.esm.js"
pin "@wry/trie", to: "https://ga.jspm.io/npm:@wry/trie@0.3.1/lib/trie.esm.js"
pin "graphql", to: "https://ga.jspm.io/npm:graphql@16.3.0/index.mjs"
pin "graphql-tag", to: "https://ga.jspm.io/npm:graphql-tag@2.12.6/lib/index.js"
pin "optimism", to: "https://ga.jspm.io/npm:optimism@0.16.1/lib/bundle.cjs.js"
pin "symbol-observable", to: "https://ga.jspm.io/npm:symbol-observable@4.0.0/lib/index.js"
pin "ts-invariant", to: "https://ga.jspm.io/npm:ts-invariant@0.9.4/lib/invariant.esm.js"
pin "ts-invariant/process/index.js", to: "https://ga.jspm.io/npm:ts-invariant@0.9.4/process/index.js"
pin "tslib", to: "https://ga.jspm.io/npm:tslib@2.3.1/tslib.es6.js"
pin "zen-observable-ts", to: "https://ga.jspm.io/npm:zen-observable-ts@1.2.3/module.js"

pin "react-pageflip", to: "https://ga.jspm.io/npm:react-pageflip@2.0.3/build/index.js"
pin "page-flip", to: "https://ga.jspm.io/npm:page-flip@2.0.7/dist/js/page-flip.browser.js"