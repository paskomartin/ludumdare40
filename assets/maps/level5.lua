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
  nextobjectid = 29,
  properties = {
    ["enemyStep"] = "5",
    ["maxCoins"] = "30",
    ["maxEnemy"] = "8",
    ["spawnerChange"] = "4",
    ["startEnemy"] = "4"
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
        0, 32, 32, 32, 32, 28, 22, 22, 22, 22, 22, 22, 22, 31, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 0,
        0, 32, 32, 32, 32, 32, 28, 23, 24, 25, 24, 22, 31, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 0,
        0, 32, 32, 32, 32, 32, 32, 35, 36, 36, 36, 35, 32, 32, 32, 21, 21, 21, 21, 21, 32, 15, 14, 32, 0,
        32, 32, 32, 32, 32, 32, 34, 33, 34, 32, 32, 32, 34, 14, 14, 32, 32, 32, 32, 32, 32, 15, 15, 32, 0,
        0, 32, 14, 14, 14, 32, 34, 34, 34, 32, 32, 14, 14, 14, 34, 32, 32, 32, 32, 32, 27, 30, 15, 32, 0,
        0, 32, 32, 32, 14, 14, 34, 32, 32, 32, 32, 32, 32, 27, 23, 22, 25, 30, 32, 32, 28, 31, 32, 32, 0,
        0, 32, 32, 32, 32, 14, 32, 32, 21, 21, 21, 21, 32, 26, 22, 18, 22, 29, 32, 32, 32, 32, 32, 32, 0,
        0, 32, 32, 32, 33, 32, 32, 32, 21, 21, 21, 21, 32, 28, 23, 22, 25, 31, 21, 32, 32, 33, 32, 32, 0,
        0, 32, 32, 34, 32, 34, 32, 32, 21, 21, 21, 21, 32, 32, 35, 36, 36, 32, 21, 32, 32, 32, 32, 32, 0,
        0, 32, 32, 34, 34, 34, 32, 32, 21, 21, 21, 21, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 0,
        0, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 0,
        0, 32, 32, 32, 21, 21, 21, 21, 16, 32, 32, 32, 32, 15, 15, 14, 32, 21, 32, 32, 32, 27, 24, 30, 0,
        0, 32, 32, 32, 21, 21, 21, 21, 32, 32, 32, 15, 15, 15, 16, 16, 32, 21, 32, 32, 28, 24, 17, 24, 0,
        0, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 16, 16, 16, 32, 32, 32, 32, 32, 32, 26, 24, 29, 0,
        0, 0, 0, 0, 0, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 0
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
          id = 22,
          name = "",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 416,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 288,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 128,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 256,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 26,
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 416,
          width = 128,
          height = 64,
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
          x = 96,
          y = 128,
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
          x = 704,
          y = 448,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 256,
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
