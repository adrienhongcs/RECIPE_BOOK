import React from "react"
import h from "components/htm_create_element"
import Ingredients from "components/ingredients";
import Directions from "components/directions";

export const BlankPage = React.forwardRef((props, ref) => {

    if (!props.show) return h``

    return h`
      <div className="page" ref=${ref}> 
      </div>
    `;
  });

const Page = React.forwardRef((props, ref) => {

    const recipe = props.recipe

    return h`
      <div className="page" ref=${ref}> 
        <h1>${recipe.name}</h1>
        <div className="page_content">
            <${Ingredients} ingredients=${recipe.ingredients}/>
            <${Directions} directions=${recipe.directions}/>
        </div>
        <p>Page number: ${props.number}</p>
      </div>
    `;
  });

export default Page