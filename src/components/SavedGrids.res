open Core

@react.component
let make = (~grids: array<Game.grid>, ~onClick) => {
  let renderGridButton = React.useCallback0((index, _grid) =>
    <Button
      key={index->string_of_int}
      label="Save"
      background={#hex("94D2BD")}
      onClick={_ => {
        onClick(index)
      }}>
      <span> {(index + 1)->string_of_int->React.string} </span>
    </Button>
  )

  <Wrapper> {grids->Belt.Array.mapWithIndex(renderGridButton)->React.array} </Wrapper>
}
