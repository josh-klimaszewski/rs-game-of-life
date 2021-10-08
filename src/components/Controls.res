open Core

@react.component
let make = (~isPlaying, ~onReset, ~onRandom, ~onTick, ~onToggleAutoplay, ~onSaveGrid) =>
  <Wrapper>
    <div role="group">
      <Button label="Reset grid" background={#hex("AE2012")} onClick=onReset>
        <Icon name="undo" />
      </Button>
      <Button label="Random grid" background={#hex("001219")} onClick=onRandom>
        <Icon name="random" />
      </Button>
      <Button label="Next state" background={#hex("005F73")} disabled=isPlaying onClick=onTick>
        <Icon name="forward" />
      </Button>
      <ToggleButton label="Toggle autpplay" isToggled=isPlaying onClick=onToggleAutoplay />
      <Button label="Save" background={#hex("0A9396")} disabled=isPlaying onClick=onSaveGrid>
        <Icon name="save" />
      </Button>
    </div>
  </Wrapper>
