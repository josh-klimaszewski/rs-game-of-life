module Wrapper = %styled.div(
  (~background, ~tileSize) =>
    `
    width: 10px;
    height: 10px;
    background: $(background);
    border-radius: 50%;
    margin: 2px 1px;
    padding: 0;
    transition-property: "all";
    transition-duration: .1s;
    transition-timing-function: ease-in-out;
    cursor: pointer;
  `
)

@react.component
let make = (~isAlive, ~onToggle) => {
  let aliveColor = #hex("272B30")
  let deadColor = #hex("FFF")
  let background = isAlive ? aliveColor : deadColor

  let handleMouseEvent = React.useCallback0((callback, e) =>
    if ReactEvent.Mouse.nativeEvent(e)["which"] === 1 {
      callback()
    }
  )

  <Wrapper
    background
    onMouseOver={handleMouseEvent(onToggle)}
    onMouseDown={handleMouseEvent(onToggle)}
    tileSize=Config.tileSize
  />
}
