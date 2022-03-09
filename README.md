# Preface

At the time of writing, I'm currently a college student with relatively little experience. The learning goal of this project is to prepare myself for my upcoming internship by using different frameworks and languages (React, Ruby, Rails, and GraphQL) as well as practicing my written communication. Due to the exploratory approach and my lack of experience, beware that my code may not make the best use of the frameworks or maximize efficiency.

This write-up is most similar to a journal entry rather than a tutorial or a textbook. 

# Things I've Learned

## Transpilers

> - **ECMAScript**:  the scripting language that forms the basis of JavaScript.
> - **JavaScript ES6**: the version of Javascript that is based on the 2015 version of ECMAScript.

New versions of JavaScipt offer new syntax and features. This can lead to some compatibility issues when different browsers do not yet support a version of JavaScript. **Transpilers** solve this issue by translating incompatible Javascript code into a version the browser supports.

> - [JavaScript language resources](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Language_Resources)
> - [Transpilers: How They Work and How To Build Your Own JS Transpiler (Chidume Nnamdi)](https://daily.dev/blog/transpilers-how-they-work)

## What's New with Rails 7

Prior versions of Rails used [Webpacker](https://github.com/rails/webpacker/) and [Babel](https://github.com/babel/babel) to manage and take care of transpiling and bundling JavaScript code (which added a lot of complexity). JavaScript ES6 and [HTTP2](https://developers.google.com/web/fundamentals/performance/http2) are now supported by most major browsers. The advantage of HTTP2 is that "you no longer pay a large penalty for sending many small files instead of one big file". This means that we no longer need a transpiling or bundling step (off you go Webpacker and Babel)! 

Rails 7 now uses [import maps](https://github.com/rails/importmap-rails) to import JavaScript modules directly from the browser.

> - [Modern web apps without JavaScript bundling or transpiling (David Heinemeier Hansson)](https://world.hey.com/dhh/modern-web-apps-without-javascript-bundling-or-transpiling-a20f2755)
> - [Modern JavaScript in Rails 7 without Webpack (David Heinemeier Hansson)](https://www.youtube.com/watch?v=PtxZvFnL2i0&t=1415s&ab_channel=DavidHeinemeierHansson)

## Rails 7 and React

Unfortunately, React often uses [JSX](https://reactjs.org/docs/introducing-jsx.html) which requires a transpiling step. Thankfully, we can use [htm (Hyperscript Tagged Markup)](https://github.com/developit/htm) to use JSX-like syntax without any transpiling.

First, let's set up a `components` folder to work inside our Rails 7 app.
```
rails generate controller components index
```
We can also organize the `components` path inside our import map.
```ruby
# config/importmap.rb
pin_all_from "app/javascript/components", under: "components"
```

Let's import the JavaScript modules we will need. 
```
./bin/importmap pin react react-dom htm
```
Then, we create a function by binding htm to `createElement`. Recall that each JSX element is just syntactic sugar for calling React.createElement(). We now have a function that can be used to produce objects in a JSX format.
```javascript
// app/javascript/components/htm_create_element.js

import {  createElement } from "react"
import htm from "htm"

export default htm.bind(createElement)
```
Here's a traditional React [example](https://reactjs.org/docs/hooks-intro.html):
```javascript
// app/javascript/components/example.js

import { useState } from 'react';

export default function Example() {
  // Declare a new state variable, which we'll call "count"
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>
        Click me
      </button>
    </div>
  );
}
```
Here's the modified version using htm.
```javascript
// app/javascript/components/example.js

import { useState } from 'react';

export default function Example() {
  // Declare a new state variable, which we'll call "count"
  const [count, setCount] = useState(0);

  return h`
    <div>
      <p>You clicked ${count} times</p>
      <button onClick=${() => setCount(count + 1)}>
        Click me
      </button>
    </div>
  `;
}
```
Let's now use `Example` at the root of our app. First, we define the root path.
```ruby
# config/routes.rb
root "components#index"
```
We create a root element for our `components` view.
```html
# app/views/components/index.html.erb
<div id="root"></div>
```

> - [Using React with importmaps on Rails 7 (David Heinemeier Hansson)](https://www.youtube.com/watch?v=k73LKxim6tw)
> - [JSX In Depth](https://reactjs.org/docs/jsx-in-depth.html)

## GraphQL

# Recipe Book

## Things to Work On

- [ ] Refactor code
- [ ] Add helpful comments
- [ ] Style components (look into [Tailwind CSS](https://tailwindcss.com)?)
- [ ] Modify ingredients schema (the measurements allowed are only mg right now)
- [ ] Improve animations (turning pages should hide the pages below)
