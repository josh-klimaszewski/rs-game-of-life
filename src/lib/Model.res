type state = {
  grid: Game.grid,
  boardSize: int,
  isPlaying: bool,
  ticks: int,
  animationFrameId: ref<int>,
  startedAt: option<float>,
  frameRate: int,
  savedGrids: array<Game.grid>,
}

type action =
  | Random
  | Reset
  | Start
  | Stop
  | Tick
  | Toggle(Game.point)
  | Save(Game.grid)
  | Load(int)
  | BoardSize(int)

let makeSeed = () => Js.Date.now()->int_of_float

let initialState = {
  grid: Game.makeRandomGrid(Config.boardSize, makeSeed()),
  boardSize: Config.boardSize,
  isPlaying: false,
  ticks: 0,
  animationFrameId: ref(0),
  startedAt: None,
  frameRate: 0,
  savedGrids: [],
}

module Reducers = {
  let grid = (self, action, state): Game.grid =>
    switch action {
    | Random => Game.makeRandomGrid(state.boardSize, makeSeed())
    | Reset => Game.makeBlankGrid(state.boardSize)
    | Tick => Game.nextGeneration(self)
    | Toggle(position) => self->Game.toggleTile(position)
    | Load(key) => state.savedGrids[key]
    | BoardSize(size) => Game.makeBlankGrid(size)
    | _ => self
    }

  let boardSize = (self, action, state): int =>
    switch action {
    | BoardSize(size) => size
    | Load(key) => state.savedGrids[key]->Js.Array.length
    | _ => self
    }

  let savedGrids = (self, action, _state): array<Game.grid> =>
    switch action {
    | Save(grid) => Belt.Array.concat(self, [grid])
    | _ => self
    }

  let isPlaying = (self, action, _state) =>
    switch action {
    | Start => true
    | Stop => false
    | _ => self
    }

  let startedAt = (self, action, _state) =>
    switch action {
    | Start => Some(Js.Date.now())
    | Stop => None
    | _ => self
    }

  let ticks = (self, action, state) =>
    switch (action, state.isPlaying) {
    | (Reset, _)
    | (Stop, _) => 0
    | (Tick, true) => self + 1
    | _ => self
    }

  let frameRate = (self, action, state) =>
    switch (action, state.startedAt) {
    | (Stop, _) => 0
    | (Tick, Some(startedAt)) => Util.avgFrameRate(state.ticks, startedAt)
    | _ => self
    }

  let root = (state, action) => {
    animationFrameId: state.animationFrameId,
    grid: grid(state.grid, action, state),
    boardSize: boardSize(state.boardSize, action, state),
    isPlaying: isPlaying(state.isPlaying, action, state),
    startedAt: startedAt(state.startedAt, action, state),
    ticks: ticks(state.ticks, action, state),
    frameRate: frameRate(state.frameRate, action, state),
    savedGrids: savedGrids(state.savedGrids, action, state),
  }
}
