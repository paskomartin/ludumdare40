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
    ["enemyStep"] = "3",
    ["maxCoins"] = "15",
    ["maxEnemy"] = "25",
    ["spawnerChange"] = "4",
    ["startEnemy"] = "5"
  },
  tilesets = {
    {
      name = "tiles",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "../sprites/tiles.png",
      imagewidth = 256,
      imageheight = 224,
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
      tilecount = 56,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 47, 23, 25, 23, 44, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 47, 24, 25, 24, 44, 32, 0,
        0, 47, 25, 20, 25, 44, 32, 32, 32, 32, 15, 32, 32, 32, 32, 32, 32, 32, 47, 25, 17, 25, 44, 32, 0,
        0, 47, 23, 25, 23, 44, 32, 32, 32, 15, 15, 32, 32, 27, 30, 15, 32, 32, 47, 24, 25, 24, 44, 32, 0,
        0, 32, 36, 35, 46, 45, 32, 48, 32, 32, 32, 14, 14, 26, 29, 34, 32, 32, 32, 46, 35, 36, 45, 14, 0,
        0, 32, 32, 34, 15, 15, 32, 32, 32, 32, 32, 32, 14, 28, 31, 16, 32, 32, 32, 32, 32, 32, 14, 14, 0,
        0, 32, 32, 32, 32, 15, 15, 32, 21, 21, 21, 21, 32, 49, 16, 32, 32, 32, 16, 21, 32, 32, 32, 14, 0,
        0, 32, 32, 32, 32, 48, 32, 32, 21, 21, 21, 21, 32, 32, 37, 37, 37, 37, 37, 37, 37, 39, 14, 32, 0,
        0, 32, 21, 32, 32, 32, 32, 32, 21, 21, 21, 21, 32, 47, 23, 23, 23, 23, 23, 23, 23, 44, 32, 32, 0,
        0, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 14, 47, 23, 24, 24, 24, 23, 24, 23, 44, 32, 32, 0,
        0, 32, 32, 32, 32, 34, 32, 27, 42, 32, 32, 33, 32, 47, 23, 23, 23, 24, 23, 23, 23, 44, 14, 32, 0,
        0, 32, 32, 15, 32, 34, 32, 28, 31, 32, 32, 32, 14, 47, 23, 23, 25, 24, 25, 23, 23, 44, 14, 32, 0,
        0, 32, 32, 32, 32, 49, 32, 32, 32, 32, 21, 21, 32, 26, 23, 23, 23, 23, 23, 23, 23, 44, 32, 32, 0,
        0, 32, 32, 32, 32, 32, 32, 15, 32, 32, 32, 32, 32, 28, 46, 36, 35, 36, 36, 36, 41, 45, 14, 32, 0,
        0, 32, 32, 32, 32, 32, 32, 15, 32, 32, 32, 32, 32, 32, 32, 32, 32, 14, 14, 43, 14, 32, 32, 32, 0,
        0, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 0, 32, 32, 32, 32, 32, 32, 32, 32, 0, 0
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
