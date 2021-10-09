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

module Wrapper = %styled.div(`
 display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
  max-width: 20rem;
  padding: 2rem 0;
`)

module Icon = {
  @react.component
  let make = (~name: string) => <i className={j`fas fa-$name`} />
}

module Button = {
  @react.component
  let make = (~label, ~background, ~onClick, ~disabled=false, ~children) => {
    let transition = "all .15s ease-in"
    let bg = disabled ? #hex("0E9D8A6") : background
    let className = %cx(`
        font-size: 0.9rem;
        padding: 0.5rem;
        background-color: $(bg);
        width: 3rem;
        height: 3rem;
        color: white;
        border-radius: 25%;
        margin: 0.5rem;
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

module BoardSizeInput = {
  @react.component
  let make = (~onChange, ~value) => {
    let inputWrapperCx = %cx(`
      display: flex;
      flex-direction: column;
      padding: 2rem 0
    `)
    let labelCx = %cx(`
      font-weight: bold;
    `)
    let inputCx = %cx(`
      border: 0.25rem solid #222;
      border-radius: 0.25rem;
      width: 3rem;
    `)
    <div className=inputWrapperCx>
      <p className=labelCx> {"Board size"->React.string} </p>
      <input className=inputCx onChange type_="number" value />
    </div>
  }
}
