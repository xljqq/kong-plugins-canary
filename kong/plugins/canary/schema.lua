---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2020/2/21 10:18
---
local typedefs = require "kong.db.schema.typedefs"
local string_array = {
  type = "array",
  default = {},
  elements = { type = "string" },
}

local colon_string_array = {
  type = "array",
  default = {},
  --elements = { type = "string", },
  elements = typedefs.cidr_v4,
}

local one_of = {
  type = "string",
  default = "header",
  one_of = { "header", "cookie", 'args' }
}

local ip_canary_record = {
  type = "record",
  fields = {
    { range = colon_string_array },
    { upstream = { type = "string" } },
  },
}

local uid_canary_record = {
  type = "record",
  fields = {
    { on = one_of },
    { name = { type = "string", default = "uid" } },
    { range = string_array },
    { upstream = { type = "string" } },
  }
}

local canary_on_record = {
  type = "record",
  fields = {
    { on = one_of },
    { name = { type = "string", } },
    { range = string_array },
    { upstream = { type = "string" } },
  }
}

return {
  name = "canary",
  fields = {
    { run_on = typedefs.run_on_first },
    { protocols = typedefs.protocols_http },
    { config = {
      type = "record",
      fields = {
        { canary_upstream = { type = "string", len_min = 1, required = true }, },
        { ip = ip_canary_record },
        { uid = uid_canary_record },
        { customize = canary_on_record },
      },
    },
    },
  },
}