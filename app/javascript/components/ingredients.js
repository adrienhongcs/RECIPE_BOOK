import h from "components/htm_create_element"

export default function Ingredients(props) {

    const ingredients = props.ingredients

    return h`
        <ul>
            ${
                ingredients.map(ingredient => h`
                    <li>${ingredient.name} ${ingredient.measurement} mg </li>
                `)
            }
        </ul>
    `
}