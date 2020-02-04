var app = Elm.Main.init({
  flags: { someField: "foo", someOtherField: 123 },
  node: document.querySelector("elm")
});
