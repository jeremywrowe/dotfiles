var fullscreen = slate.operation("move", {
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX",
  "height" : "screenSizeY"
});

var center = slate.operation("move", {
  "x" : "screenOriginX + (screenSizeX * 0.05)",
  "y" : "screenOriginY + (screenSizeY * 0.05)",
  "width" : "screenSizeX - (screenSizeX * 0.1)",
  "height" : "screenSizeY - (screenSizeY * 0.1)"
});

var left = slate.operation("move", {
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX / 2.0",
  "height" : "screenSizeY"
});

var down = slate.operation("move", {
  "x" : "screenOriginX",
  "y" : "screenOriginY + (screenSizeY / 2.0)",
  "width" : "screenSizeX",
  "height" : "screenSizeY / 2.0"
});

var up = slate.operation("move", {
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX",
  "height" : "screenSizeY / 2.0"
});

var right = slate.operation("move", {
  "x" : "screenOriginX + (screenSizeX / 2.0)",
  "y" : "screenOriginY",
  "width" : "screenSizeX / 2.0",
  "height" : "screenSizeY"
});

slate.bindAll({
  "b:ctrl,shift": fullscreen,
  "n:ctrl,shift": center,
  "h:ctrl,shift": left,
  "j:ctrl,shift": down,
  "k:ctrl,shift": up,
  "l:ctrl,shift": right
})