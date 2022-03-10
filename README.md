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
And finally, add `Example` to our `components` index.
```js
// app/javascript/components/index.js

import {  render } from "react-dom"
import h from "components/htm_create_element"

import Example from "components/example"


render(
    h`
        <${Example}/>
    `,
    document.getElementById("root")
)
```
Run the server using the command below and check out http://localhost:3000/ to see `Example`.
```
rails s
```
We've successfully used React and Rails 7 without transpiling!

> - [Using React with importmaps on Rails 7 (David Heinemeier Hansson)](https://www.youtube.com/watch?v=k73LKxim6tw)
> - [JSX In Depth](https://reactjs.org/docs/jsx-in-depth.html)

## GraphQL

GraphQL is a query language for your API, and a server-side runtime for executing queries. It contains of a schema in the form of a directed graph. 

A traditional REST API can bring two issues:

> - **Overfetching**: the client fetches more information than they need.  
> 
>   "Imagine for example a screen that needs to display a list of users only with their names. In a REST API, this app would usually hit the `/users` endpoint and receive a JSON array with user data. This response however might contain more info about the users that are returned, e.g. their birthdays or addresses - information that is useless for the client because it only needs to display the users’ names."
> - **Underfetching**: the client doesn't get enough information from a specific endpoint and needs to make additional requests to fetch the information they need.
> 
>   "Consider the same app which needs to display the last three followers per user. The API provides the additional endpoint `/users/<user-id>/followers`. In order to be able to display the required information, the app will have to make one request to the `/users` endpoint and then hit the `/users/<user-id>/followers` endpoint for each user."

In GraphQL, a query simply represents a sub-graph of the schema so you fetch only the data you need without any additional query effectively avoiding overfetching/underfetching.

> - [Introduction to GraphQL](https://graphql.org/learn/)
> - [GraphQL is the better REST](https://www.howtographql.com/basics/1-graphql-is-the-better-rest/)
> - [GraphQL on Rails:
From zero to the first query](https://evilmartians.com/chronicles/graphql-on-rails-1-from-zero-to-the-first-query)

## Apollo Client

"Apollo Client is a comprehensive state management library for JavaScript that enables you to manage both local and remote data with GraphQL. Use it to fetch, cache, and modify application data, all while automatically updating your UI." The main advantage is the ability to store GraphQL queries into an in-memory cache which avoids sending additional network requests.

<img width="968" alt="Screen Shot 2022-03-10 at 2 40 04 PM" src="https://user-images.githubusercontent.com/64567338/157741730-df35bbab-5a9f-4fbc-a5c4-440d6aee2e4f.png">




> - [Introduction to Apollo Client](https://www.apollographql.com/docs/react/)
> - [Caching in Apollo Client](https://www.apollographql.com/docs/react/caching/overview/)

## Rails 7, GraphQL, Apollo Client, React - Putting it Together

Let's assume we already have a Rails 7 app with models generated and database initialized. 

First, we add the [graphql-ruby](https://github.com/rmosolgo/graphql-ruby) gem.
```
bundle add graphql
rails generate graphql:install
bundle install
```
Then, create a GraphQL `Type` for each model in your app.
```
rails generate  graphql:object <model_name>
```
Lastly, add the following to allow access to the API from outside the domain while preventing [Cross-Site Request Forgery (CSRF)](https://guides.rubyonrails.org/security.html#cross-site-request-forgery-csrf).
```ruby
# app/controllers/graphql_controller.rb

class GraphqlController < ApplicationController

 protect_from_forgery with: :null_session
```
Inside `app/graphql/types/`, you can now modify each `Type` for each model in your app to your liking. There, you can also add functions you want to use to fetch your data.

You can also specify at which endpoint the GraphQL server will operate from by modifying the line below (here it's `/graphql`).
```ruby
Rails.application.routes.draw do
  ...
  post "/graphql", to: "graphql#execute"
  ...
end
```

You've now successfully set up a GraphQL server!

Let's set up Apollo Client. First let's import the required package.
```
./bin/importmap pin @apollo/client
```
Then, we create a client.
```js
// app/javascript/components/apollo_client.js

import {
    ApolloClient,
    InMemoryCache,
  } from "@apollo/client";
  
  const client = new ApolloClient({
    uri: '<your_app_uri>/graphql',
    cache: new InMemoryCache()
  });

  export default client
```
Here is how you could use Apollo Client to query from the GraphQL server inside a React component.
```js
// app/javascript/components/example.js

import {
    useQuery,
    gql
  } from "@apollo/client";
import client from "components/apollo_client"

const QUERY = gql`
  users {
    id
    followers {
      id
    }
  }
`

export default Example() {

  const { loading, error, data } = useQuery(QUERY, {  client: client })
  
  return ...
}
```
Tada, you've successfully set up Rails 7 with GraphQL, Apollo Client, and React!
# Recipe Book

## Things to Work On

- [ ] Refactor code
- [ ] Add helpful comments
- [ ] Style components (look into [Tailwind CSS](https://tailwindcss.com)?)
- [ ] Modify ingredients schema (the measurements allowed are only mg right now)
- [ ] Improve animations (turning pages should hide the pages below)
