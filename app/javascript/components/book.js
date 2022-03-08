import HTMLFlipBook from 'react-pageflip';
import h from "components/htm_create_element"
import { useRef }  from 'react'
import Page, {BlankPage} from 'components/page'
import {FrontCover, InsideCover, BackCover} from 'components/cover'

import {
    useQuery,
    gql
  } from "@apollo/client";
import client from "components/apollo_client"

const RECIPES = gql`
    query GetRecipes {
        recipes {
            name
            ingredients {
                name
                measurement
            }
            directions {
                description
            }

        }
    }
`
  
export default function Book(props) {

    const book = useRef()

    function flipPrev() {
        book.current.pageFlip().flipPrev()
    }

    function flipNext() {
        book.current.pageFlip().flipNext()
    }


    const { loading, error, data } = useQuery(RECIPES, {  client: client })

    if (loading) return  h`<p>Loading...</p>`
    if (error) return h`<p>Error :(</p>`

    return h`
        <div>
            <${HTMLFlipBook} 
                width=${550}
                height=${733}
                size="stretch"
                minWidth=${315}
                maxWidth=${1000}
                minHeight=${400}
                maxHeight=${1533}
                maxShadowOpacity=${0.5}
                showCover=${true}
                mobileScrollSupport=${true}
                ref=${book}
            >
                <${FrontCover}/>
                <${InsideCover}/>
                ${data.recipes.map( (recipe, index) => h`
                    <${Page} recipe=${recipe} number=${index+1}/>
                    <${Page} recipe=${recipe} number=${index+1}/>
                    <${Page} recipe=${recipe} number=${index+1}/>
                    <${Page} recipe=${recipe} number=${index+1}/>
                    <${Page} recipe=${recipe} number=${index+1}/>
                `)}
                <${BlankPage} show=${data.recipes.length != 0}/>
                <${InsideCover}/>
                <${BackCover}/>

            </${HTMLFlipBook}>

            <div className="container">

                <button type="button" onClick=${flipPrev}>
                    Previous page
                </button>

                <button type="button" onClick=${flipNext}>
                    Next page
                </button>
          </div>

        </div>
    `
}