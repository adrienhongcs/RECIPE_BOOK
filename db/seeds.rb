cookie = Recipe.create!(
    name: "cookie"
)

Ingredient.create!(
    [
        {
            name: "flour",
            measurement: "120",
            recipe: cookie
        },
        {
            name: "chocolate",
            measurement: "100",
            recipe: cookie
        },
        {
            name: "sugar",
            measurement: "200",
            recipe: cookie
        }
    ]
)

Direction.create!(
    [
        {
            description: "Wet ingredients.",
            recipe: cookie
        },
        {
            description: "Dry ingredients.",
            recipe: cookie 
        },
        {
            description: "Bake 350F for 10 minutes.",
            recipe: cookie
        },
    ]
)
