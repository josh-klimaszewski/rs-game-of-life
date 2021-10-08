module R = React

open Core
open Model

@react.component
let make = () => {
  let (state, dispatch) = R.useReducer(Reducers.root, initialState)
  let handleToggleTile = R.useCallback0((y, x) => dispatch(Toggle((y, x))))
  let handleReset = R.useCallback0(_ => dispatch(Reset))
  let handleRandom = R.useCallback0(_ => dispatch(Random))
  let handleTick = R.useCallback0(_ => dispatch(Tick))
  let handleSaveGrid = R.useCallback0(_ => dispatch(Save(state.grid)))
  let handleLoadGrid = R.useCallback0(key => dispatch(Load(key)))

  Js.log(state)
  let handleToggleAutoPlay = R.useCallback2(_ => {
    let rec play = () => {
      state.animationFrameId := Util.requestAnimationFrame(play)
      dispatch(Tick)
    }
    if state.isPlaying {
      Util.cancelAnimationFrame(state.animationFrameId.contents)
      dispatch(Stop)
    } else {
      play()
      dispatch(Start)
    }
  }, (state.animationFrameId, state.isPlaying))

  <Root>
    <Header> {"Conway's Game of Life"->R.string} </Header>
    <Controls
      isPlaying=state.isPlaying
      onReset=handleReset
      onRandom=handleRandom
      onTick=handleTick
      onToggleAutoplay=handleToggleAutoPlay
      onSaveGrid=handleSaveGrid
    />
    <Grid data=state.grid onToggle=handleToggleTile />
    <SavedGrids grids=state.savedGrids onClick=handleLoadGrid />
  </Root>
}
