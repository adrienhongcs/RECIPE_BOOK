import h from "components/htm_create_element"

export default function Directions(props) {

    const directions = props.directions

    return h`
        <ul>
            ${
                directions.map(direction => h`
                    <li>${direction.description}</li>
                `)
            }
        </ul>
    `
}