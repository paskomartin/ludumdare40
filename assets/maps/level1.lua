return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.18.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 25,
  height = 17,
  tilewidth = 32,
  tileheight = 32,
  nextobjectid = 23,
  properties = {
    ["enemyStep"] = "2",
    ["maxCoins"] = "16",
    ["maxEnemy"] = "20",
    ["spawnerChange"] = "4",
    ["startEnemy"] = "7"
  },
  tilesets = {
    {
      name = "tiles2",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "../sprites/tiles2.png",
      imagewidth = 256,
      imageheight = 320,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {
        {
          name = "",
          tile = -1,
          properties = {}
        }
      },
      tilecount = 80,
      tiles = {
        {
          id = 5,
          properties = {
            ["solid"] = "1"
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "floor",
      x = 0,
      y = 0,
      width = 25,
      height = 17,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["solid"] = "0"
      },
      encoding = "lua",
      data = {
        28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28,
        28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28,
        28, 28, 28, 23, 24, 28, 28, 16, 14, 14, 14, 14, 14, 15, 15, 15, 28, 28, 28, 23, 19, 24, 28, 28, 28,
        28, 28, 28, 25, 26, 28, 28, 16, 14, 14, 14, 15, 15, 15, 15, 28, 28, 28, 28, 51, 20, 52, 28, 28, 28,
        28, 28, 28, 78, 79, 28, 28, 16, 16, 16, 14, 28, 28, 28, 28, 28, 28, 28, 28, 25, 56, 26, 28, 28, 28,
        28, 28, 28, 28, 28, 28, 46, 21, 32, 21, 35, 32, 21, 45, 42, 46, 21, 21, 45, 34, 19, 33, 28, 28, 28,
        28, 28, 55, 28, 28, 28, 51, 18, 18, 67, 67, 56, 18, 33, 28, 60, 62, 63, 49, 80, 36, 49, 28, 28, 28,
        28, 28, 28, 28, 28, 28, 51, 17, 73, 72, 76, 72, 19, 52, 28, 28, 30, 28, 28, 75, 28, 28, 28, 28, 28,
        28, 28, 28, 28, 55, 28, 51, 19, 72, 76, 74, 72, 19, 52, 28, 28, 66, 28, 28, 28, 28, 28, 28, 28, 28,
        28, 28, 77, 28, 28, 28, 25, 20, 75, 77, 75, 77, 20, 26, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28,
        28, 28, 28, 28, 28, 28, 39, 19, 18, 67, 67, 19, 18, 40, 28, 29, 28, 28, 38, 37, 28, 28, 65, 28, 28,
        28, 28, 28, 30, 30, 30, 80, 50, 53, 36, 22, 62, 57, 49, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28,
        28, 28, 28, 30, 30, 29, 30, 30, 28, 66, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 41, 21, 21, 27, 28,
        28, 28, 61, 59, 28, 30, 28, 28, 28, 28, 77, 77, 28, 28, 66, 28, 28, 28, 28, 28, 34, 56, 67, 33, 28,
        28, 28, 60, 64, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 60, 54, 53, 28, 28,
        28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 65, 28, 28, 28, 28, 28,
        28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 0, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28
      }
    },
    {
      type = "tilelayer",
      name = "walls",
      x = 0,
      y = 0,
      width = 25,
      height = 17,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        12, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 13,
        10, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 11,
        5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6,
        5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6,
        5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6,
        5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6,
        5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6,
        5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6,
        5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6,
        5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6,
        5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6,
        5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6,
        5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6,
        5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6,
        5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6,
        5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6,
        8, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 9
      }
    },
    {
      type = "objectgroup",
      name = "wallObjects",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 3,
          name = "upperBounds",
          type = "",
          shape = "rectangle",
          x = -128,
          y = -96,
          width = 1056,
          height = 144,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "leftBounds",
          type = "",
          shape = "rectangle",
          x = -128,
          y = -96,
          width = 152,
          height = 800,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "rightBounds",
          type = "",
          shape = "rectangle",
          x = 775,
          y = -96,
          width = 137,
          height = 800,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 224,
          width = 128,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = -128,
          y = 535,
          width = 1056,
          height = 169,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "",
          type = "",
          shape = "rectangle",
          x = 608,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 288,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 416,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "player",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 12,
          name = "playerPosition",
          type = "",
          shape = "rectangle",
          x = 608,
          y = 480,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "spawner",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 16,
          name = "spawner1",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 96,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "spawner2",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 96,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
