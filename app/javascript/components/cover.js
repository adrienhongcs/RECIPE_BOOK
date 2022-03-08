import React from "react"
import h from "components/htm_create_element"

export const InsideCover = React.forwardRef((props,ref) => {
  return h`
      <div className="inside_cover" ref=${ref} data-density="hard">
      </div>
    `
})

export const FrontCover = React.forwardRef((props, ref) => {
    return h`
      <div className="page page-cover" ref=${ref} data-density="hard">
        <div className="page-content">
          <h1>RECIPE BOOK</h1>
          <h3>Adrien and Olivia's Favourite Recipes</h3>  
        </div>
      </div>
    `
  });

export const BackCover = React.forwardRef((props, ref) => {
    return h`
      <div className="page page-cover" ref=${ref} data-density="hard">
        <div className="page-content">
          <h1>THE END</h1>
        </div>
      </div>
    `
  });
