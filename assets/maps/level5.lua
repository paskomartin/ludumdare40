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
  nextobjectid = 31,
  properties = {
    ["enemyStep"] = "2",
    ["maxCoins"] = "25",
    ["maxEnemy"] = "20",
    ["spawnerChange"] = "6",
    ["startEnemy"] = "5"
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 0,
        0, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 30, 28, 0,
        0, 28, 28, 67, 28, 30, 30, 28, 28, 30, 30, 30, 30, 28, 28, 28, 28, 28, 28, 28, 28, 28, 30, 28, 0,
        0, 28, 28, 28, 28, 30, 28, 28, 28, 28, 42, 30, 30, 30, 28, 28, 28, 28, 28, 28, 28, 30, 30, 28, 0,
        0, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 29, 30, 28, 28, 0,
        0, 28, 28, 28, 42, 28, 30, 28, 23, 24, 44, 43, 28, 28, 28, 32, 28, 30, 28, 28, 65, 28, 28, 28, 0,
        0, 28, 28, 28, 30, 30, 30, 28, 28, 28, 28, 28, 28, 28, 38, 20, 37, 71, 71, 71, 28, 28, 28, 28, 0,
        0, 28, 28, 30, 30, 30, 28, 28, 28, 28, 28, 28, 28, 28, 28, 31, 28, 71, 28, 71, 28, 28, 28, 28, 0,
        0, 28, 55, 30, 30, 28, 28, 28, 28, 28, 28, 28, 28, 29, 28, 28, 28, 71, 28, 71, 28, 28, 28, 28, 0,
        0, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 71, 71, 71, 28, 28, 28, 28, 0,
        0, 28, 28, 65, 28, 28, 28, 28, 78, 79, 78, 79, 28, 28, 28, 42, 28, 28, 28, 28, 55, 65, 66, 28, 0,
        0, 28, 28, 25, 28, 28, 28, 28, 26, 28, 28, 28, 28, 28, 28, 28, 38, 28, 37, 28, 28, 28, 32, 28, 0,
        0, 29, 28, 25, 28, 28, 28, 28, 26, 28, 28, 28, 28, 28, 65, 28, 38, 28, 37, 28, 28, 38, 56, 37, 0,
        0, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 55, 28, 28, 28, 28, 60, 28, 28, 28, 28, 31, 28, 0,
        0, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 0
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
        90, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 91,
        88, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 89,
        83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 84,
        83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 38, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 84,
        83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 77, 77, 77, 77, 77, 0, 0, 0, 0, 84,
        83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 84,
        83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 84,
        83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 84,
        83, 0, 0, 0, 0, 0, 0, 0, 72, 72, 72, 73, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 21, 0, 84,
        83, 0, 0, 0, 0, 0, 0, 0, 72, 72, 74, 72, 0, 0, 0, 0, 0, 0, 76, 0, 0, 0, 22, 0, 84,
        83, 0, 0, 20, 0, 0, 0, 0, 73, 72, 72, 72, 0, 0, 0, 0, 0, 0, 77, 0, 0, 0, 0, 0, 84,
        83, 0, 0, 0, 0, 29, 0, 0, 77, 77, 77, 77, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 84,
        83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 84,
        83, 0, 0, 0, 73, 74, 74, 73, 0, 0, 0, 0, 0, 0, 0, 0, 0, 76, 0, 0, 0, 0, 0, 0, 84,
        83, 0, 0, 0, 75, 75, 75, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75, 0, 0, 0, 0, 0, 0, 84,
        83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 84,
        86, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 87
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
          name = "soawner2",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 256,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
          name = "spawner3",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 320,
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
