import {
    ApolloClient,
    InMemoryCache,
  } from "@apollo/client";
  
  //TODO: set up proxy
  const client = new ApolloClient({
    uri: 'http://localhost:3000/graphql',
    cache: new InMemoryCache()
  });

  export default client