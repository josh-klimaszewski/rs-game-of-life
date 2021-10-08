module Root = %styled.div(`
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100vw;
  height: 100vh;
`)

module Header = %styled.div(`
  display: flex;
  justify-content: center;
  align-items: center;
  padding-top: 2rem;
  font-weight: bold;
`)

module Icon = {
  @react.component
  let make = (~name: string) => <i className={j`fas fa-$name`} />
}

module Button = {
  @react.component
  let make = (~label, ~background, ~onClick, ~disabled=false, ~children) => {
    let transition = "all .15s ease-in"

    let className = %cx(`
        font-size: 0.9rem;
        padding: 0.5rem 0.8rem;
        background-color: $(background);
        width: 3rem;
        height: 3rem;
        color: white;
        border-radius: 50%;
        margin: 0 0.5rem;
        border-width: 0;
        user-select: none;
        outline: 0rem none white;
        font-weight: 700;
        cursor: pointer;
        transition: $(transition);
      `)

    <button ariaLabel=label className disabled onClick> children </button>
  }
}

module ToggleButton = {
  @react.component
  let make = (~isToggled, ~onClick, ~label, ~disabled=false) => {
    let background = isToggled ? #hex("666") : #hex("7A8288")
    let name = isToggled ? "pause" : "play"

    <Button label background onClick disabled> <Icon name /> </Button>
  }
}
