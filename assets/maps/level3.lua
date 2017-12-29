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
  nextobjectid = 35,
  properties = {
    ["enemyStep"] = "4",
    ["maxCoins"] = "20",
    ["maxEnemy"] = "30",
    ["spawnerChange"] = "4",
    ["startEnemy"] = "8"
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
      imageheight = 384,
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
      tilecount = 96,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 82, 82, 82, 82, 82, 0, 0, 0, 0, 0, 0, 0,
        0, 2, 2, 2, 46, 21, 21, 21, 45, 2, 2, 2, 2, 2, 2, 2, 2, 61, 21, 21, 21, 21, 21, 27, 0,
        0, 2, 16, 16, 25, 20, 18, 20, 26, 16, 16, 16, 16, 16, 16, 16, 16, 51, 19, 17, 17, 19, 18, 52, 0,
        0, 2, 16, 16, 51, 18, 56, 18, 26, 16, 28, 28, 28, 28, 28, 55, 28, 51, 20, 17, 67, 19, 18, 52, 0,
        0, 2, 16, 16, 25, 20, 18, 20, 76, 16, 65, 28, 28, 28, 28, 16, 28, 51, 19, 19, 17, 19, 18, 52, 0,
        0, 2, 16, 2, 39, 57, 48, 58, 73, 16, 28, 28, 77, 77, 77, 16, 28, 80, 54, 75, 75, 75, 57, 49, 0,
        0, 2, 16, 2, 16, 28, 28, 16, 75, 16, 28, 28, 54, 36, 53, 28, 28, 16, 16, 68, 68, 68, 16, 2, 0,
        0, 2, 16, 16, 15, 14, 14, 16, 16, 16, 16, 28, 28, 23, 24, 28, 2, 16, 16, 14, 14, 16, 16, 2, 0,
        0, 2, 16, 16, 16, 16, 14, 14, 14, 14, 14, 16, 16, 25, 26, 2, 16, 16, 16, 16, 16, 16, 16, 2, 0,
        0, 2, 16, 16, 75, 75, 75, 16, 16, 16, 16, 76, 16, 78, 79, 14, 14, 16, 16, 16, 16, 16, 16, 2, 0,
        0, 2, 16, 16, 71, 56, 71, 16, 16, 16, 16, 74, 16, 14, 28, 28, 14, 77, 77, 77, 16, 16, 16, 2, 0,
        0, 2, 16, 28, 28, 28, 16, 28, 16, 16, 16, 77, 16, 16, 16, 66, 16, 16, 78, 79, 16, 16, 16, 2, 0,
        0, 2, 16, 28, 28, 28, 28, 28, 28, 28, 28, 46, 35, 45, 28, 28, 2, 16, 16, 16, 55, 16, 16, 2, 0,
        0, 2, 16, 16, 28, 28, 28, 28, 14, 14, 14, 51, 20, 52, 16, 28, 28, 16, 16, 2, 2, 16, 16, 2, 0,
        0, 2, 16, 16, 28, 28, 16, 16, 16, 16, 16, 80, 31, 49, 16, 16, 16, 16, 16, 16, 16, 16, 16, 2, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          x = 256,
          y = 160,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 320,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 27,
          name = "",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 320,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 192,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "",
          type = "",
          shape = "rectangle",
          x = 608,
          y = 192,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 31,
          name = "",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 352,
          width = 96,
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
          x = 96,
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
          id = 32,
          name = "",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 448,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 128,
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
