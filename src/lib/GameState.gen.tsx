/* TypeScript file generated from GameState.res by genType. */
/* eslint-disable import/first */


import type {grid as Game_grid} from './Game.gen';

import type {point as Game_point} from './Game.gen';

// tslint:disable-next-line:interface-over-type-literal
export type state = {
  readonly grid: Game_grid; 
  readonly isPlaying: boolean; 
  readonly ticks: number; 
  readonly animationFrameId: {
    contents: number
  }; 
  readonly startedAt?: number; 
  readonly frameRate: number
};

// tslint:disable-next-line:interface-over-type-literal
export type action = 
    "Random"
  | "Reset"
  | "Start"
  | "Stop"
  | "Tick"
  | Game_point;
