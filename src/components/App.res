open Core
module R = React

@react.component
let make = () => {
  <Root> {R.string("game-of-life")} </Root>
}
