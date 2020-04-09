var fullscreen = slate.operation("move", {
  x: "screenOriginX",
  y: "screenOriginY",
  width: "screenSizeX",
  height: "screenSizeY"
});

var big = slate.operation("move", {
  x: "screenOriginX + 20",
  y: "screenOriginY + 20",
  width: "screenSizeX - 40",
  height: "screenSizeY - 40"
});

var center = slate.operation("move", {
  x: "screenOriginX + (screenSizeX * 0.05)",
  y: "screenOriginY + (screenSizeY * 0.05)",
  width: "screenSizeX - (screenSizeX * 0.1)",
  height: "screenSizeY - (screenSizeY * 0.1)"
});

var smallCenter = slate.operation("move", {
  x: "screenOriginX + (screenSizeX * 0.1)",
  y: "screenOriginY + (screenSizeY * 0.1)",
  width: "screenSizeX - (screenSizeX * 0.2)",
  height: "screenSizeY - (screenSizeY * 0.2)"
});

var left = slate.operation("move", {
  x: "screenOriginX",
  y: "screenOriginY",
  width: "screenSizeX / 2.0",
  height: "screenSizeY"
});

var down = slate.operation("move", {
  x: "screenOriginX",
  y: "screenOriginY + (screenSizeY / 2.0)",
  width: "screenSizeX",
  height: "screenSizeY / 2.0"
});

var up = slate.operation("move", {
  x: "screenOriginX",
  y: "screenOriginY",
  width: "screenSizeX",
  height: "screenSizeY / 2.0"
});

var right = slate.operation("move", {
  x: "screenOriginX + (screenSizeX / 2.0)",
  y: "screenOriginY",
  width: "screenSizeX / 2.0",
  height: "screenSizeY"
});

var screen1 = slate.operation("move", {
  x: "screenOriginX + (screenSizeX * 0.05)",
  y: "screenOriginY + (screenSizeY * 0.05)",
  width: "screenSizeX - (screenSizeX * 0.1)",
  height: "screenSizeY - (screenSizeY * 0.1)",
  screen: "0"
});

var screen2 = slate.operation("move", {
  x: "screenOriginX + (screenSizeX * 0.05)",
  y: "screenOriginY + (screenSizeY * 0.05)",
  width: "screenSizeX - (screenSizeX * 0.1)",
  height: "screenSizeY - (screenSizeY * 0.1)",
  screen: "1"
});

slate.bindAll({
  "f:ctrl,shift": fullscreen,
  "b:ctrl,shift": big,
  "n:ctrl,shift": center,
  "m:ctrl,shift": smallCenter,
  "h:ctrl,shift": left,
  "j:ctrl,shift": down,
  "k:ctrl,shift": up,
  "l:ctrl,shift": right,
  "1:ctrl,shift": screen1,
  "2:ctrl,shift": screen2
});
