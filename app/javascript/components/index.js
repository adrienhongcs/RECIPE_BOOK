import {  render } from "react-dom"
import h from "components/htm_create_element"

import Book from "components/book"

render(
    h`
    <${Book}/>
    `,
    document.getElementById("root")
)