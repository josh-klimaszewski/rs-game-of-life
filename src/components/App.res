module R = React

open Core
open Model

@react.component
let make = () => {
  let (
    {grid, animationFrameId, isPlaying, savedGrids, boardSize, frameRate},
    dispatch,
  ) = R.useReducer(Reducers.root, initialState)
  let handleToggleTile = R.useCallback0((y, x) => dispatch(Toggle((y, x))))
  let handleReset = R.useCallback0(_ => dispatch(Reset))
  let handleRandom = R.useCallback0(_ => dispatch(Random))
  let handleTick = R.useCallback0(_ => dispatch(Tick))
  let handleSaveGrid = R.useCallback1(_ => dispatch(Save(grid)), [grid])
  let handleLoadGrid = R.useCallback0(key => dispatch(Load(key)))
  let handleChangeBoardSize = R.useCallback0(event => {
    let intVal = ReactEvent.Form.currentTarget(event)["value"]->int_of_string
    switch intVal > Config.boardSize {
    | true => dispatch(BoardSize(Config.boardSize))
    | false => dispatch(BoardSize(intVal))
    }
  })

  let handleToggleAutoPlay = R.useCallback2(_ => {
    let rec play = () => {
      animationFrameId := Util.requestAnimationFrame(play)
      dispatch(Tick)
    }
    if isPlaying {
      Util.cancelAnimationFrame(animationFrameId.contents)
      dispatch(Stop)
    } else {
      play()
      dispatch(Start)
    }
  }, (animationFrameId, isPlaying))

  <Root>
    <Card>
      <Header> {"Conway's Game of Life"->R.string} </Header>
      <BoardSizeInput
        onChange={handleChangeBoardSize} value={boardSize->Belt.Int.toString} frameRate
      />
      <Controls
        isPlaying
        onReset=handleReset
        onRandom=handleRandom
        onTick=handleTick
        onToggleAutoplay=handleToggleAutoPlay
        onSaveGrid=handleSaveGrid
      />
      <SavedGrids grids=savedGrids onClick=handleLoadGrid />
    </Card>
    <Grid data=grid onToggle=handleToggleTile />
  </Root>
}
